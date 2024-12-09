<%@ page import="com.example.project01.dto.CustomerDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%
	int cookieCount = (int) request.getAttribute("cookieCount");
	String cid = (String) request.getAttribute("cid");
	CustomerDTO customer = (CustomerDTO) request.getAttribute("customer");
	String email = "", addr = "", zipcode = "";
	if ( customer != null ) {
		email = customer.getEmail();
		addr = customer.getAddr();
		zipcode = customer.getZip();
	}
%>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- bootstrap.css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
	<!-- style.css -->
	<link rel="stylesheet" href="./css/style.css">
	<title>Grids & Circle</title>
	<script type="text/javascript">
		window.onload = function () {
			// 로그인 상태에 따른 로그인/로그아웃 버튼 변경
			if ( '<%=cid%>' !== 'null' ) {document.getElementById('login-logout-btn-space').innerHTML = `<a class="btn btn-outline-dark login-btn" href="api/logout.do">로그아웃</a>`}
			else {document.getElementById('login-logout-btn-space').innerHTML = `<a class="btn btn-outline-dark login-btn" href="login.do">로그인</a>`}

			// 로그인 상태일 시 주문자 정보 입력란에 기본 정보 입력
			if ( '<%=email%>' !== '' ) {document.getElementById('id-input').value = '<%=email%>';}
			if ( '<%=addr%>' !== '' ) {document.getElementById('address-input').value = '<%=addr%>';}
			if ( '<%=zipcode%>' !== '' ) {document.getElementById('zipcode-input').value = '<%=zipcode%>';}

			// 쿠키 내부 장바구니 목록 출력
			const cartCookie = getCookies();
			cartCookie.sort((b, a) => a.timestamp - b.timestamp);

			// 장바구니 목록 출력
			// 장바구니에 상품이 없는 경우
			if ( cartCookie.length === 0 ) {
				document.getElementById("product-list").innerHTML = `<li class="list-group-item d-flex align-items-center">
					장바구니에 상품이 없습니다.
				</li>`;
			}
			// 장바구니에 상품이 있을 경우
			else {
				document.getElementById("product-list").innerHTML = "";
				const request = new XMLHttpRequest()
				let result = ``;
				let total = 0;
				request.onreadystatechange = function () {
					if (request.readyState == 4) {
						if (request.status == 200) {
							const jsonData = JSON.parse(request.responseText.trim())
							for (let row of cartCookie) {
								jsonData.forEach(data => {
									if (parseInt(data.pid) === parseInt(row.productId)) {
										let sumprice = data.price * row.count;
										total += sumprice;
										result += `<li class="list-group-item d-flex align-items-center position-relative" data-product-id=\${data.pid} data-product-price=\${data.price}>
										<div>
											<img class="product-img" src="./images/\${data.img}">
										</div>
										<div class="col">
											<div class="text-muted">\${data.cat}</div>
											<div>\${data.name}</div>
										</div>
										<div class="px-3 text-center">\${sumprice.toLocaleString()}원</div>
										<div class="px-3 num-input-div">
											<input type="text" class="num-input" value="\${row.count}">
											<div class="num-btn">
												<button class="inc" onclick="updateCart(this,1)" /> <!-- Up Arrow -->
												<button class="dec" onclick="updateCart(this,-1)" /> <!-- Down Arrow -->
											</div>
										</div>
										<button class="btn btn-delete btn-jelly" onclick="deleteList(this)">X</button>`
									}
								})
							}
							document.getElementById("product-list").innerHTML += result;
							document.getElementById("total price").innerText = total.toLocaleString() + "원";
							for (const e of document.getElementsByClassName('num-input')) {
								e.addEventListener('input', updateInputItemCount);
							}
						}
					}
				}
				request.open("GET", `/api/productById`, true);
				request.send();
			}
		};

		// 주문 하기
		function processOrder(e) {
			e.preventDefault();
			if ( '<%=customer%>' === 'null' ) {
				alert("로그인 후 이용해주세요.");
				location.href = "/login.do";
				return;
			}
			const cartCookie = getCookies();
			const customer = {
				cid: '<%=cid%>',
				email: document.getElementById('id-input').value,
				addr: document.getElementById('address-input').value,
				zip: document.getElementById('zipcode-input').value
			}
			const jsonData = JSON.stringify({
				customer:customer,
				products:cartCookie
			});
			const xhr = new XMLHttpRequest();
			xhr.open("POST", "/api/order", true);
			xhr.setRequestHeader("Content-Type", "application/json");
			xhr.send(jsonData);
			xhr.onreadystatechange = function () {
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						let flag = JSON.parse(xhr.responseText);
						console.log(flag);
						if ( flag.flag === '1' ) {
							document.cookie = "cart=; max-age=0; path=/";
							location.href = "/main.do";
						} else {
							alert("주문 실패");
						}
					} else {
						alert("주문 실패");
					}
				}
			}
		}
	</script>
</head>

<body>

