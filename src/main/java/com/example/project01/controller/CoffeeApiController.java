package com.example.project01.controller;

import com.example.project01.dao.CustomerDAO;
import com.example.project01.dao.ProductDAO;
import com.example.project01.dao.PurchaseDAO;
import com.example.project01.dao.PurchaseDetailDAO;
import com.example.project01.dto.CustomerTO;
import com.example.project01.dto.ProductTO;
import com.example.project01.dto.PurchaseDetailTO;
import com.example.project01.dto.PurchaseTO;
import com.example.project01.enums.OrderStatus;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.*;

@RestController
@RequestMapping("/api")
public class CoffeeApiController {

    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private CustomerDAO customerDAO;
    @Autowired
    private PurchaseDAO purchaseDAO;
    @Autowired
    private PurchaseDetailDAO purchaseDetailDAO;

    @GetMapping("/productList")
    public ArrayList<ProductTO> productList() {
        return productDAO.productAll();
    }

    @GetMapping("/cartList")
    public ArrayList<ProductTO> cartList(@RequestParam String pidArray) {

        ArrayList<ProductTO> cartList = new ArrayList<>();

        // Json 문자열을 list로 변환하는 로직
        ObjectMapper om = new ObjectMapper();
        try {
            // JSON 문자열을 List로 변환
            List<Integer> pidList = om.readValue(pidArray, List.class);
            cartList = productDAO.findProduct(pidList);

        } catch (Exception e) {
            System.out.println("[에러] " + e.getMessage());
        }

        return cartList;
    }

    @PostMapping("/join")
    public String join(HttpServletRequest request) {

        CustomerTO to = new CustomerTO();
        to.setEmail(request.getParameter("email"));
        to.setPwd(request.getParameter("pwd"));
        to.setAddr(request.getParameter("addr"));
        to.setZip(request.getParameter("zip"));

        String joinCk = customerDAO.emailCheck(to);

        return String.format("{\"joinCk\": \"%s\"}", joinCk);
    }

    @PostMapping( "/login")
    public String login(HttpServletRequest request) {

        CustomerTO to = new CustomerTO();
        to.setEmail(request.getParameter("email"));
        to.setPwd(request.getParameter("pwd"));

        int cid = customerDAO.loginCheck(to);

        return String.format("{\"cid\": \"%s\"}", cid);
    }

    // 로그인 성공 시, 세션 재생성 및 cid 삽입 로직
    @PostMapping("/emailSaveSession")
    public String emailSaveSession(HttpServletRequest request, HttpSession session) {

        HttpSession ordSession = request.getSession(false);     // false : 세션이 존재하면 반환하고, 없으면 null을 반환합니다.

        if (ordSession != null) { ordSession.invalidate(); }   // 기존 세션 무효화

        HttpSession newSession = request.getSession(true);      // true : 세션이 존재하지 않으면 새로운 세션을 생성하고 반환

        String cid = request.getParameter("cid");
        newSession.setAttribute("cid", cid);

        return String.format("{\"sessionStatus\": \"%s\"}", "success");
    }

    // 세션에 로그인 정보가 있는지 확인
    @GetMapping("/loginSessionCheck")
    public String loginSessionCheck(HttpSession session) {

        String loginStatus = "loginNo";

        String cid = (String) session.getAttribute("cid");

        if (cid != null) { loginStatus = "loginYes";}

        return String.format("{\"loginStatus\": \"%s\"}", loginStatus);
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return String.format("{\"logoutStatus\": \"%s\"}", "success");
    }

    @GetMapping("/userData")
    public String userData(HttpSession session) {

        CustomerTO to = new CustomerTO();
        to.setCid((String) session.getAttribute("cid"));

        to = customerDAO.selectUser(to);

        String email = to.getEmail();
        String addr = to.getAddr();
        String zip = to.getZip();

        return String.format("{\"email\": \"%s\", \"addr\": \"%s\", \"zip\": \"%s\", \"selectStatus\": \"%s\" }", email, addr, zip, "success");
    }

    // 구매 카드 생성 및 생성 여부 반환
    @PostMapping("/createPurCart")
    public String createPurCart(HttpServletRequest request, HttpSession session) {
        String createStatus = "failure";        // 기본 상태 값 = 실패

        PurchaseTO to = new PurchaseTO();                    // 구매 박스 객체

        // 구매 박스 객체에 데이터 삽입
        to.setCid(session.getAttribute("cid").toString());
        to.setAddr(request.getParameter("addr"));
        to.setZip(request.getParameter("zip"));
        to.setSt("PENDING");    // 주문 상태 enum 상수 삽입 ( 기본값 : 배송 대기 )

        // ot 필드에 현재 일시 삽입
        // 현재 일시 호출
        Timestamp now = new Timestamp(System.currentTimeMillis());
        to.setOt(now);    // 주문 시간에 현재 일시 삽입

        // sst 필드에 변경된 일시 삽입
        // 배송 날짜 삽입 로직
        Date date = new Date(now.getTime());             // 현재 주문 날짜
        Time purTime = new Time(now.getTime());          // 현재 주문 시간
        Time deliTime = Time.valueOf("14:00:00");     // 당일 배송 커트라인 시간

        // 현재 주문 시간이 당일 배송 시간(커트라인)을 넘겼을 경우 = true
        Timestamp sst;
        if( purTime.after(deliTime)) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);                       // 현재 Date 삽입 - 시간은 자동 삽입
            cal.add(Calendar.DATE, 1);      // Date 부분에만 하루 추가

