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

	<script type="text/javascript">
		window.onload = function () {fetch("/emp/loginStatus")
				.then(response => response.json())
				.then(data => {
					const loginStatusDiv = document.getElementById("loginStatus");
					if (data.isLoggedIn) {
						loginStatusDiv.innerHTML = `<a href="/emp/logout" class="btn btn-outline-dark">로그아웃</a>`;
						const userCid = sessionStorage.getItem("cid");
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
							//console.log("Received data:", request.responseText);

							const jsonData = JSON.parse(request.responseText.trim());
							let result = '';

							// 날짜 포맷 변환 함수 추가
							const formatDate = (timestamp) => {
								const date = new Date(timestamp); // KST로 처리

								const year = date.getFullYear();
								const month = String(date.getMonth() + 1).padStart(2, '0');
								const day = String(date.getDate()).padStart(2, '0');
								const hours = String(date.getHours()).padStart(2, '0');
								const minutes = String(date.getMinutes()).padStart(2, '0');

								return `\${year}-\${month}-\${day} \${hours}:\${minutes}`;
							};

							const groupedOrders = {};

							jsonData.forEach(item => {
								if (!groupedOrders[item.pid]) {
									groupedOrders[item.pid] = {
										pid: item.pid,
										ot: formatDate(item.ot),
										sst: item.sst,
										zip: item.zip,
										addr: item.addr,
										st: item.st,
										products: []
									};
								}
								// 각 제품을 해당 주문에 추가
								groupedOrders[item.pid].products.push({
									prd_id: item.prd_id,
									qty: item.qty,
									price: item.price,
									img: item.img
								});
							});

							// groupedOrders를 배열로 변환 (주문별로 묶인 형태)
							const orders = Object.values(groupedOrders);
							orders.sort((a, b) => b.pid - a.pid); // 내림차순 정렬

							// 출력하기
							orders.forEach(order => {
								result += `<li class="purchase-group-item">
											  <div class="ms-1 mb-1 d-flex justify-content-between">
												<span>주문번호 : \${order.pid} ( \${order.ot} )</span>
												<span class="me-3">\${order.st}</span>
											  </div>
											  <div class="d-flex purchase-list-container">
												<ul class="col list-group">`;

								order.products.forEach(product => {
									result += `<li class="list-group-item d-flex align-items-center">
									<div>
									  <img class="product-img" src="./images/\${product.img}">
									</div>
									<div class="col">
									  <div class="text-muted">커피콩</div>
									  <div>\${product.prd_id}</div>
									</div>
									<div class="px-3">\${product.qty}개</div>
									<div class="px-3 text-center">\${product.price.toLocaleString()}원</div>
								  </li>`;
								});

								result += `</ul>
											  <div class="px-3 my-auto">
												<div class="my-4 d-flex justify-content-between">
												  <span class="pe-4">총 금액</span>
												  <span class="ps-4">\${order.products.reduce((total, product) => total + product.price, 0).toLocaleString()}원</span>
												</div>`
								if(order.st === "환불 완료") {
									result += `<button class="w-100 btn btn-danger")>환불된 주문</button>`
								} else {
									result += `<button class="w-100 btn btn-dark" onclick=refund('\${order.pid}')>환불하기</button>`
								}
								result +=  `</div>
											</div>
											<hr>
										  	</li>`;

								// 결과를 화면에 출력 (예시)
								document.getElementById('history-list').innerHTML += result;
							});

							document.getElementById('history-list').innerHTML = result;
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

			request.open( "GET", "/emp/history", true );
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
					<a class="btn btn-outline-dark login-btn" href="login.do" >로그인</a>
				</div>
			</div>
		</header>
		<hr>
		<main class="card cart-card">
			<div class="row">
				<div class="col-md d-flex flex-column align-items-start py-3 px-4">
					<div class="w-100">
						<h5>주문내역</h5>
						<hr>
					</div>
					<ul class="purchase-group" id="history-list">

					</ul>
				</div>
			</div>
		</main>
	</div>

	<script type="text/javascript">
		function updateCartCount() {
			const cart = localStorage.getItem('cart');
			const cartCount = cart ? parseInt(JSON.parse(cart).length, 10) : 0;
			document.getElementById('cart-counter').textContent = cartCount;
		}

		function refund(pid) {
			// 팝업 창 띄우기
			if (confirm('환불하시겠습니까?')) {
				// '예'를 클릭하면 실행되는 코드
				processRefund(pid);
			} else {
				// '아니오'를 클릭하면 실행되는 코드
				console.log('환불 취소');
			}
		}

		async function processRefund(pid) {
			try {
				// 서버로 PUT 요청 보내기
				const response = await fetch(`/emp/refund/\${pid}`, {
					method: 'PUT',
				});

				if (response.ok) {
					const result = await response.text();
					alert('환불이 완료되었습니다.');
					window.location.href = '/order.do';
				} else {
					alert('환불에 실패했습니다.');
				}
			} catch (error) {
				console.error('Error:', error);
				alert('오류가 발생했습니다.');
			}
		}

	</script>
</body>

</html>