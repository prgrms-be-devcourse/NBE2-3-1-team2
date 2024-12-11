<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
					<em class="cart-count" id="cart-counter">0</em>
				</a>
				<div class="login-btn-div">
					<a class="btn btn-outline-dark login-btn" href="">로그인</a>
				</div>
			</div>
		</header>
		<hr>
		<main class="card form-login p-5 mt-5">
			<form action="/login.do">
				<div class="w-100">
					<h5>로그인</h5>
					<hr>
				</div>

				<div class="form-floating mb-3">
					<input type="email" class="form-control" id="floatingInput" placeholder="name@example.com">
					<label for="floatingInput">Email</label>
				</div>
				<div class="form-floating">
					<input type="password" class="form-control" id="floatingPassword" placeholder="Password">
					<label for="floatingPassword">Password</label>
				</div>

				<!--<div class="form-check text-start my-3">
					<input class="form-check-input" type="checkbox" value="remember-me" id="flexCheckDefault">
					<label class="form-check-label" for="flexCheckDefault">
						이메일 기억하기
					</label>
				</div>-->
				<br/>

				<div class="d-flex flex-column">
					<button class="btn btn-outline-dark w-50 mx-auto py-2" onclick="">로그인</button>
					<div class="text-center mt-4">
						<a href="/register.do" class="reg-link">회원가입</a>
					</div>
				</div>
				
			</form>
		</main>
		
	</div>

	<script src="/js/session.js"></script>
	<script type="text/javascript">
		window.onload = function () {
			// session.js 함수 호출
			checkSession();
			setupLinks();

			// 장바구니 아이콘 숫자 표시
			let existingCart = JSON.parse(localStorage.getItem('cart')) || {}; // localStorage에서 값 가져오기
			let productCount = Object.keys(existingCart).length;
			document.getElementById('cart-counter').innerHTML = productCount;

			// 로그인 정보 가져오기
			// 로그인 처리(세션 저장)
			const loginButton = document.querySelector('form button');
			loginButton.onclick = function (event) {
				// 처음에 로그인하면, 뭐든 나오지 않는 문제
				event.preventDefault(); // 이게 있어야지 처음부터 로그인기능 수행할 수 있음
				// 로그인 정보 가져오기
				const email = document.getElementById('floatingInput').value;
				const password = document.getElementById('floatingPassword').value;

				if(!email){
					alert("이메일을 입력해주세요");
				} else if(!password){
					alert("비밀번호를 입력해주세요");
				} else {
					console.log(email, password);

					const request = new XMLHttpRequest();
					request.onreadystatechange = function () {
						if (request.readyState == 4) {
							if (request.status == 200) {
								console.log("서버 응답 : ", request.responseText);;
								alert("로그인 되었습니다")
								window.location.replace("/main.do");
							} else if (request.status == 401) {
								alert("잘못된 비밀번호 입니다");
							} else if (request.status == 404) {
								alert("존재하지 않는 이메일입니다")
							} else {
								alert("로그인 중 문제가 발생했습니다. 다시 시도하세요")
							}
						}
					}
					request.open('POST', '/api/login', true);
					request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');

					//JSON 필드를 Server와 동일하게 맞춰야함(안그러면 값을 못 넘김)
					const requestData = JSON.stringify({
						email: email,
						pwd: password
					});
					request.send(requestData);
					console.log("전송 데이터: ",requestData);

					// ======== 세션 없는 경우 처리 ========
					// 1. 장바구니, 주문내역 클릭시 -> 세션 없으면 로그인창 이동
					// 1.2_ 다른 페이지에서도 모두 동일하게 처리
					// 2. 로그인 버튼 표시

					// ======== 세션 있는 경우 처리 ========
					// 1. 로그인 -> 로그아웃 버튼으로 표시
					// 1_2. 로그아웃 -> 세션 삭제
				}
			}
		}
	</script>
</body>

</html>