            Date nextDay = new Date(cal.getTimeInMillis());     // 하루 추가된 일시에 Date만 출력
            sst = Timestamp.valueOf(nextDay + " " + deliTime);

        } else { sst = Timestamp.valueOf(date + " " + deliTime); }

        to.setSst(sst);         // 계산된 배송 날짜 삽입

        // 구매 상자 생성 및 pid 필드 값 자동 생성 ( mapper 부분 설정을 통해, insert 전에 to 객체 pid 필드 값 자동 생성됨 )
        int flag = purchaseDAO.createPurCart(to);

        // 구매 박스 생성 실패 시, 실패 상태 반환
        if (flag == 0) return String.format("{\"createStatus\": \"%s\"}", createStatus);

        // 구매 상자에 세부 상품 넣기 ( 상품 데이터, cid, pid 정보도 같이 보냄 )
        int prodInStatus = prodInPur(request, session, to.getPid());
        // 구매 상자에 세부 상품 넣기 실패 시, 실패 상태 반환
        if (prodInStatus == 0) return String.format("{\"createStatus\": \"%s\"}", createStatus);

        // 모든 트랜잭션 성공 시, 성공 문구 반환
        createStatus = "success";

        // 편의성을 위해 주문 시간과 배송 시간을 반환
        return String.format("{\"createStatus\": \"%s\", \"purTime\": \"%s\", \"deliTime\": \"%s\"}", createStatus, now, sst);
    }

    // 구매 박스에 상품 넣기 ( 상품 박스 생성 완료 시, 실행 )
    public int prodInPur(HttpServletRequest request, HttpSession session, String pid) {
        int prodInStatus = 1;

        // 구매 상품 객체에 데이터 삽입
        String prodArray = request.getParameter("prodArray");       // Json Array 형식의 상품 데이터 가져오기( 상품 id, 상품 개수, 상품 총 금액 )
        ObjectMapper om = new ObjectMapper();
        try {
            // JSON 문자열을 List로 변환
            List<Map<String, String>> prodList = om.readValue(prodArray, List.class);

            for( Map prod : prodList ) {
                PurchaseDetailTO detailTO = new PurchaseDetailTO();            // 구매 상품 객체
                detailTO.setPid(pid);                                          // 구매 박스 id
                detailTO.setCid(session.getAttribute("cid").toString());    // 사용자 id

                detailTO.setPrd_id(prod.get("prd_id").toString());
                detailTO.setQty(prod.get("number").toString());
                detailTO.setPrice(prod.get("totalPrice").toString());

                int flag = purchaseDetailDAO.createPurDt(detailTO);

                if (flag == 0) {
                    prodInStatus = 0;
                    break;
                }
            }
        } catch (Exception e) { System.out.println("[에러] " + e.getMessage()); }
        return prodInStatus;
    }

    // 시간 확인용 테스트 함수
//    @GetMapping("/time")
    public String time() {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        Time purTime = new Time(now.getTime());
        Date purDate = new Date(now.getTime());
        System.out.println("now : " + now);
        System.out.println("purTime : " + purTime);
        System.out.println("purDate : " + purDate);
        Time delTime = Time.valueOf("14:00:00");

        if( purTime.after(delTime)) {
            System.out.println("상품 시간이 배송 시간을 넘었다. 다음 날 배송으로");
        } else {
            System.out.println("상품 시간이 배송 시간 이전이다. 당일 배송으로");
        }

        return String.format("{\"time\": \"%s\"}", now);
    }

    // enum 사용법 테스트 함수
//    @GetMapping("/enum")
    public String enums() {
        // enum에서 특정 상수를 갖는 객체 생성
        OrderStatus os = OrderStatus.PENDING;
        // enum의 특정 상수를 문자열로 받기
        String osString = os.toString();
        // 문자열 타입의 상수를 enum의 상수로 다시 바꿔줌
        OrderStatus osEnum = OrderStatus.valueOf(osString);
        OrderStatus osEnum2 = OrderStatus.valueOf("PENDING");

        System.out.println(osEnum2);

        return String.format("{\"enum\": \"%s\"}", "enum");
    }

    //세션 방식 ( 사용 보류 )
//    @PostMapping("/cart")
    public String cartInSession(HttpSession session, HttpServletRequest request) {

        String pid = request.getParameter("pid");
        int num = Integer.parseInt(request.getParameter("num"));

        HashMap<String, ProductTO> map = (HashMap<String, ProductTO>) session.getAttribute("productMap");

        if (map == null) {
            // 세션에 productMap 없으면 새로 생성
            map = new HashMap<>();
        }

        if (!map.containsKey(pid)) {

            // productMap에 해당 상품이 없을 경우, 새로 생성
            ProductTO to = new ProductTO();
            to.setPid(pid);       // pid 설정
//            to.setPickNum(num);   // 수량 설정
            map.put(pid, to);

        } else {
            // productMap에 해당 상품이 있을 경우, 상품 수량 업데이트
            ProductTO to = map.get(pid);
//            to.setPickNum(num);   // 수량 업데이트
            map.put(pid, to);     // 수정된 값 다시 저장
        }
        // 업데이트한 productMap를 세션에 저장
        session.setAttribute("productMap", map);
        // 장바구니에 담은 상품 갯수
//        session.setAttribute("mapSize", map.size());
        String cartCount = String.valueOf(map.size());

        return "{ \"cartCount\" : " + cartCount + " }";
    }

}