<div class="container-fluid my-4">
	<header class="d-flex justify-content-between align-items-center mb-3">
		<div>
			<a href="main.do">
				<img class="brand-logo" src="./images/brand_logo.png">
			</a>
		</div>
		<div class="d-flex">
			<a href="deactivate.do" class="deactivate quick-link">
				<img class="mx-auto" src="./images/person-x.svg" width="28" height="28">
				<span class="cart-title">계정삭제</span>
			</a>
			<a href="order.do" class="purchase quick-link">
				<img class="mx-auto" src="./images/purchase.png" width="28" height="28">
				<span class="cart-title">주문내역</span>
			</a>
			<a href="cartView.do" class="cart quick-link">
					<img class="mx-auto" src="./images/cart.png" width="28" height="28">
					<span class="cart-title">장바구니</span>
					<em class="cart-count" id="cart-counter"><%=cookieCount%></em>
				</a>
				<div id="login-logout-btn-space" class="login-btn-div">
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
						<ul class="list-group products col" id="product-list">
						</ul>
						<div class="mx-3 purchase-form">
							<hr>
							<div class="d-flex justify-content-between mt-2">
								<span>총 금액</span>
								<span id="total price">0원</span>
							</div>
							<hr>
							<form>
								<div class="form-floating mb-2">
									<input type="email" class="form-control" id="id-input" placeholder="name@example.com">
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
									<button id="submitBtm" class="btn btn-dark w-100" onclick="processOrder(event)">주문하기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<script>
		// 쿠키에서 장바구니 목록 가져오기
		function getCookies() {
			const cookies = document.cookie.split('; ').reduce((acc, cookie) => {
				const [key, value] = cookie.split('=');
				acc[key] = decodeURIComponent(value);
				return acc;
			}, {});
			const cartCookie = cookies.cart ? JSON.parse(cookies.cart) : [];
			return cartCookie;
		}

		// 버튼에 의한 숫자 증가/감소 로직
		function updateCart(button, change) {
			const listProduct = button.closest('.list-group-item');
			const prdId = listProduct.dataset.productId;
			const prdPrice = listProduct.dataset.productPrice;
			const input = button.closest('.num-input-div').querySelector('.num-input')
			let curValue = parseInt(input.value, 10) || 0; // 값이 없으면 0으로 초기화
			curValue += change;
			if (curValue < 1) curValue = 1; // 최소값 제한
			input.value = curValue;

			// 쿠키에서 해당 상품 찾아서 개수 변경
			const cartCookie = getCookies()
			const existingItemIndex = cartCookie.findIndex(item => item.productId === prdId);
			if (existingItemIndex !== -1) {
				cartCookie[existingItemIndex].count = parseInt(input.value, 10);
			}
			document.cookie = "cart=" + encodeURIComponent(JSON.stringify(cartCookie)) + `; max-age=\${300}; path=/`;

			listProduct.querySelector('.text-center').innerText = (prdPrice * curValue).toLocaleString() + '원'

			// 총 금액 계산
			let result = 0;
			let prices = document.querySelectorAll('.text-center');
			for (let p of prices) {
				result += parseInt(p.textContent.replace(/,/g, '').replace('원', ''), 10)
			}
			document.getElementById("total price").innerText = result.toLocaleString() + '원'
		}

		// 숫자 이외의 값 입력 방지
		document.querySelectorAll(".num-input").forEach(input => {
			input.addEventListener("input", function () {
				this.value = this.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자 제거
			});
		});

		// 상품 개수 직접 입력 변경
		function updateInputItemCount() {
			const listProduct = this.closest('.list-group-item');
			const prdId = listProduct.dataset.productId;
			const prdPrice = listProduct.dataset.productPrice;

			// 쿠키에서 해당 상품 찾아서 개수 변경
			const cartCookie = getCookies()
			const existingItemIndex = cartCookie.findIndex(item => item.productId === prdId);
			if (existingItemIndex !== -1) {
				cartCookie[existingItemIndex].count = parseInt(this.value, 10);
			}
			document.cookie = "cart=" + encodeURIComponent(JSON.stringify(cartCookie)) + `; max-age=\${300}; path=/`;

			// 상품 개수 및 가격 변경
			const newValue = this.value; // 입력한 새로운 값
			listProduct.querySelector('.text-center').innerText = (prdPrice * newValue).toLocaleString() + '원';
			// 총 금액 계산
			let totalPrice = document.getElementById("total price");
			let prices = document.querySelectorAll('.text-center');
			let result = 0;
			for (let p of prices) {
				result += parseInt(p.textContent.replace(/,/g, '').replace('원', ''))
			}
			totalPrice.innerText = result.toLocaleString() + '원'
		}

		// 상품 삭제
		function deleteList(button) {
			const listProduct = button.closest('.list-group-item');
			const prdId = listProduct.dataset.productId;

			// 쿠키에서 해당 상품 찾아서 삭제
			const cartCookie = getCookies();
			const existingItemIndex = cartCookie.findIndex(item => item.productId === prdId);
			if (existingItemIndex !== -1) {
				cartCookie.splice(existingItemIndex, 1);
			}
			document.cookie = "cart=" + encodeURIComponent(JSON.stringify(cartCookie)) + `; max-age=\${60*60*24*30}; path=/`;

			// 상품 삭제
			listProduct.remove();
			// 장바구니 수량 변경
			document.getElementById("cart-counter").innerHTML -= 1;
			if ( document.getElementById("cart-counter").innerHTML === '0' ) {
				console.log('장바구니에 상품이 없습니다.');
				document.getElementById("product-list").innerHTML = `<li class="list-group-item d-flex align-items-center">
					장바구니에 상품이 없습니다.
				</li>`;
			}

			// 총 금액 계산
			let totalPrice = document.getElementById("total price");
			let prices = document.querySelectorAll('.text-center');
			let result = 0;
			for (let p of prices) {
				result += parseInt(p.textContent.replace(/,/g, '').replace('원', ''))
			}
			totalPrice.innerText = result.toLocaleString() + '원'
		}
	</script>
</body>

</html>