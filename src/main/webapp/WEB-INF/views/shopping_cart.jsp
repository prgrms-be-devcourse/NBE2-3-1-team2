<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>


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

	<script type="text/javascript">
		window.onload = function () {
			fetch("/emp/loginStatus")
					.then(response => response.json())
					.then(data => {
						const loginStatusDiv = document.getElementById("loginStatus");
						if (data.isLoggedIn) {
							loginStatusDiv.innerHTML = `<a href="/emp/logout" class="btn btn-outline-dark">로그아웃</a>`;
						} else {
							loginStatusDiv.innerHTML = `<a href="login.do" class="btn btn-outline-dark">로그인</a>`;
						}

						const cartLink = document.querySelector("#cart");
						const orderLink = document.querySelector("#history");

						if (cartLink) {
							cartLink.addEventListener("click", function (event) {
								if (!data.isLoggedIn) {
									event.preventDefault();  // 페이지 이동을 막음
									alert("로그인 후 이용 가능합니다.");
								}
							});
						}

						// 주문 내역 클릭 시 로그인 상태 확인
						if (orderLink) {
							orderLink.addEventListener("click", function (event) {
								if (!data.isLoggedIn) {
									event.preventDefault();  // 페이지 이동을 막음
									alert("로그인 후 이용 가능합니다.");
								}
							});
						}
					})
					.catch(error => console.error('Error fetching login status:', error));

			const request = new XMLHttpRequest();
			let cartData = JSON.parse(localStorage.getItem("cart")) || []; // localStorage에서 데이터 가져오기

			request.onreadystatechange = function() {
				if (request.readyState === 4) { // 요청이 완료된 경우
					if (request.status === 200) { // 성공적인 응답인 경우
						updateTotalPrice();
						//console.log(cartData);
						updateTotalPrice();
						const jsonData = JSON.parse(request.responseText);
						let result = '';
						for(let i = 0 ; i < jsonData.length ; i++) {
							let row = jsonData[i];
							result += `<li class="list-group-item d-flex align-items-center position-relative cart-item">
										<div>
											<img class="product-img" src="./images/\${row.img}"/>
										</div>
										<div class="col">
											<div class="text-muted">\${row.cat}</div>
											<div>\${row.name}</div>
										</div>
										<div class="px-3 text-center" id="price-\${row.pid}" data-price="\${row.price * cartData[i].count}">\${(row.price * cartData[i].count).toLocaleString()}원</div>
										<div class="px-3 num-input-div">
											<input type="text" class="num-input" value="\${cartData[i].count}" id="\${row.pid}"/>
											<div class="num-btn">
												<button class="inc" onClick="updateCart(this,1, '\${row.pid}', \${row.price})"/>
												<!-- Up Arrow -->
												<button class="dec" onClick="updateCart(this,-1, '\${row.pid}', \${row.price})"/>
												<!-- Down Arrow -->
											</div>
										</div>
										<a class="delete-btn" href="" onclick="handleDelete('\${row.pid}')">X</a>
										</li>`;
							console.log(`'\${row.name}'`);
						}

						document.getElementById('cart-list').innerHTML = result;
						updateCartCount();
						updateTotalPrice();

						document.querySelectorAll(".num-input").forEach(input => {
							input.addEventListener("input", function () {
								this.value = this.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자 제거
							});

							input.addEventListener("blur", function () {
								const pid = this.getAttribute("id");
								let count = parseInt(this.value, 10);

								if (isNaN(count) || count <= 0) { // 유효하지 않은 값이라면 기본값 1로 설정
									count = 1;
								}

								this.value = count; // 입력값을 업데이트

								const row = jsonData.find(item => item.pid === pid);
								const price = row ? row.price : 0;

								updateStorage(pid, count, price);

								});
						});
					} else {
						console.error("서버 요청 실패:", request.status, request.statusText);
					}
				}
			};

			request.open("POST", "/emp/cart", true);
			request.setRequestHeader("Content-Type", "application/json");
			request.send(JSON.stringify(cartData));
		};
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
			<a href="order.do" class="purchase quick-link">
					<img class="mx-auto" src="./images/purchase.png" width="28" height="28">
					<span class="cart-title">주문내역</span>
				</a>
				<a href="cart.do" class="cart quick-link">
					<img class="mx-auto" src="./images/cart.png" width="28" height="28">
					<span class="cart-title">장바구니</span>
					<em class="cart-count" id="cart-counter">0</em>
				</a>
				<div class="login-btn-div" id="loginStatus">
					<a class="btn btn-outline-dark login-btn" href="login.do" >로그인</a>
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
						<ul class="list-group products col" id="cart-list">
							<!-- 이 자리에 장바구니 내용 들어감 -->
						</ul>
						<div class="mx-3 purchase-form">
							<hr>
							<div class="d-flex justify-content-between mt-2" id="total-price">
								<span>총 금액</span>
								<!--<span>50,000원</span> -->
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

	<script>
		// 숫자 증가/감소 로직
		function updateCart(button, change, pid, unitPrice) {
			const input = button.closest('.num-input-div').querySelector('.num-input');
			let curValue = parseInt(input.value, 10) || 0; // 값이 없으면 0으로 초기화
			curValue += change;
			if (curValue < 1) curValue = 1; // 최소값 제한
			input.value = curValue;

			console.log("updateCart: " + unitPrice);
			updateStorage(pid, curValue, unitPrice);
		}


		function updateStorage(pid, count, unitPrice){
			let cart = JSON.parse(localStorage.getItem('cart')) || [];
			//console.log(cart);
			//console.log('수정 전 cart:', cart);
			//console.log('입력된 pid:', pid);

			count = parseInt(count, 10);

			const existingProduct = cart.find(item => item.pid === pid);
			//console.log("existingProduct: " + existingProduct);

			if (existingProduct) {
				// 기존 상품의 수량 업데이트
				existingProduct.count = count;
			}

			localStorage.setItem('cart', JSON.stringify(cart));

			console.log(unitPrice);
			const priceElement = document.getElementById('price-' + pid);
			const newPrice = parseInt(count * unitPrice);
			priceElement.textContent = newPrice.toLocaleString() + "원";

			// data-price 속성 업데이트 (데이터 값 변경)
			priceElement.dataset.price = newPrice;
			updateTotalPrice();
			//console.log(localStorage.getItem('cart'));
		}

		function handleDelete(inputPid) {
			// localStorage에서 'cartData'라는 키로 저장된 데이터를 가져오기 (배열로 변환)
			let cartData = JSON.parse(localStorage.getItem('cart')) || [];

			// 입력된 pid와 일치하는 항목을 제외한 새로운 배열 만들기
			const updatedCartData = cartData.filter(item => item.pid !== inputPid);

			// 배열이 업데이트된 후, 다시 localStorage에 저장
			localStorage.setItem('cart', JSON.stringify(updatedCartData));

			// 삭제된 후 UI나 카운트 등을 업데이트
			alert('pid가 삭제되었습니다!');
			updateCartCount();
			updateTotalPrice();
		}

		function updateCartCount() {
			// localStorage에서 'cart'를 가져와서 총 카운트 계산
			const cart = localStorage.getItem('cart');
			const cartCount = cart ? parseInt(JSON.parse(cart).length, 10) : 0;
			document.getElementById('cart-counter').textContent = cartCount;
			// 여기에서 UI 업데이트를 추가할 수 있습니다.
		}

		// 장바구니 총 금액 변경 로직
		function updateTotalPrice() {
			console.error();
			let totalPrice = 0; // 총 금액 초기화

			// 각 상품 항목 처리
			document.querySelectorAll('.cart-item').forEach(item => {

				// 개별 상품의 총 금액 가져오기
				const pricePerItem = parseInt(item.querySelector('.text-center').dataset.price, 10);
				console.log(pricePerItem);
				// 개별 상품의 총 가격을 장바구니 총 금액에 더하기
				totalPrice += pricePerItem;
			});

			//console.log(totalPrice);

			// 장바구니 총 금액 UI 업데이트
			document.getElementById('total-price').innerHTML = `
        		<span>총 금액</span>
        		<span>\${totalPrice.toLocaleString()}원</span>`;
		}

	</script>
</body>

</html>