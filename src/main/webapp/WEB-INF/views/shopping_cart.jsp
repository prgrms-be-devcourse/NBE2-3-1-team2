<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- bootstrap.css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
	<!-- style.css -->
	<link rel="stylesheet" href="./css/style.css">
	<title>Grids & Circle</title>
</head>

<body>
	<div class="container-fluid my-4">
		<header class="d-flex justify-content-between align-items-center mb-3">
			<div>
				<a href="/main.do">
					<img class="brand-logo" src="./images/brand_logo.png">
				</a>
			</div>
			<div class="d-flex">
				<a href="/order.do" class="purchase quick-link">
					<img class="mx-auto" src="./images/purchase.png" width="28" height="28">
					<span class="cart-title">주문내역</span>
				</a>
				<a href="/cartview.do" class="cart quick-link">
					<img class="mx-auto" src="./images/cart.png" width="28" height="28">
					<span class="cart-title">장바구니</span>
					<em class="cart-count" id="cart-counter"></em>
				</a>
				<div class="login-btn-div">
					<a class="btn btn-outline-dark login-btn" href="/login.do">로그인</a>
				</div>
			</div>
		</header>
		<hr>
		<main class="card cart-card">
			<div class="row">
				<div class="col d-flex flex-column align-items-start py-3 px-4">
					<div class="w-100">
						<h5>장바구니</h5>
						<hr>
					</div>
					<div class="d-flex w-100 cart-container">
						<ul class="list-group products col">

						</ul>
						<div class="mx-3 purchase-form">
							<hr>
							<div class="d-flex justify-content-between mt-2">
								<span>총 금액</span>
								<span id="total-price"></span>
							</div>
							<hr>
							<form action="" method="post">
								<div class="form-floating mb-2">
									<input type="email" class="form-control" id="id-input" readonly>
									<label for="id-input">Email@Example.com</label>
								</div>
								<div class="form-floating mb-2">
									<input type="text" class="form-control" id="address-input" placeholder="충청북도 청주시 청원구 오창읍 000-0">
									<label for="address-input">Address</label>
								</div>
								<div class="form-floating mb-2">
									<input type="text" class="form-control" id="zipcode-input" placeholder="00000">
									<label for="zipcode-input">Zip Code</label>
								</div>
								<div class="mt-5">
									<button class="btn btn-dark w-100" type="submit">주문하기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<script src="/js/session.js"></script>
	<script type="text/javascript">
		var jsonData = [];
		let totalPrice = 0;
		window.onload = function () {

			checkSession();
			setupLinks();
			customerInfo();
			loadCart();

			// purchaseInfo();

			customerPurchased()

		};

		// =============== 구매내역을 위한 정보 뽑기 ===========
		function purchaseInfo() {

			// customerData -> cid
			// loadCart -> prd_id
			// pid(purchase) -> select 구문 필요 -> // purchase insert -> purchase select -> purchase insert -> reset
			// calculator total -> qty, price -> (prd_id에 따른 수량 html 에서 가져오기) 하고 가져오기

			// console.log("c_cid", customerData.cid); // customerInfo 내부에서 선언시, 출력됨(비동기 처리여서 그럼), 일단 진행

			// pid, cid를 insert 된 purchase 에서 select --> 이걸 어떻게 알지(?) -> 서버 응답에 pid, cid 를 담을 수 없나?
			/// ->  만약 동시에 넣으면 어떤식으로 들어가지는거지

			console.log(prd);
			// key : { price(가격), qty(수량) };

		}


		let customerData = {};
		// =============== 고객 정보 불러오기 ===========================
		function customerInfo() {
			const request = new XMLHttpRequest();
			request.open("POST", "/api/customerInfo", true);
			request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
			request.onreadystatechange = function () {
				if (this.readyState === 4) {
					if (this.status === 200) {
						customerData = JSON.parse(request.responseText);
						console.log("Customer Info:", customerData);

						document.getElementById("id-input").value = customerData.email;
						document.getElementById('address-input').value = customerData.addr;
						document.getElementById('zipcode-input').value = customerData.zip;

						// p_cid = customerData.cid;
						// purchaseInfo();
					}
				}
			};

			request.send();
		}

		// =============== 구매 정보 저장하기 -> 결제하기 클릭시 데이터 저장 ==========
		let formattedDate;
		function customerPurchased() {

			const purchaseButton = document.querySelector('form button');
			purchaseButton.onclick = function (event) {
				event.preventDefault();

				// DTO 안에 cid로 들어가야되는데 id있어서 계속 오류났음,,, 오타 조심
				cid = customerData.cid;

				orderTime();

				zipcode = document.getElementById('zipcode-input').value;
				address = document.getElementById('address-input').value;
				state = "배송대기";

				if (zipcode.length != 5) {
					alert("우편번호는 5자 입니다");
					return;
				}

				// 이게 함수 안에 안들어있었음
				const request = new XMLHttpRequest();

				request.onreadystatechange = function () {
					if (this.readyState === 4) {
						if (this.status === 200) {
							//purchaseInfo();
							//console.log("서버 응답 : ", request.responseText);
							const response = JSON.parse(request.responseText);

							purchaseDetail(response, prd)

							//console.log("purchase: ", response.pid);
							//console.log("purchase: ", response.cid);
							//console.log(prd);

							alert("주문 완료")
							window.localStorage.clear();
							window.location.href = "/main.do";
						} else {
							alert("주문 실패")
						}
					}
				};
				const requestData = JSON.stringify({
					cid: cid,
					addr: address,
					sst: formattedDate,
					zip: zipcode,
					addr: address,
					st: state
				});
				console.log(requestData);

				request.open('POST', '/api/purchase', true);
				request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
				request.send(requestData);
			}
		}
		// ========= 주문 내역 ============
		function purchaseDetail(response, prd) {
			console.log("purchase: ", response.pid);
			console.log("purchase: ", response.cid);
			console.log(prd);

			const p_pid = response.pid;
			const p_cid = response.cid;

			// 반복문쓰면 중복해서 데이터 삽입된다는 sql 오류 발생
			// 하나넣고 서버로 옮겨지고를 반복해서 효율도 좋지 않음
			// prd 객체를 배열로 변환
			const requestData = Object.keys(prd).map(p_prd => {
				const p_product = prd[p_prd];
				const p_qty = p_product.qty;
				const p_price = p_product.price * p_qty;

				return {
					pid: p_pid,
					cid: p_cid,
					prd_id: parseInt(p_prd),
					qty: p_qty,
					price: p_price
				};
			});



			// 한 번에 서버로 전송
			const request = new XMLHttpRequest();
			request.open("POST", "/api/purchaseDetail", true);
			request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
			request.onreadystatechange = function () {
				if (this.readyState === 4) {
					if (this.status === 200) {
						console.log("purchase_detail success");
					} else {
						console.log("error purchase_detail insert");
					}
				}
			};
			const jsonData = JSON.stringify(requestData);
			console.log("Final Request Data: ", jsonData);
			request.send(jsonData);
		}


		// ========= 배송 시간 로직 (2시) =============
		function orderTime() {
			const currentDate = new Date();

			// 기준 시간 (오후 2시) 생성
			const twoPM = new Date(currentDate);
			twoPM.setHours(14, 0, 0, 0); // 오후 2시로 설정

			const padZero = (num) => (num < 10 ? "0" + num : num); // 숫자를 두 자리로 포맷팅

			if (currentDate < twoPM) {
				// 현재 시간이 오후 2시 이전인 경우: 당일 오후 2시
				formattedDate = `\${twoPM.getFullYear()}-\${padZero(twoPM.getMonth() + 1)}-\${padZero(twoPM.getDate())} 14:00:00`;
			} else {
				// 현재 시간이 오후 2시 이후인 경우: 다음날 오후 2시
				const nextDayTwoPM = new Date(twoPM);
				nextDayTwoPM.setDate(twoPM.getDate() + 1); // 다음날로 이동
				formattedDate = `\${nextDayTwoPM.getFullYear()}-\${padZero(nextDayTwoPM.getMonth() + 1)}-\${padZero(nextDayTwoPM.getDate())} 14:00:00`;
			}
		}



		// =============== 장바구니 데이터 데이터 불러오기 ==============
		function loadCart() {
			//localstorage 에서 pid 받아오기
			let existingCart = JSON.parse(localStorage.getItem('cart')) || {}; // localStorage에서 값 가져오기
			//장바구니 아이콘에 표시하기
			let productCount = Object.keys(existingCart).length;
			document.getElementById('cart-counter').innerHTML = productCount;

			// productId 데이터 생성 방식(객체형식을 따르도록, pid를 int로 변환하고, 객체로 감싸 서버 전송)
			var productId = Object.keys(existingCart).map(pid => ({ pid: parseInt(pid) }));

			console.log("productId : ", productId);

			const request = new XMLHttpRequest();
			request.open("POST", "/api/cartview", true); // api 경로(아래로 하면 헤더 누락)
			request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');

			request.onreadystatechange = function () {
				if (this.readyState == 4) {
					if (this.status == 200) {
						jsonData = JSON.parse(request.responseText.trim());
						renderCart(jsonData, existingCart);
						calculateTotal();
					}
				}
			};
			// 서버로 전송되는 데이터 형식(객체 배열)
			request.send(JSON.stringify(productId));
		}

		// =============== 장바구니 아이템 렌더링 ================
		// let quantity;
		function renderCart(jsonData, existingCart) {
			let result = ``;
			jsonData.forEach(list => {
				// 특정 pid의 수량 가져오기
				let quantity = existingCart[list.pid] || 1;
				// 숫자 증감 localstorage 에 적용 data-product-id 넣기
				result += `<li class="list-group-item d-flex align-items-center position-relative" data-product-id="\${list.pid}">
							<div>
								<img class="product-img" src="./images/\${list.img}">
							</div>
							<div class="col">
								<div class="text-muted">\${list.cat}</div>
								<div>\${list.name}</div>
							</div>
							<div class="px-3 text-center">\${list.price}</div>
							<div class="px-3 num-input-div">
								<!-- quantity 적용 -->
								<input type="text" class="num-input" value="\${quantity}"/>
									<div class="num-btn">
										<button class="inc" onclick="updateCart(this,1)" /> <!-- Up Arrow -->
										<button class="dec" onclick="updateCart(this,-1)" /> <!-- Down Arrow -->
									</div>
								<a class="delete-btn" href="">X</a>
							</div>
						</li>`;
			});
			document.querySelector('.products').innerHTML = result;
			// console.log(jsonData);

			// 수량 입력 필드의 직접 변경 이벤트 처리
			document.querySelectorAll('.num-input').forEach(input => {
				input.addEventListener('input', function () {
					const button = this.closest('.num-input-div').querySelector('.inc');
					updateCart(button, 0); // 변경만 적용
				});
			});

			// 삭제 버튼 동작 처리
			document.querySelectorAll('.delete-btn').forEach(button => {
				button.addEventListener('click', function (e) {
					e.preventDefault();
					removeItemFromCart(this);
				});
			});
		}

		// =============== 숫자 증가/감소 로직 ==> 입력시 처리(window.onload) ===============
		function updateCart(button, change) {
			const input = button.closest('.num-input-div').querySelector('.num-input');
			const listItem = button.closest('.list-group-item');
			const productID = listItem.getAttribute('data-product-id');

			let curValue = parseInt(input.value, 10) || 0; // 값이 없으면 0으로 초기화
			curValue += change;

			if (curValue < 1) curValue = 1; // 최소값 제한
			input.value = curValue; // HTML 입력 필드 값 업데이트

			// LocalStorage 업데이트
			let cart = JSON.parse(localStorage.getItem('cart')) || {};
			cart[productID] = curValue; // 상품 ID의 수량 업데이트
			localStorage.setItem('cart', JSON.stringify(cart)); // LocalStorage 저장

			console.log(`Product \${productID} updated to quantity: \${curValue}`);

			// 총 금액 다시 계산
			calculateTotal();
		}

		// =============== 상품 삭제 함수 ===============
		function removeItemFromCart(button) {
			const listItem = button.closest('.list-group-item');
			const productId = listItem.getAttribute('data-product-id');

			// LocalStorage에서 해당 상품 제거
			let cart = JSON.parse(localStorage.getItem('cart')) || {};
			if (cart[productId]) {
				delete cart[productId];
				localStorage.setItem('cart', JSON.stringify(cart));
			}

			// HTML에서 해당 리스트 제거
			listItem.remove();

			// 장바구니 카운트 업데이트
			let updatedCount = Object.keys(cart).length;
			document.getElementById('cart-counter').innerHTML = updatedCount;

			console.log(`Product \${productId} removed from cart`);

			// 총 금액 다시 계산
			calculateTotal();
		}

		let prd = {};
		// =============== 총 금액 계산 함수 ===============
		function calculateTotal() {
			let cart = JSON.parse(localStorage.getItem('cart')) || {};
			totalAmount = 0;

			jsonData.forEach(item => {
				if (cart[item.pid]) {

					const p_key = item.pid; // 상품 ID를 key로 사용
					const p_qty = cart[item.pid]; // 장바구니 수량
					const p_price = item.price; // 단가
					pid_price = item.price * cart[item.pid];
					prd[p_key] = {price: p_price, qty: p_qty};
					// prd[p_key] = {price: p_price * p_qty};

					totalAmount += p_price * p_qty;
				}
			});

			// \${totalAmount.toLocaleString()}원 : 이 부분에서 \ 넣어야지 동작함 ????
			// script 외부에서 사용시 \ 넣어야함 (jsp 내에서 $가 있기때문에)
			document.getElementById('total-price').textContent = `\${totalAmount.toLocaleString()}원`;
			console.log(`Total Amount: \${totalAmount}`);
		}

	</script>
</body>
</html>