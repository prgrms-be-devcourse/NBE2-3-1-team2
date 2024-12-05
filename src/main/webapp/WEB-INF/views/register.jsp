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
	<script>
		// 페이지가 로드되면 쿼리 파라미터를 확인하여 오류 메시지 표시
		window.onload = function() {
			const urlParams = new URLSearchParams(window.location.search);
			const error = urlParams.get('error');

			if (error === 'emailExists') {
				document.getElementById('error-message').style.display = 'inline'; // 오류 메시지 표시
			}
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
				<div class="login-btn-div">
					<a class="btn btn-outline-dark login-btn" href="login.do">로그인</a>
				</div>
			</div>
		</header>
		<hr>
		<main class="card form-login p-5 mt-5">
			<form action="/emp/register" method="post" name="rfrm">
				<div class="w-100">
					<h5>회원가입</h5>
					<hr>
				</div>

				<div class="form-floating mb-3">
					<input type="email" class="form-control" id="id-input" placeholder="name@example.com" name="email">
					<label for="id-input">Email@Example.com</label>
					<span id="error-message" style="color:red; display:none;">
        				이미 등록된 이메일입니다. 다른 이메일을 사용해주세요.
    				</span>
				</div>

				<div class="form-floating mb-1">
					<input type="password" class="form-control" id="pw-input" placeholder="Password" name="pw-input">
					<label for="pw-input">Password</label>
				</div>
				<div class="form-floating mb-3">
					<input type="password" class="form-control" id="pwchk-input" placeholder="Password Check" name="pwchk-input">
					<label for="pwchk-input">Password Check</label>
				</div>

				<div class="form-floating mb-1">
					<input type="text" class="form-control" id="address-input" name="addr" placeholder="충청북도 청주시 청원구 오창읍 000-0" name="addr">
					<label for="address-input">Address</label>
				</div>

				<div class="form-floating mb-5">
					<input type="text" class="form-control" id="zipcode-input" name="zip" placeholder="00000" name="zip">
					<label for="zipcode-input">Zip Code</label>
				</div>


				<div class="d-flex flex-column">
					<button class="btn btn-outline-dark w-50 mx-auto py-2" onclick="" id="rbtn">회원가입</button>
				</div>
			</form>
		</main>
		
	</div>

	<script type="text/javascript">
		document.getElementById('rbtn').onclick = function() {
			const password = document.getElementById("pw-input").value;
			const confirmPassword = document.getElementById("pwchk-input").value;
			const email = document.getElementById("id-input").value;
			const addr = document.getElementById("address-input").value;
			const zip = document.getElementById("zipcode-input").value;
			console.log(email);

			if (password !== confirmPassword) {
				alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
				return false;  // 폼 제출을 중단
			}

			if (email.trim() === "") {
				alert("이메일을 입력해주세요.");
				return false;  // 폼 제출을 중단
			}

			if (addr.trim() === "") {
				alert("주소를 입력해주세요.");
				return false;  // 폼 제출을 중단
			}

			if (zip.trim() === "") {
				alert("우편번호를 입력해주세요.");
				return false;  // 폼 제출을 중단
			}

			document.rfrm.submit();
		};
	</script>
</body>

</html>