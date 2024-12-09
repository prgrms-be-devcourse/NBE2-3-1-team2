<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.project01.dto.ProductOrderDTO" %>
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
	<link rel="stylesheet" href="./css/searchButton.css">
	<link rel="stylesheet" href="./css/refundCheck.css">
	<!-- bootstrap.css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
	<title>Grids & Circle</title>
	<script type="text/javascript">
		let throttleTimer = false;

		// 데이터를 받아올 날짜 지정
		let startDate = `/`;
		let endDate = `/`;

		// 주문 내역과 상품 정보를 담을 변수
		let orderHistory = '';
		let product = '';

		// 주문 날짜와 배송 날짜의 변동을 체크
		let diffOrderDate = [1];
		let diffShippingDate = [1]

		// 페이지 로딩 제한
		let loadingLimit = 10
		let loadDatalimit = 10;
		let judPaging = false;
		let stopLoadingPointList = [];

		// 로딩 관련 변수
		let currLoadingPoint = 0;
		let currListPoint = 0;

		window.onload = function () {
			if ( '<%=cid%>' !== 'null' ) {
				document.getElementById('login-logout-btn-space').innerHTML = `<a class="btn btn-outline-dark login-btn" href="api/logout.do">로그아웃</a>`
			} else {
				document.getElementById('login-logout-btn-space').innerHTML = `<a class="btn btn-outline-dark login-btn" href="login.do">로그인</a>`
			}

			document.getElementById('start-date').addEventListener('change', startOfDate);
			document.getElementById('end-date').addEventListener('change', endOfDate);
			document.getElementById('search-btn').addEventListener('click', function () {
				document.getElementById("list-space").innerHTML = '';
				currLoadingPoint = 0;
				currListPoint = 0;
				diffDate();
				console.log(`api/orderList\${startDate}\${endDate}`);
				pageWrite();});
			document.getElementById('start-date').value = new Date().toISOString().split('T')[0];
			document.getElementById('end-date').value = new Date().toISOString().split('T')[0];
			document.querySelectorAll('.search-btn').forEach(button => button.innerHTML = '<div><span>' + button.textContent.trim().split('').join('</span><span>') + '</span></div>');
			document.querySelectorAll('.btn-search').forEach(button => button.addEventListener('click', function () {
				document.getElementById("list-space").innerHTML = '';
				currLoadingPoint = 0;
				currListPoint = 0;
				startDate = this.dataset.diffdays;
				endDate = ``;
				pageWrite()
			}));
		}

		// getOrderData() 가 끝난 후 페이지 로드
		async function pageWrite() {
			if ( startDate === '/' || endDate === '/' ) {
				return;
			}
			try {
				orderHistory = await getOrderHistoryData();
				product = await getProductData();
				if ( orderHistory.length === 0 ) {
					document.getElementById("list-space").innerHTML = `<div class="d-flex justify-content-center align-items-center" style="height: 300px">주문 내역이 없습니다.</div>`;
					return;
				}
				let flag = dateDiffList();
				getStopLoadingPoint();
				if ( flag === -1 ) {
					document.getElementById("list-space").innerHTML = `<div class="d-flex justify-content-center align-items-center" style="height: 300px">주문 내역이 없습니다.</div>`;
					return;
				} else {
					pageLoad();
					document.querySelectorAll('.chk-refund-label').forEach(button => button.addEventListener('click', function () {
						let checkbox = this.closest(`.chk-refund-space`);
						if (checkbox.querySelector('.chk-refund').checked) {
							checkbox.querySelector('.chk-refund').checked = false;
						} else {
							checkbox.querySelector('.chk-refund').checked = true;
						}
					}));
				}
			} catch (error) {
				console.error("에러 발생:", error);
			}
		}

		// 스크롤 이벤트 - 마지막까지 내리면 새로운 페이지 로드
		window.addEventListener('scroll', function () {
			const { scrollTop, scrollHeight, clientHeight } = document.documentElement;
			if (scrollTop + clientHeight >= scrollHeight - 20) {
				if (!throttleTimer) {
					throttleTimer = true;
					setTimeout(function() {
						if ( currLoadingPoint < stopLoadingPointList.length-1 ) {
							currLoadingPoint += 1;
							currListPoint = stopLoadingPointList[currLoadingPoint-1] + 1;
							// pageLoad();
						}
					throttleTimer = false;
					}, 300); // 1초에 한 번만 이벤트 실행
				}
			}
		});

		// API로부터 OrderHistory와 Product 를 받아 리턴하는 함수
		function getOrderHistoryData() {
			return new Promise((resolve, reject) => {
				const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function () {
					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							resolve(JSON.parse(xhr.responseText.trim()));
						} else {
							reject(xhr.status);
						}
					}
				}
				xhr.open('GET', `api/orderList\${startDate}\${endDate}`, true);
				xhr.send();
			});
		}
		function getProductData() {
			return new Promise((resolve, reject) => {
				const xhr = new XMLHttpRequest();
				xhr.onreadystatechange = function () {
					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							resolve(JSON.parse(xhr.responseText.trim()));
						} else {
							reject(xhr.status);
						}
					}
				}
				xhr.open('GET', `api/product`, true);
				xhr.send();
			});
		}

		// 주문 내역 페이지 로드
		function pageLoad() {

			let result = ``;
			let totalPrice = 0;

			// for ( let i = currListPoint ; i <= stopLoadingPointList[currLoadingPoint] ; i++ ) {
			for ( let i = 0 ; i < orderHistory.length ; i++ ) {
				let order = orderHistory[i];

				// 주문 내역 정보
				let productID = order.prd_id
				let img = product[productID-1].img
				let cat = product[productID-1].cat
				let name = product[productID-1].name
				let orderNumber = order.pid
				let purchaseDate = order.ot.split('T')[0] + ' ' + order.ot.split('T')[1]
				let qty = order.qty
				let sst = order.sst
				let st = order.st
				let price = order.price.toLocaleString()
				let shippingTime = new Date(sst);
				shippingTime.setHours(14, 0, 0, 0);
				let shippingYear = shippingTime.getFullYear();
				let shippingMonth = shippingTime.getMonth() + 1;
				let shippingDay = shippingTime.getDate();
				if ( diffShippingDate[i] === 1 || diffShippingDate[i] === 3 ) {
					result += `<div class="border border-secondary rounded-3 p-3 mb-2">`;
					if ( st === 1 ) {
						result += `<span className="d-flex flex-row-reverse me-3" style="font: italic 1.2rem 'D2Coding', serif;">배송 준비 중 - \${shippingYear}년 \${shippingMonth}월 \${shippingDay}일 14시 도착 예정</span>`;
					} else if ( st === 2 ) {
						result += `<span className="d-flex flex-row-reverse me-3" style="font: italic 1.2rem 'D2Coding', serif;">배송 완료</span>`;
					} else {
						result += `<span className="d-flex flex-row-reverse me-3" style="font: italic 1.2rem 'D2Coding', serif;">환불</span>`;
					}
				}

				if ( diffOrderDate[i] === 1 || diffOrderDate[i] === 3 ) {
					result += `<li class="purchase-group-item">
								<div class="ms-1 mb-1 d-flex justify-content-between">
									<span>주문번호 : \${orderNumber} ( \${purchaseDate} )</span>
								</div>
								<div class="d-flex purchase-list-container">
									<ul class="col list-group">`;
				}

				// 총 금액 계산
				totalPrice += order.price;

				// 주문 내역 리스트 추가
				result += `<li class="list-group-item d-flex align-items-center"  data-prdid=\${productID} data-pid=\${orderNumber}>
											<div>
												<i class="bi bi-arrow-down-left-circle-fill"></i>
												<img class="product-img" src="./images/\${img}">
											</div>
											<div class="col">
												<div class="text-muted">\${cat}</div>
												<div>\${name}</div>
											</div>
											<div class="px-3">\${qty}개</div>
											<div class="px-3 text-center">\${price}원</div>
							`;
				if ( judPaging ) {
					result += `<div class="d-flex chk-refund-space" style="padding-left: 20px">
								<input type="checkbox" id="chk-refund-\${i}" class="chk-refund" data-prdid=\${productID} data-pid=\${orderNumber}>
								<label for="chk-refund" class="chk-refund-label"></label>
								<label for="chk-refund" class="chk-refund-label">환불</label>
							</div>
						</li>`;
				}
				// 주문 일자가 다를경우 새로운 주문 그룹 생성
				if ( diffOrderDate[i] === 2 || diffOrderDate[i] === 3 ) {
					totalPrice = totalPrice.toLocaleString();
					if ( !judPaging ){
						result += `</li>
							</ul>
								<div class="px-3 my-auto">
									<div class="my-4 d-flex justify-content-between">
										<span class="pe-4">총 금액</span>
										<span class="ps-4">\${totalPrice}원</span>
									</div>`;
						if ( st === 1 ) {
							result +=`<button class="w-100 btn btn-dark btn-pulse-dark" onclick="refundLoading(event)">환불하기</button>
										</div>`;
						} else if ( st === 2 ) {
							result += `<button class="w-100 delivered-btn">배송완료</button>
										</div>`;
						} else {
							result += `<button class="w-100 refunded-btn">환불완료</button>
										</div>`;
						}
					}
					result += `</div>
						</li>`;
					if ( diffShippingDate[i] !== 2 && diffShippingDate[i] !== 3 ) {
						result += `<hr>`;
					}
					totalPrice = 0;
				}

				if ( diffShippingDate[i] === 2 || diffShippingDate[i] === 3 ) {
					result += `</div>`;
					if ( judPaging ){
						if ( ( i % 10 ) === 9 ) {
							result += `<button class="w-100 btn btn-dark" onclick="refundPaging(event)">환불하기</button>`
						} else { result += `<hr>`; }
					} else if ( i !== stopLoadingPointList[currLoadingPoint] ) { result += `<hr>`; }
				}
			}
			document.getElementById("list-space").innerHTML += result;
		}

		// 조회 시작일 / 종료일 변경
		function startOfDate() {
			let selectedEndDay = document.getElementById('end-date').value;

			let diffDay = 0;
			let today = new Date();
			today.setHours(9, 0, 0, 0)
			let date = new Date(this.value);
			if ( (today - date)/24/60/60/1000 < 0) {
				alert('오늘 이후로는 조회할 수 없습니다.');
				startDate = `/`;
				endDate = `/`;
				document.getElementById('start-date').value = '';
				return;
			}

			if ( selectedEndDay !== '' ) {
				diffDay = diffDate();
				if (diffDay < 0) {
					startDate = `/`;
					endDate = `/`;
					alert('조회 시작일은 조회 종료일보다 늦을 수 없습니다.');
					document.getElementById('start-date').value = '';
				}
			}
		}

		function endOfDate() {
			let selectedStartDay = document.getElementById('start-date').value;

			let diffDay = 0;
			let today = new Date();
			today.setHours(9, 0, 0, 0)
			let date = new Date(this.value);
			if ( (today - date)/24/60/60/1000 < 0) {
				alert('오늘 이후로는 조회할 수 없습니다.');
				startDate = `/`;
				endDate = `/`;
				document.getElementById('end-date').value = '';
				return;
			}

			if ( selectedStartDay !== '' ) {
				diffDay = diffDate();
				if (diffDay < 0) {
					startDate = `/`;
					endDate = `/`;
					alert('조회 종료일은 조회 시작일보다 빠를 수 없습니다.');
					document.getElementById('end-date').value = '';
				}
			}
		}

		// 주문 날짜와 배송 날짜의 변동을 체크
		function dateDiffList() {
			diffOrderDate = [1];
			diffShippingDate = [1];
			let tempOrderDate = '';
			let tempShippingDate = '';
			let tempRefundDate = orderHistory[0].st;
			let refundStart = [];
			let refundEnd = [];

			if ( tempRefundDate === -1 ) {
				refundStart.push(0);
			}

			for ( let i = 1 ; i < orderHistory.length ; i++ ) {
				if ( orderHistory[i].st !== tempRefundDate) {
					if ( orderHistory[i].st === -1 ) {
						refundStart.push(i);
					} else {
						refundEnd.push(i-1);
					}
					tempRefundDate = orderHistory[i].st;
				}
			}
			if ( orderHistory.length === 0 ) {
				return -1;
			}
			tempOrderDate = orderHistory[0].ot;
			tempShippingDate = orderHistory[0].sst;
			for ( let i = 1 ; i < orderHistory.length-1 ; i++ ) {
				if ( tempOrderDate !== orderHistory[i].ot ) {
					diffOrderDate[i-1] += 2;
					diffOrderDate[i] = 1;
					tempOrderDate = orderHistory[i].ot;
				} else { diffOrderDate[i] = 0; }
				if ( tempShippingDate !== orderHistory[i].sst ) {
					diffShippingDate[i-1] += 2;
					diffShippingDate[i] = 1;
					tempShippingDate = orderHistory[i].sst;
				} else { diffShippingDate[i] = 0; }
			}
			let isRefund = false;
			for ( let i = 0 ; i < diffShippingDate.length ; i++ ) {
				if ( refundStart.includes(i) ) {
					diffShippingDate[i] = 1;
					if ( i-1 >= 0 && diffShippingDate[i-1] < 2 ) {
						diffShippingDate[i-1] += 2;
					}
					isRefund = true;
				}
				if ( refundEnd.includes(i) ) {
					diffShippingDate[i] = 2;
					if ( i+1 < diffShippingDate.length && diffShippingDate[i+1] !== 1 ) {
						diffShippingDate[i+1] += 1;
					}
					isRefund = false;
				}
				if ( refundEnd.includes(i) && refundStart.includes(i) ) {
					diffShippingDate[i] = 3;
					isRefund = false;
				}
			}
			diffOrderDate.push(2);
			diffShippingDate.push(2);
			return 1;
		}

		// 날짜 차이 계산
		function diffDate() {
			if ( document.getElementById('start-date').value === '' || document.getElementById('end-date').value === '' ) {
				alert('조회 시작일과 조회 종료일을 입력해주세요.');
				return;
			}
			let today = new Date();
			let selectedStartDay = new Date(document.getElementById('start-date').value);
			let selectedEndDay = new Date(document.getElementById('end-date').value);

			let todayYear = today.getFullYear();
			let todayMonth = today.getMonth();
			let todayDay = today.getDate();

			let startYear = selectedStartDay.getFullYear();
			let startMonth = selectedStartDay.getMonth();
			let startDay = selectedStartDay.getDate();

			let endYear = selectedEndDay.getFullYear();
			let endMonth = selectedEndDay.getMonth();
			let endDay = selectedEndDay.getDate();

			let dateToday = new Date(todayYear, todayMonth, todayDay);
			let date1 = new Date(startYear, startMonth, startDay);
			let date2 = new Date(endYear, endMonth, endDay);

			let timeDifference = date2 - date1;
			let dayDifference = timeDifference / (1000 * 3600 * 24);

			let timeDifferenceTodayStartDay = dateToday - date1;
			let dayDifferenceTodayStartDay = timeDifferenceTodayStartDay / (1000 * 3600 * 24);

			let timeDifferenceTodayEndDay = dateToday - date2;
			let dayDifferenceTodayEndDay = timeDifferenceTodayEndDay / (1000 * 3600 * 24);

			startDate = `/\${dayDifferenceTodayStartDay}`;
			endDate = `/\${dayDifferenceTodayEndDay}`;
			return dayDifference;
		}

		function getStopLoadingPoint() {
			stopLoadingPointList= [];
			// paging 일 때 구분
			if ( judPaging ) {
				for (let i = 0; i < diffShippingDate.length; i++) {
					if (diffShippingDate[i] <= 1 && (i % 10) === 9) {
						diffShippingDate[i] += 2;
						if (diffShippingDate[i + 1] === 0 || diffShippingDate[i + 1] === 2) {
							diffShippingDate[i + 1] += 1;
						}
					}
				}
				for (let i = 0; i < diffOrderDate.length; i++) {
					if (diffOrderDate[i] <= 1 && (i % 10) === 9) {
						diffOrderDate[i] += 2;
						if (diffOrderDate[i + 1] === 0 || diffOrderDate[i + 1] === 2) {
							diffOrderDate[i + 1] += 1;
						}
					}
				}
			}

			for ( let i = 0 ; i < diffShippingDate.length ; i++ ) {
				if ( diffShippingDate[i] >= 2 ) {
					stopLoadingPointList.push(i);
				}
			}
			console.log(orderHistory.length);
			console.log(diffShippingDate);
			let deleteList = [];
			for ( let i of stopLoadingPointList ) {
				if ( i < loadingLimit ) {
					deleteList.push(i);
				} else {
					loadingLimit += i;
				}
			}
			console.log('stop : ', stopLoadingPointList);
			console.log('delete : ', deleteList);
		}

		function refundPaging(e) {
			const button = e.target;
			let checkbox = button.closest(`.purchase-group`);
			let chkRefund = checkbox.querySelectorAll('.chk-refund');
			let prdId = '';
			let pid = '';
			let result = '{';
			let count = 0;
			for ( let i = 0 ; i < chkRefund.length ; i++ ) {
				if ( chkRefund[i].checked ) {
					prdId = chkRefund[i].getAttribute('data-prdid');
					pid = chkRefund[i].getAttribute('data-pid');
					result += `"\${count}":{"pid" : \${pid}, "prd_id" : \${prdId}},`
					count += 1;
				}
			}
			let arr = result.split("");
			arr[arr.length - 1] = '}'; // 배열 수정
			result = arr.join("");
			result = JSON.parse(result);
			// let refundList = [];
			// for ( let i = 0 ; i < chkRefund.length ; i++ ) {
			// 	if ( chkRefund[i].checked ) {
			// 		refundList.push(chkRefund[i].getAttribute('data-pid'));
			// 	}
			// }
			// if ( refundList.length === 0 ) {
			// 	alert('환불할 상품을 선택해주세요.');
			// 	return;
			// }
			// let xhr = new XMLHttpRequest();
			// xhr.onreadystatechange = function () {
			// 	if (xhr.readyState == 4) {
			// 		if (xhr.status == 200) {
			// 			alert('환불이 완료되었습니다.');
			// 			location.reload();
			// 		} else {
			// 			alert('환불에 실패했습니다.');
			// 		}
			// 	}
			// }
			// xhr.open('POST', `api/refund\${prdId}\${pid}`, true);
			// xhr.setRequestHeader('Content-Type', 'application/json');
			// xhr.send(JSON.stringify(refundList));
		}

		function refundLoading(e) {
			let button = e.target;
			let checkbox = button.closest(`.purchase-group-item`);
			let pid = checkbox.querySelector('.list-group-item').dataset.pid;
			let xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function () {
				if (xhr.readyState == 4) {
					if (xhr.status == 200) {
						if ( xhr.responseText === '1' ) {
							alert('환불이 완료되었습니다.');
							pageWrite()
						} else {
							alert('환불에 실패했습니다.');
						}
					} else {
						alert('환불에 실패했습니다.');
					}
				}
			}
			xhr.open('PUT', `api/refund/\${pid}`, true);
			xhr.send();
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
		<main class="card cart-card">
			<div class="row">
				<div class="col-md d-flex flex-column align-items-start py-3 px-4">
					<div class="w-100" style="align-content: center">
						<div class="float-start" style="padding-left: 20px; padding-top: 15px">
							<h5 style="font-family:'은 돋움';font-weight: bold; font-size: 30px; color : #101a40">주문내역</h5>
						</div>
						<div class="d-flex form-floating float-end" style="padding-left: 15px; padding-top: 10px">
							<button class="search-btn" id="search-btn"><p style="line-height: 50%; font-family: 'Roboto', Arial">Search</p></button>
						</div>
						<div class="d-flex form-floating float-end" style="padding-left: 5px">
							<input type="date" class="d-flex form-control" id="end-date">
							<label for="end-date">조회 종료일</label>
						</div>
						<div class="d-flex form-floating float-end" style="padding-left: 5px">
							<input type="date" class="d-flex form-control" id="start-date">
							<label for="start-date">조회 시작일</label>
						</div>
						<div class="d-flex form-floating float-end" style="margin-right: 10px !important;">
							<button class="btn btn-search btn-search-gray btn-pulse-gray" style="margin-right: 0 !important;" data-diffdays="/0">오늘</button>
							<button class="btn btn-search btn-search-dark btn-pulse-dark" style="margin-right: 0 !important;" data-diffdays="/6">일주일</button>
							<button class="btn btn-search btn-search-gray btn-pulse-gray" style="margin-right: 0 !important;" data-diffdays="/29">삼십일</button>
							<button class="btn btn-search btn-search-dark btn-pulse-dark" style="margin-right: 0 !important;" data-diffdays="/365">일년</button>
						</div>
					</div>
					<hr>
					<ul id="list-space" class="purchase-group">
					</ul>
				</div>
			</div>
		</main>
	</div>
</body>

</html>