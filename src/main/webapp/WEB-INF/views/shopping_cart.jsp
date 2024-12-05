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
							<form action="" method="">
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
									<button class="btn btn-dark w-100" type="submit">주문하기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<script type="text/javascript">
		var jsonData = [];
		let totalPrice = 0;
		window.onload = function () {
			//localstorage 에서 pid 받아오기
			let existingCart = JSON.parse(localStorage.getItem('cart')) || {}; // localStorage에서 값 가져오기
			//장바구니 아이콘에 표시하기
			let productCount = Object.keys(existingCart).length;
			document.getElementById('cart-counter').innerHTML = productCount;

			// productId 데이터 생성 방식(객체형식을 따르도록, pid를 int로 변환하고, 객체로 감싸 서버 전송)
			let productId = Object.keys(existingCart).map(pid => ({ pid: parseInt(pid) }));

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
		};

		// =============== 장바구니 아이템 렌더링 ================
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

			console.log(`Product ${productID} updated to quantity: ${curValue}`);

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


		// =============== 총 금액 계산 함수 ===============
		function calculateTotal() {
			let cart = JSON.parse(localStorage.getItem('cart')) || {};
			totalAmount = 0;

			jsonData.forEach(item => {
				if (cart[item.pid]) {
					totalAmount += item.price * cart[item.pid];
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