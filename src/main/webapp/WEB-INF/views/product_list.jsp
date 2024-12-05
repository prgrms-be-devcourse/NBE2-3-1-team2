<%@ page import="com.example.project01.dto.ProductTO" %>
<%@ page import="java.util.ArrayList" %>
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


			const request = new XMLHttpRequest();
			request.onreadystatechange = function() {
				if (request.readyState === 4) { // 요청이 완료된 경우
					if (request.status === 200) { // 성공적인 응답인 경우
						try {

							const jsonData = JSON.parse(request.responseText.trim());
							let result = '';
							for(let i = 0 ; i < jsonData.length ; i++){
								let row = jsonData[i];
								result += `<li class="list-group-item d-flex align-items-center">`;
								result += `<div>`;
								result += `<img class="product-img" src="./images/\${row.img}">`;
								result += `</div>`;
								result += `<div class="col">`;
								result += `<div class="text-muted">\${row.cat}</div>`;
								result += `<div>\${row.name}</div>`;
								result += `</div>`;
								result += `<div class="px-3 text-center">\${row.price}</div>`;
								result += `<div class="px-3 num-input-div">`;
								result += `<input type="text" id="count" class="num-input" value="1">`;
								result += `<div class="num-btn">`;
								result += `<button class="inc" onclick="updateValue(this,1)" />`; <!-- Up Arrow -->
								result += `<button class="dec" onclick="updateValue(this,-1)" />`;<!-- Down Arrow -->
								result += `</div>`;
								result += `</div>`;
								result += `<div class="text-end">`;
								result += `<button class="btn btn-outline-dark" onclick="addToCart('\${row.name}', '\${row.pid}', this)">담기</button>`;
								result += `</div>`;
								result += `</li>`;
							}

							document.getElementById('product-list').innerHTML = result;
							updateCartCount();

						} catch (error) {
							console.error("JSON 파싱 오류:", error);
							console.error("서버 응답:", request.responseText);
						}

					} else {
						console.error("서버 요청 실패:", request.status, request.statusText);
					}
				}
			};

			request.open( "GET", "/emp/json", true );
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
		<main class="card">
			<div class="row">
				<div class="col-md d-flex flex-column align-items-start py-3 px-4">
					<div class="w-100">
						<h5>상품 목록</h5>
						<hr>
					</div>
					<ul class="list-group products" id="product-list">

					</ul>
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

		//토스트
		function createToastMsg(msg) {
			const toast = document.createElement("div");
			toast.classList.add("toast-msg");
			toast.classList.add("hide");
			toast.textContent = msg + ' : 토스트 메세지 확인';
			console.log(msg);

			// 토스트 컨테이너에 추가
			const toastContainer = document.getElementById("toast-container");
			toastContainer.appendChild(toast);
			setTimeout(() => toast.classList.remove("hide"), 500); 

			// 3초 후에 메시지를 사라지게 하고 DOM에서 제거
			setTimeout(() => {
				toast.classList.add("hide");
				setTimeout(() => toast.remove(), 500); // 애니메이션이 끝난 후 제거
			}, 2000);
		}

		function addToCart(name, pid, button) {
			const itemBtn = button.closest('.list-group-item').querySelector('.num-input-div').querySelector('.num-input');
			if(itemBtn.value === null || itemBtn.value === undefined || itemBtn.value === ''){
				alert('상품 개수를 입력하시기 바랍니다');
				itemBtn.value = 1;
				return false;
			}
			createToastMsg(name);
			console.log(name+' '+itemBtn.value);

			const product = {
				name: name,
				pid: pid,
				count: parseInt(itemBtn.value, 10)
			};

			let cart = JSON.parse(localStorage.getItem('cart')) || [];

			// 동일한 상품이 있는지 확인
			const existingProduct = cart.find(item => item.pid === pid);

			if (existingProduct) {
				// 기존 상품의 수량 업데이트
				existingProduct.count += parseInt(itemBtn.value, 10);;
			} else {
				// 새 상품 추가
				cart.push(product);
			}

			localStorage.setItem('cart', JSON.stringify(cart));

			alert(`\${name} 상품이 \${itemBtn.value}개 추가되었습니다.`);
			updateCartCount();
		}

		function updateCartCount() {
			const cart = localStorage.getItem('cart');
			const cartCount = cart ? parseInt(JSON.parse(cart).length, 10) : 0;
			document.getElementById('cart-counter').textContent = cartCount;
		}
	</script>
</body>
</html>