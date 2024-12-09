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

	<script type="text/javascript" >
		window.onload = function () {fetch("/emp/loginStatus")
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
			<div class="login-btn-div" id="loginStatus">
				<a class="btn btn-outline-dark login-btn" href="login.do">로그인</a>
			</div>
		</div>
	</header>
	<hr>
	<main class="card form-login p-5 mt-5">
		<form id="account_delete">
			<div class="w-100">
				<h5>회원탈퇴</h5>
				<hr>
			</div>
			<div class="mb-3">
				탈퇴를 원하시면 비밀번호를 입력해주세요.
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password">
				<label for="floatingPassword">Password</label>
			</div>

			<div class="d-flex flex-column">
				<button class="btn btn-outline-dark w-50 mx-auto py-2" id="dbtn" style="margin-top: 20px;">회원 탈퇴</button>
			</div>

		</form>
	</main>

</div>
<script type="text/javascript" >
	document.getElementById('dbtn').onclick = function (event) {
		event.preventDefault();
		const pwd = document.getElementById('floatingPassword').value;

		fetch('emp/delete', {
			method: 'DELETE',  // DELETE 방식
			headers: {
				'Content-Type': 'application/json',  // JSON 형식으로 보내기
			},
			body: JSON.stringify({ pwd: pwd })  // 본문으로 비밀번호 전송
		})
				.then(response => response.text())
				.then(data => {
					console.log(data);
					if (data === 'delete') {
						alert("탈퇴되셨습니다.");

						window.location.replace('main.do');
					} else if (data === 'fail') {
						alert("비밀번호가 틀렸거나 삭제에 실패했습니다.");
					}
				})
				.catch(error => console.error('비밀번호 확인 오류:', error));
	};

</script>
</body>

</html>