<%@ page import="java.util.Base64" %>
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
		}
		function deactive(e) {
			e.preventDefault()
			let password = document.getElementById("floatingPassword").value;
			if (password === '') {
				alert('비밀번호를 입력해주세요.');
				document.getElementById("floatingPassword").focus();
				return;
			}
			const xhr = new XMLHttpRequest();
			console.log(password);
			xhr.open('DELETE', `/api/delete/\${password}`, true);
			xhr.send();
			xhr.onreadystatechange = function () {
				if (xhr.readyState === 4) {
					if (xhr.status === 200) {
						if ( xhr.responseText === '1' ) {
							alert('계정이 삭제되었습니다.');
							location.href = 'main.do';
						} else {
							alert('패스워드가 틀렸습니다.');
							document.getElementById('floatingPassword').focus();
						}
					} else {
						alert('계정 삭제에 실패하였습니다.');
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
					<h5>계정삭제</h5>
					<hr>
				</div>
				<div class="form-floating">
					<input type="password" class="form-control" id="floatingPassword" placeholder="Password">
					<label for="floatingPassword">Password</label>
				</div>
				<div class="d-flex flex-column pt-4">
					<button class="btn btn-outline-dark w-50 mx-auto" onclick="deactive(event)">삭제</button>
				</div>
			</form>
		</main>
		
	</div>
</body>

</html>