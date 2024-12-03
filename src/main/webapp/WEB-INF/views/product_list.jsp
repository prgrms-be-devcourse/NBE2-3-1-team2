<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.project01.dto.ProductTO" %>
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
			<a href="">
				<img class="brand-logo" src="./images/brand_logo.png">
			</a>
		</div>
		<div class="d-flex">
			<a href="" class="purchase quick-link">
				<img class="mx-auto" src="./images/purchase.png" width="28" height="28">
				<span class="cart-title">주문내역</span>
			</a>
			<a href="" class="cart quick-link">
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
	<main class="card">
		<div class="row">
			<div class="col-md d-flex flex-column align-items-start py-3 px-4">
				<div class="w-100">
					<h5>상품 목록</h5>
					<hr>
					<ul class='productList' id="productList"></ul>
				</div>
			</div>
		</div>
	</main>
	<div id="toast-container">
	</div>
</div>

<script type="text/javascript">
	window.onload = function () {
		document.getElementById("productList").innerHTML = ""; // 기존 내용 초기화
		const request = new XMLHttpRequest();
		request.onreadystatechange = function () {
			if (request.readyState === 4) {
				if (request.status === 200) {
					const jsonData = JSON.parse(request.responseText.trim()); // JSON 파싱
					let result = ``;

					for (let i = 0; i < jsonData.length; i++) {
						const list = jsonData[i];
						result += `<li class="list-group-item d-flex align-items-center">
								<div>
									<img class="product-img" src="./images/\${list.img}" alt="\${list.name}">
								</div>
								<div class="col">
									<div class="text-muted">\${list.cat}</div>
									<div>\${list.name}</div>
								</div>
								<div class="px-3 text-center">\${list.price}</div>
								<div class="px-3 num-input-div">
									<input type="text" class="num-input form-control text-center" value="1" style="width: 50px;">
									<div class="num-btn">
										<button class="inc" onclick="updateValue(this,1)"></button>
										<button class="dec" onclick="updateValue(this,-1)"></button>
									</div>
								</div>
								<div class="text-end">
									<button class="btn btn-outline-dark" onclick="createToastMsg(this, '\${list.pid}', '\${list.name}')">담기</button>
								</div>
							</li>`;
						//console.log(list.name);
						//console.log(list.pid);
						console.log(list)
					}

					// HTML 결과 삽입
					document.getElementById("productList").innerHTML = result;
					console.log(jsonData);
				} else {
					alert("요청 실패");
				}
			}
		};

		// 서버로 요청 전송
		request.open("GET", "/api/product", true);
		request.send();
	};

	// 숫자 증가/감소 로직
	function updateValue(button, change) {
		const input = button.closest('.num-input-div').querySelector('.num-input');
		let curValue = parseInt(input.value, 10) || 0;
		curValue += change;
		if (curValue < 1) curValue = 1; // 최소값 제한
		input.value = curValue;
	}

	// 토스트 메시지 생성 및 쿠키 처리
	function createToastMsg(inputNum, productID, productName) {
		console.log(`ProductID: \${productID} ProductName: \${productName}`);

		// Toast 메시지 생성
		const toast = document.createElement("div");

		toast.classList.add("toast-msg", "hide");
		toast.textContent = `\${productName}을 장바구니에 추가했습니다`;

		// Toast 컨테이너에 추가
		const toastContainer = document.getElementById("toast-container");
		toastContainer.appendChild(toast);
		setTimeout(() => toast.classList.remove("hide"), 500);

		// 3초 후 메시지 제거
		setTimeout(() => {
			toast.classList.add("hide");
			setTimeout(() => toast.remove(), 500);
		}, 2000);

		// 쿠키 처리
		let cookies = document.cookie.split('; ');
		let existingcount = 0;

		// ------------ 쿠키 존재하는 경우, 누적해서 계산 ** --------
		let count = parseInt(
				inputNum.closest('.list-group-item').querySelector('.num-input-div .num-input').value
		) || 0;

		cookies.forEach(cookie => {
			let [key, value] = cookie.split('=');
			if (key === productID) {
				existingcount = parseInt(value) || 0;
			}
		});
		// -----------------------------------------------------------

		// 새 값 계산
		let totalProduct = existingcount + count;

		let date = new Date();
		date.setTime(date.getTime() + 60*1000);
		document.cookie = `\${productID}` + '=' + totalProduct + ';expires=' + date.toUTCString() + ';path=/';
	}
</script>

</body>
</html>
