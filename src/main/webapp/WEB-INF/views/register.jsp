<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	int cookieCount = (int) request.getAttribute("cookieCount");
	String cid = (String) request.getAttribute("cid");
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
		window.onload = function () {
			if ( '<%=cid%>' !== 'null' ) {
				document.getElementById('login-logout-btn-space').innerHTML = `<a class="btn btn-outline-dark login-btn" href="api/logout.do">로그아웃</a>`
			} else {
				document.getElementById('login-logout-btn-space').innerHTML = `<a class="btn btn-outline-dark login-btn" href="login.do">로그인</a>`
			}
			document.getElementById("id-input").addEventListener('input', testEmail);
			document.getElementById("id-input").addEventListener('blur', deletePwdDescription);
			document.getElementById("pw-input").addEventListener('input', testPassword);
			document.getElementById("pw-input").addEventListener('blur', deletePwdDescription);
			document.getElementById('pwchk-input').addEventListener('input', checkPassword);
			document.getElementById('pwchk-input').addEventListener('blur', deletePwdDescription);
			document.getElementById('zipcode-input').addEventListener('input', testZipcode);
			document.getElementById('zipcode-input').addEventListener('blur', deletePwdDescription);
		}
		function submitForm(e) {
			e.preventDefault();
			const id = document.getElementById('id-input').value;
			const pw = document.getElementById('pw-input').value;
			const pwchk = document.getElementById('pwchk-input').value;
			const address = document.getElementById('address-input').value;
			const zipcode = document.getElementById('zipcode-input').value;

			if (id === '') {
				alert('아이디를 입력해주세요.');
				document.getElementById('id-input').focus();
				return;
			}
			if (pw === '') {
				alert('비밀번호를 입력해주세요.');
				document.getElementById('pw-input').focus();
				return;
			}
			if (testPassword() === -1) {
				alert('형식에 맞는 비밀번호를 입력해주세요.');
				document.getElementById('pw-input').focus();
				return;
			}
			if (pwchk === '') {
				alert('비밀번호 확인을 입력해주세요.');
				document.getElementById('pwchk-input').focus();
				return;
			}
			if (pw !== pwchk) {
				alert('비밀번호가 일치하지 않습니다.');
				document.getElementById('pw-input').focus();
				return;
			}
			if (zipcode === '') {
				alert('우편번호를 입력해주세요.');
				document.getElementById('zipcode-input').focus();
				return;
			}
			if (testZipcode()===-1) {
				alert('형식에 맞는 우편번호를 입력해주세요.');
				document.getElementById('zipcode-input').focus();
				return;
			}
			if (address === '') {
				alert('주소를 입력해주세요.');
				document.getElementById('address-input').focus();
				return;
			}
			const xhr = new XMLHttpRequest();
			xhr.open('POST', '/api/join', true);
			xhr.setRequestHeader('Content-Type', 'application/json');
			xhr.send(JSON.stringify({
				email: id,
				pwd: pw,
				addr: address,
				zip: zipcode
			}));

			xhr.onreadystatechange = function () {
				if (xhr.readyState === 4) {
					if (xhr.status === 200) {
						let flag = JSON.parse(xhr.responseText);
						if (flag.flag === '1') {
							location.href = '/login.do';
						} else if (flag.flag === '2') {
							alert('이미 존재하는 이메일입니다.');
						} else {
							alert('회원가입에 실패하였습니다.');
						}
					} else {
						alert('회원가입에 실패하였습니다.');
					}
				}
			}
		}
		function deletePwdDescription() {
			if (this.value === '')
				this.nextElementSibling.nextElementSibling.innerHTML = '';
		}
		function testEmail() {
			const email = document.getElementById('id-input').value;
			if (!/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(email)) {
				document.getElementById("id-check-space").innerHTML = `<div class="check-invalid">이메일 형식이 올바르지 않습니다</div>`
			} else {
				document.getElementById("id-check-space").innerHTML = ``
			}
		}
		function testPassword() {
			const password = document.getElementById('pw-input').value;

			// 조건 1: 길이 8~20자
			const isValidLength = /^.{8,20}$/.test(password);

			// 조건 2: 각 그룹 포함 여부
			const hasLetter = /[A-Za-z]/.test(password);
			const hasNumber = /[0-9]/.test(password);
			const hasSpecialChar = /[!@#$%^&*]/.test(password);

			// 조건 3: 2가지 이상 조합
			const validGroupCount = [hasLetter, hasNumber, hasSpecialChar].filter(Boolean).length >= 2;

			if (!isValidLength || !validGroupCount) {
				document.getElementById("pwd-check-space").innerHTML = `<div class="check-invalid">영문/숫자/특수문자 2가지 이상 조합 (8~20자)</div>`
				return -1;
			} else {
				document.getElementById("pwd-check-space").innerHTML = ``
				return 1;
			}
		}
		function checkPassword() {
			const pw = document.getElementById('pw-input').value;
			const pwchk = document.getElementById('pwchk-input').value;
			if (pw !== pwchk) {
				document.getElementById("pwchk-check-space").innerHTML = `<div class="check-invalid">패스워드가 일치하지 않습니다</div>`
			} else {
				document.getElementById("pwchk-check-space").innerHTML = ``
			}
		}
		function testZipcode() {
			if ( !/^\d{5}$/.test(document.getElementById('zipcode-input').value) ) {
				document.getElementById("zipcode-check-space").innerHTML = `<div class="check-invalid">우편번호는 5자리 숫자로 입력해주세요</div>`
				return -1;
			} else {
				document.getElementById("zipcode-check-space").innerHTML = ``
				return 1;
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
		<main class="card form-login p-5 mt-5">
			<form onsubmit="submitForm(event)">
				<div class="w-100">
					<h5>회원가입</h5>
					<hr>
				</div>

				<div class="form-floating mb-3">
					<input type="email" class="form-control" id="id-input" placeholder="name@example.com">
					<label for="id-input">Email@Example.com</label>
					<div id="id-check-space">
					</div>
				</div>

				<div class="form-floating mb-1">
					<input type="password" class="form-control" id="pw-input" placeholder="Password">
					<label for="pw-input">Password</label>
					<div id="pwd-check-space">
					</div>
				</div>

				<div class="form-floating mb-3">
					<input type="password" class="form-control" id="pwchk-input" placeholder="Password Check">
					<label for="pwchk-input">Password Check</label>
					<div id="pwchk-check-space">
					</div>
				</div>

				<div class="form-floating mb-3">
					<input type="text" class="form-control" id="zipcode-input" title="우편번호는 5글자로 입력해 주세요" placeholder="00000">
					<label for="zipcode-input">Zip Code</label>
					<div id="zipcode-check-space">
					</div>
				</div>

				<div class="form-floating mb-5">
					<input type="text" class="form-control" id="address-input" placeholder="충청북도 청주시 청원구 오창읍 000-0">
					<label for="address-input">Address</label>
				</div>

				<div class="d-flex flex-column">
					<button type="submit" class="btn btn-outline-dark w-50 mx-auto py-2">회원가입</button>
				</div>
			</form>
		</main>
	</div>
</body>

</html>