<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.project01.dto.ProductDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	int cookieCount = (int) request.getAttribute("cookieCount");
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
	<script type="text/javascript" async>
		window.onload = function () {
			if ( '<%=msg%>' !== 'null' ) {
				alert('<%=msg%>');
			}
			if ( '<%=cid%>' !== 'null' ) {
				document.getElementById('login-logout-btn-space').innerHTML = `<a class="btn btn-outline-dark login-btn" href="api/logout.do">로그아웃</a>`
			} else {
				document.getElementById('login-logout-btn-space').innerHTML = `<a class="btn btn-outline-dark login-btn" href="login.do">로그인</a>`
			}
			document.getElementById("product-list").innerHTML = "";
			const request = new XMLHttpRequest();
			request.onreadystatechange = function () {
				if (request.readyState == 4) {
					if (request.status == 200) {
						const jsonData = JSON.parse( request.responseText.trim() )
						let result = ``;
						for ( let row of jsonData ) {
							result += `<li class="list-group-item d-flex align-items-center">
											<div>
												<img class="product-img" src="./images/\${row.img}">
											</div>
											<div class="col">
												<div class="text-muted">\${row.cat}</div>
												<div>\${row.name}</div>
											</div>
											<div class="px-3 text-center">\${row.price.toLocaleString()}원</div>
											<div class="px-3 num-input-div">
												<input type="text" class="num-input" value="1">
												<div class="num-btn">
													<button class="inc" onclick="updateValue(this,1)"></button> <!-- Up Arrow -->
													<button class="dec" onclick="updateValue(this,-1)"></button> <!-- Down Arrow -->
												</div>
											</div>
											<div class="text-end">
												<button class="btn btn-outline-dark" onclick="createToastMsg(this, '\${row.name}', '\${row.pid}')">담기</button>
											</div>
										</li>`;
							console.log(row);
						}
						document.getElementById("product-list").innerHTML = result;
						console.log(jsonData);
					} else {
						alert("요청 실패");
					}
				}
			}
			request.open("GET", "/api/product", true);
			request.send();
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
		<main class="card">
			<div class="row">
				<div class="col-md d-flex flex-column align-items-start py-3 px-4">
					<div class="w-100">
						<h5>상품 목록</h5>
						<hr>
						<ul class='list-group products' id="product-list">
						</ul>
					</div>
				</div>
			</div>
		</main>
		<div id="toast-container">
		</div>
	</div>

	<script>
		// 숫자 증가/감소 로직
		function updateValue(button, change) {
			const input = button.closest('.num-input-div').querySelector('.num-input');
			let curValue = parseInt(input.value, 10) || 0; // 값이 없으면 0으로 초기화
			curValue += change;
			if (curValue < 1) curValue = 1; // 최소값 제한
			input.value = curValue;
		}

		// 숫자 이외의 값 입력 방지
		document.querySelectorAll(".num-input").forEach(input => {
			input.addEventListener("input", function () {
				this.value = this.value.replace(/[^0-9]/g, ""); // 숫자가 아닌 문자 제거
			});
		});

		function createToastMsg(inputNum, prdName, prdId) {
			// Toast 메시지 생성
			const toast = document.createElement("div");
			let count = parseInt(
					inputNum.closest('.list-group-item').querySelector('.num-input-div .num-input').value
			) || 0; // 숫자로 변환 및 기본값 설정
			toast.classList.add("toast-msg", "hide");
			toast.textContent = `\${prdName} \${count}개를 장바구니에 추가했습니다`;

			// Toast 컨테이너에 추가
			const toastContainer = document.getElementById("toast-container");
			toastContainer.appendChild(toast);
			setTimeout(() => toast.classList.remove("hide"), 500);

			// 3초 후 메시지 제거
			setTimeout(() => {
				toast.classList.add("hide");
				setTimeout(() => toast.remove(), 500);
			}, 2000);

			// 장바구니 쿠키 생성
			const cookies = document.cookie.split('; ').reduce((acc, cookie) => {
				const [key, value] = cookie.split('=');
				acc[key] = decodeURIComponent(value);
				return acc;
			}, {});

			let cartCookie = cookies.cart ? JSON.parse(cookies.cart) : [];

			const existingItemIndex = cartCookie.findIndex(item => item.productId === prdId);

			if (existingItemIndex !== -1) {
				cartCookie[existingItemIndex].count = parseInt(cartCookie[existingItemIndex].count) + parseInt(inputNum.closest('.list-group-item').querySelector('.num-input-div .num-input').value);
			} else {
				cartCookie.push({
					timestamp: Date.now(),
					productId: prdId,
					count: parseInt(inputNum.closest('.list-group-item').querySelector('.num-input-div .num-input').value)
				});
			}
			document.cookie = "cart=" + encodeURIComponent(JSON.stringify(cartCookie)) + `; max-age=\${60*60*24*30}; path=/`;
			document.getElementById("cart-counter").innerHTML = cartCookie.length;
		}
	</script>
</body>
</html>