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
</head>

<body>
	<div class="container-fluid my-4">
		<header class="d-flex justify-content-between align-items-center mb-3">
			<div>
				<a href="/main.do">
					<img class="brand-logo" src="./images/brand_logo.png">
				</a>
			</div>
			<div class="d-flex">
				<a href="/order.do" class="purchase quick-link">
					<img class="mx-auto" src="./images/purchase.png" width="28" height="28">
					<span class="cart-title">주문내역</span>
				</a>
				<a href="/cartview.do" class="cart quick-link">
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
		<main class="card cart-card">
			<div class="row">
				<div class="col-md d-flex flex-column align-items-start py-3 px-4">
					<div class="w-100">
						<h5>주문내역</h5>
						<hr>
					</div>

					<div class="w-100 mb-3">
						<!-- 날짜 선택 -->
						<div class="d-flex align-items-center">
							<label for="startDate" class="me-2"></label>
							<input type="date" id="startDate" class="form-control me-3" style="width: 200px;">
							<label for="endDate" class="me-2"> ~ </label>
							<input type="date" id="endDate" class="form-control me-3" style="width: 200px;">
							<button class="btn btn-dark" onclick="filterByDate()">찾기</button>
						</div>
					</div>

					<ul class="purchase-group">
						<li class="purchase-group-item">

						</li>
					</ul>
				</div>
			</div>
		</main>
	</div>

	<script src="/js/session.js"></script>
	<script src="/js/history.js"></script>
	<script src="/js/cart.js"></script>
	<script type="text/javascript">
		window.onload = function () {
			checkSession();
			setupLinks();
			cartIcon();
			purchase_detail();
		}

		let purchaseHistory;
		function purchase_detail() {
			const request = new XMLHttpRequest();
			request.open("POST", "/api/purchaseHistory", true);
			request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');

			request.onreadystatechange = function () {
				if (request.readyState === 4 && request.status === 200) {
					purchaseHistory = JSON.parse(request.responseText);
					console.log("Fetched Purchase History:", purchaseHistory);

					// 데이터를 order_time 기준으로 그룹화
					const groupedData = groupByOrderTime(purchaseHistory);
					console.log(groupedData);

					// HTML 생성 및 표시
					renderPurchaseHistory(groupedData);
				}
			};

			request.send();
		}

		// 데이터 그룹화 함수(주문내역별 품목)
		function groupByOrderTime(purchaseHistory) {
			return purchaseHistory.reduce((acc, item) => {
				if (!acc[item.order_time]) {
					acc[item.order_time] = [];
				}
				acc[item.order_time].push(item);
				return acc;
			}, {});
		}

		// 총 금액 계산 함수
		function calculateTotalPrice(orderItems) {
			return orderItems.reduce((total, item) => total + item.total_price, 0);
		}

		// 환불
		function purchase_refund(pid, cid) {

			// console.log("pid, cid", pid, cid)

			const request = new XMLHttpRequest();
			request.open("POST", "/api/purchaseUpdateState", true);
			request.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');

			request.onreadystatechange = function () {
				if (request.readyState === 4) { // 요청 완료 상태
					if (request.status === 200) {
						const response = JSON.parse(request.responseText);
						if (response.status === "refund_success") {
							alert("환불되었습니다.");
							window.location.href = "/order.do";
						} else {
							alert("환불 상태가 올바르지 않습니다.");
						}
					}
				}
			};
			// 서버로 전송할 데이터
			const payload = {
				pid: Number(pid),
				cid: Number(cid)
			};

			console.log(payload);
			request.send(JSON.stringify(payload));
		}

		// 날짜별 기준
		function normalizeDate(date) {
			return new Date(date.getFullYear(), date.getMonth(), date.getDate());
		}

		// 찾기 누르면 해당 날짜로 rendering
		function filterByDate() {
			const startDateInput = document.getElementById("startDate").value;
			const endDateInput = document.getElementById("endDate").value;

			let startDate = startDateInput ? new Date(startDateInput) : null;
			let endDate = endDateInput ? new Date(endDateInput) : null;

			// 유효성 검사
			if (startDate && endDate && startDate > endDate) {
				alert("올바른 날짜 범위를 입력해주세요.");
				return;
			}

			// 시간 정보 제거
			startDate = startDate ? normalizeDate(startDate) : null;
			endDate = endDate ? normalizeDate(endDate) : null;

			const groupedData = groupByOrderTime(purchaseHistory);

			const filteredData = Object.keys(groupedData).reduce((acc, orderTime) => {
				const orderDate = normalizeDate(new Date(orderTime)); // 시간 정보 제거

				if (
						(!startDate || orderDate >= startDate) &&
						(!endDate || orderDate <= endDate)
				) {
					acc[orderTime] = groupedData[orderTime];
				}

				return acc;
			}, {});

			renderPurchaseHistory(filteredData);
		}

	</script>
</body>

</html>