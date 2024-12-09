<%@ page import="java.util.Base64" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	int cookieCount = (int) request.getAttribute("cookieCount");
	String email = (String) request.getAttribute("email");
	String saveEmailOption = (String) request.getAttribute("option");
	String cid = (String) request.getAttribute("cid");
	String msg = (String) request.getAttribute("message");
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
			if ( '<%=msg%>' !== 'null' ) {
				alert('<%=msg%>');
			}
			if ( '<%=cid%>' !== 'null' ) {
				document.getElementById('login-logout-btn-space').innerHTML = `<a class="btn btn-outline-dark login-btn" href="api/logout.do">로그아웃</a>`
			} else {
				document.getElementById('login-logout-btn-space').innerHTML = `<a class="btn btn-outline-dark login-btn" href="login.do">로그인</a>`
			}
			if ( '<%=email%>' !== '' && '<%=email%>' !== null ) {document.getElementById("floatingInput").value = atob('<%=email%>');}
			if ( '<%=saveEmailOption%>' === 'true' ) {document.getElementById("flexCheckDefault").checked = true;}
		}
		function login(e) {
			e.preventDefault()
			if (document.getElementById("floatingInput").value === '') {
				alert('이메일을 입력해주세요.');
				document.getElementById("floatingInput").focus();
				return;
			}
			if (document.getElementById("floatingPassword").value === '') {
				alert('비밀번호를 입력해주세요.');
				document.getElementById("floatingPassword").focus();
				return;
			}
			if ( document.getElementById("flexCheckDefault").checked ) {
				let email = btoa(document.getElementById("floatingInput").value);
				document.cookie = `email=` + encodeURIComponent(email) + `; max-age=\${60*60*24*30}`;
				document.cookie = `saveEmailOption=true; max-age=\${60*60*24*30}`;
			}
			const xhr = new XMLHttpRequest();
			xhr.open('POST', '/api/login', true);
			xhr.setRequestHeader('Content-Type', 'application/json');
			xhr.send(JSON.stringify({
				email: document.getElementById("floatingInput").value,
				pwd: document.getElementById("floatingPassword").value
			}));

			xhr.onreadystatechange = function () {
				if (xhr.readyState === 4) {
					if (xhr.status === 200) {
						let flag = JSON.parse(xhr.responseText);
						if ( flag.flag === '-1' ) {
							alert('존재하지 않는 이메일 입니다.');
							console.log(flag);
						} else if ( flag.flag === '-2' ) {
							alert('패스워드가 틀렸습니다.');
							console.log(flag);
						} else if ( flag.flag === '1' ) {
							location.href = 'main.do';
						}
					} else {
						alert('로그인에 실패하였습니다.');
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
		<main class="card form-login p-5 mt-5">
			<form>
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

				<div class="form-check text-start my-3">
					<input class="form-check-input" type="checkbox" id="flexCheckDefault">
					<label class="form-check-label" for="flexCheckDefault">
						이메일 기억하기
					</label>
				</div>
				<div class="d-flex flex-column">
					<button class="btn btn-outline-dark w-50 mx-auto py-2" onclick="login(event)">로그인</button>
					<div class="text-center mt-4">
						<a href="join.do" class="reg-link">회원가입</a>
					</div>
				</div>
			</form>
		</main>
		
	</div>
</body>

</html>