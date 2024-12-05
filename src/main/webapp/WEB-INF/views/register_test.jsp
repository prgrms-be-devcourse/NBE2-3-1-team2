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
		// event.preventDefault();	// 폼 기본 동작 방지 (페이지 리로드 방지)

		window.onload = function () {

			// 폼 제출 이벤트 처리
			document.getElementById('joinForm').addEventListener('submit', function (event) {
				// 기본 제출을 막음
				event.preventDefault();

				// 기본 검증 확인
				if (this.checkValidity()) {
					// 사용자 정의 검증
					if (document.jfrm.password.value !== document.jfrm.passwordck.value) {
						alert('비밀번호 확인과 일치하지 않습니다.');
						return false;
					}

					// Form 데이터 준비
					const formData = {
						mail: document.jfrm.mail.value,
						password: document.jfrm.password.value,
						address: document.jfrm.address.value,
						zipcode: document.jfrm.zipcode.value
					};

					// API 호출
					join(formData);
				} else {
					console.log('브라우저 기본 검증 실패');
					return false;
				}
			});

			// document.getElementById( 'jbtn' ).onclick = function() {
			//
			// 	if ( document.jfrm.mail.value == '' ) {
			// 		alert( '이메일을 입력하셔야 합니다.' );
			// 		return false;
			// 	}
			//
			// 	if ( document.jfrm.password.value == '' ) {
			// 		alert( '비밀번호를 입력하셔야 합니다.' );
			// 		return false;
			// 	}
			//
			// 	if ( document.jfrm.passwordck.value == '' ) {
			// 		alert( '비밀번호을 한 번 더 입력하셔야 합니다.' );
			// 		return false;
			// 	}
			//
			// 	if ( document.jfrm.password.value != document.jfrm.passwordck.value ) {
			// 		alert( '비밀번호 확인과 일치하지 않습니다.' );
			// 		return false;
			// 	}
			//
			// 	if ( document.jfrm.address.value == '' ) {
			// 		alert( '주소를 입력하셔야 합니다.' );
			// 		return false;
			// 	}
			//
			// 	if ( document.jfrm.zipcode.value == '' ) {
			// 		alert( '우편번호를 입력하셔야 합니다.' );
			// 		return false;
			// 	}
			//
			// 	// 모두 통과 시, 회원가입 API 로직 실행
			// 	join()
			// };

			// 회원가입 API 로직
			function join(formData) {
				console.log("회원가입 API 로직 실행")
				console.log("mail : " + document.jfrm.mail.value)
				console.log("password : " + document.jfrm.password.value)
				console.log("passwordck : " + document.jfrm.passwordck.value)
				console.log("address : " + document.jfrm.address.value)
				console.log("zipcode : " + document.jfrm.zipcode.value)


				// location.href = "./login.do";
			}
		}
	</script>
</head>

<body>
	<div class="container-fluid my-4">
		<header class="d-flex justify-content-between align-items-center mb-3">
			<div>
				<a href="./main.do">
					<img class="brand-logo" src="./images/brand_logo.png">
				</a>
			</div>
			<div class="d-flex">
				<div class="login-btn-div">
					<a class="btn btn-outline-dark login-btn" href="./login.do">로그인</a>
				</div>
			</div>
		</header>
		<hr>
		<main class="card form-login p-5 mt-5">
<%--			<form action="./login.do" name="jfrm">--%>
			<form name="jfrm" id="joinForm">
				<div class="w-100">
					<h5>회원가입</h5>
					<hr>
				</div>

				<div class="form-floating mb-3">
					<!--이메일-->
					<input type="email" class="form-control" name="mail" id="id-input" placeholder="name@example.com">
					<label for="id-input">Email@Example.com</label>
				</div>
				<div class="form-floating mb-1">
					<!--비밀번호-->
					<input type="password" class="form-control" name="password" id="pw-input" placeholder="Password">
					<label for="pw-input">Password</label>
				</div>
				<div class="form-floating mb-3">
					<!--비밀번호 확인-->
					<input type="password" class="form-control" name="passwordck" id="pwchk-input" placeholder="Password Check">
					<label for="pwchk-input">Password Check</label>
				</div>

				<div class="form-floating mb-1">
					<!--주소-->
					<input type="text" class="form-control" name="address" id="address-input" placeholder="충청북도 청주시 청원구 오창읍 000-0">
					<label for="address-input">Address</label>
				</div>

				<div class="form-floating mb-5">
					<!--우편번호-->
					<input type="text" class="form-control" name="zipcode" id="zipcode-input" placeholder="00000">
					<label for="zipcode-input">Zip Code</label>
				</div>

				<div class="d-flex flex-column">
					<button type="submit" class="btn btn-outline-dark w-50 mx-auto py-2" id="jbtn">회원가입</button>
				</div>
			</form>
		</main>
		
	</div>
</body>

</html>