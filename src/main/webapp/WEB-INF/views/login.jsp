<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

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
		window.onload = function () {
			updateCartCount();

			const urlParams = new URLSearchParams(window.location.search);
			const error = urlParams.get('error');

			if (error === 'loginfailed') {
				document.getElementById('error-message').style.display = 'inline'; // 오류 메시지 표시
			}

			fetch("/emp/loginStatus")
					.then(response => response.json())
					.then(data => {
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
				<a href="order.do" class="purchase quick-link" id="history">
					<img class="mx-auto" src="./images/purchase.png" width="28" height="28">
					<span class="cart-title">주문내역</span>
				</a>
				<a href="cart.do" class="cart quick-link" id="cart">
					<img class="mx-auto" src="./images/cart.png" width="28" height="28">
					<span class="cart-title">장바구니</span>
					<em class="cart-count" id="cart-counter">0</em>
				</a>
				<div class="login-btn-div">
					<a class="btn btn-outline-dark login-btn" href="login.do">로그인</a>
				</div>
			</div>
		</header>
		<hr>
		<main class="card form-login p-5 mt-5">
			<form id="loginform" action="/emp/login" method="post">
				<div class="w-100">
					<h5>로그인</h5>
					<hr>
				</div>

				<div class="form-floating mb-3">
					<input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" name="email">
					<label for="floatingInput">Email</label>
				</div>
				<div class="form-floating">
					<input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password">
					<label for="floatingPassword">Password</label>
				</div>

				<div class="form-check text-start my-3">
					<input class="form-check-input" type="checkbox" value="remember-me" id="flexCheckDefault">
					<label class="form-check-label" for="flexCheckDefault">
						이메일 기억하기
					</label>
					<div>
						<span id="error-message" style="color:red; display:none;">
							아이디 또는 비밀번호가 잘못되었습니다.<br />
							정확히 입력해 주세요.
						</span>
					</div>
				</div>
				<div class="d-flex flex-column" id="loginStatus">
					<button class="btn btn-outline-dark w-50 mx-auto py-2" type="submit">로그인</button>
					<div class="text-center mt-4">
						<a href="join.do" class="reg-link">회원가입</a>
					</div>
				</div>

			</form>
		</main>
		
	</div>
	<script type="text/javascript" >

		function updateCartCount() {
			// localStorage에서 'cart'를 가져와서 총 카운트 계산
			const cart = localStorage.getItem('cart');
			const cartCount = cart ? parseInt(JSON.parse(cart).length, 10) : 0;
			document.getElementById('cart-counter').textContent = cartCount;
			// 여기에서 UI 업데이트를 추가할 수 있습니다.
		}

	</script>
</body>

</html>