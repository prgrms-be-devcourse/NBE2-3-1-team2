<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.project01.dto.ProductTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	ArrayList<ProductTO> lists = (ArrayList<ProductTO>) request.getAttribute("lists");

	System.out.println(lists);

	StringBuilder sbHtml = new StringBuilder();

	for( ProductTO to : lists ) {

		String pid = to.getPid();
		String img = to.getImg();
		String name = to.getName();
		String cat = to.getCat();
		String stk = to.getStk();
		String price = to.getPrice();

		sbHtml.append("<li class='list-group-item d-flex align-items-center'>");
		sbHtml.append("<div>");
		sbHtml.append("<img class='product-img' src=./images/"+ img + ">");
		sbHtml.append("</div>");
		sbHtml.append("<div class='col'>");
		sbHtml.append("<div class='text-muted'>" + cat + "</div>");
		sbHtml.append("<div>" + name +"</div>");
		sbHtml.append("</div>");
		sbHtml.append("<div class='px-3 text-center'>" + price +"원</div>");
		sbHtml.append("<div class='px-3 num-input-div'>");
		sbHtml.append("<input type='text' class='num-input' id='input" + pid + "' value='1'>");
		sbHtml.append("<div class='num-btn'>");
		sbHtml.append("<button class='inc' onclick='updateValue(this,1)' />");
		sbHtml.append("<button class='dec' onclick='updateValue(this,-1)' />");
		sbHtml.append("</div>");
		sbHtml.append("</div>");
		sbHtml.append("<div class='text-end'>");
		sbHtml.append("<button class='btn btn-outline-dark' onclick='createToastMsg(\"input" + pid + "\")'>담기</button>");
		sbHtml.append("</div>");
		sbHtml.append("</li>");
	}

%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- style.css -->
	<link rel="stylesheet" href="./css/style.css">
	<!-- bootstrap.css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
	<title>Grids & Circle</title>
	<script type="text/javascript">

	</script>
</head>

<body>
	<div class="container-fluid my-4">
		<header class="d-flex justify-content-between align-items-center mb-3">
			<div>
				<a href="">
					<img class="brand-logo" src="./images/brand_logo.png">
				</a>
			</div>
			<div class="d-flex">
				<a href="./order.do" class="purchase quick-link">
					<img class="mx-auto" src="./images/purchase.png" width="28" height="28">
					<span class="cart-title">주문내역</span>
				</a>
				<a href="./cartview.do" class="cart quick-link">
					<img class="mx-auto" src="./images/cart.png" width="28" height="28">
					<span class="cart-title">장바구니</span>
					<em class="cart-count" id="cart-counter">0</em>
				</a>
				<div class="login-btn-div">
					<a class="btn btn-outline-dark login-btn" href="./login.do">로그인</a>
				</div>
			</div>
		</header>
		<hr>
		<main class="card">
			<div class="row">
				<div class="col-md d-flex flex-column align-items-start py-3 px-4">
					<div class="w-100">
						<h5>상품 목록</h5>
						<hr>
					</div>
					<ul class="list-group products">
						<%=sbHtml.toString()%>
					</ul>
				</div>
			</div>
		</main>
		<div id="toast-container">
		</div>
	</div>

	<script>
		// 숫자 증가/감소 로직
		function updateValue(button, change) {
			const input = button.closest('.num-input-div').querySelector('.num-input');
			let curValue = parseInt(input.value, 10) || 0; // 값이 없으면 0으로 초기화
			curValue += change;
			if (curValue < 1) curValue = 1; // 최소값 제한
			input.value = curValue;
		}

		// 숫자 이외의 값 입력 방지
		document.querySelectorAll(".num-input").forEach(input => {
			input.addEventListener("input", function () {
				this.value = this.value.replace(/[^0-9]/g, ""); // 숫자가 아닌 문자 제거
			});
		});

		function createToastMsg(msg) {
			console.log(msg)
			const toast = document.createElement("div");
			toast.classList.add("toast-msg");
			toast.classList.add("hide");
			toast.textContent = msg + ' : 토스트 메세지 확인';
			console.log(msg + ' 3')

			// 토스트 컨테이너에 추가
			const toastContainer = document.getElementById("toast-container");
			toastContainer.appendChild(toast);
			setTimeout(() => toast.classList.remove("hide"), 500); 

			// 3초 후에 메시지를 사라지게 하고 DOM에서 제거
			setTimeout(() => {
				toast.classList.add("hide");
				setTimeout(() => toast.remove(), 500); // 애니메이션이 끝난 후 제거
			}, 2000);
		}
	</script>
</body>
</html>