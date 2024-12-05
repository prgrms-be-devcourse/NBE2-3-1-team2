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
	<script type="text/javascript">
		window.onload = function () {
			// form 내의 버튼 클릭
			const registerButton = document.querySelector('form button');
			registerButton.onclick = function (event) {
				event.preventDefault(); // 폴 기본 동작 방지

				// 폼 데이터 가져오기
				const email = document.getElementById('id-input').value;
				const password = document.getElementById('pw-input').value;
				const addr = document.getElementById('address-input').value;
				const zip = document.getElementById('zipcode-input').value;

				if (!email || !password || !addr || !zip) {
					alert("모두 입력해주세요");
					return;
				}

				if (zip.length != 5) {
					alert("우편번호는 5자 입니다");
				}

				// 존재하는 이메일의 경우 err 처리


				const request = new XMLHttpRequest();
				request.onreadystatechange = function () {
					if (request.readyState == 4) {
						if (request.status == 200) {
							console.log("서버 응답 : " , request.responseText);
							alert("회원가입 되었습니다")
						} else {
							alert("회원가입 실패 : ", request.status);
						}
					}
				}
				// 요청 열기
				request.open('POST', '/api/register', true);
				request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');

				// 데이터 전송
				const requestData = JSON.stringify({
					email: email,
					pwd: password,
					addr: addr,
					zip: zip,
				});
				request.send(requestData);
				console.log("전송 데이터: ", requestData);
			}
		}

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
				<a href="" class="purchase quick-link">
					<img class="mx-auto" src="./images/purchase.png" width="28" height="28">
					<span class="cart-title">주문내역</span>
				</a>
				<a href="" class="cart quick-link">
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
			<form action="">
				<div class="w-100">
					<h5>회원가입</h5>
					<hr>
				</div>

				<div class="form-floating mb-3">
					<input type="email" class="form-control" id="id-input" placeholder="name@example.com">
					<label for="id-input">Email@Example.com</label>
				</div>
				<div class="form-floating mb-1">
					<input type="password" class="form-control" id="pw-input" placeholder="Password">
					<label for="pw-input">Password</label>
				</div>
				<div class="form-floating mb-3">
					<input type="password" class="form-control" id="pwchk-input" placeholder="Password Check">
					<label for="pwchk-input">Password Check</label>
				</div>

				<div class="form-floating mb-1">
					<input type="text" class="form-control" id="address-input" placeholder="충청북도 청주시 청원구 오창읍 000-0">
					<label for="address-input">Address</label>
				</div>

				<div class="form-floating mb-5">
					<input type="text" class="form-control" id="zipcode-input" placeholder="00000">
					<label for="zipcode-input">Zip Code</label>
				</div>


				<div class="d-flex flex-column">
					<button class="btn btn-outline-dark w-50 mx-auto py-2" onclick="">회원가입</button>
				</div>
			</form>
		</main>
		
	</div>
</body>

</html>