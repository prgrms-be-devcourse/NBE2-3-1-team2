<%@ page import="java.util.HashMap" %>
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
	<script type="text/javascript">
		window.onload = function() {

			const request = new XMLHttpRequest();
			request.onreadystatechange = function () {
				if ( request.readyState == 4 ) {
					if ( request.status == 200 ) {
						// 정상처리

						// json 형태로 출력
						const jsonData = JSON.parse( request.responseText.trim());

						// localStorage 여부에 따른 상품 개수 및 담긴 상품 종류 개수 동적 구현
						// localStorage 데이터를 Json으로 가져오기 ( 스토리지에 데이터가 있으면, 있는 걸로 진행 )
						const storedArray = JSON.parse(localStorage.getItem("items")) || [];
						if( storedArray.length > 0 ) {
							document.getElementById("cart-counter").textContent = storedArray.length;
						}

						// 제품 리스트 구성
						let result = '';
						for ( let i=0; i < jsonData.length; i++ ) {

							let jData = jsonData[i];
							let pid = jData.pid;
							let img = jData.img;
							let cat = jData.cat;
							let name = jData.name;
							let price = parseInt(jData.price, 10);
							let value = "1";

							const pidItem = storedArray.find(item => item.key === Number(pid));
							if( pidItem ) {
								value = pidItem.number;
							}

							result += '<li class="list-group-item d-flex align-items-center">' +
										'<div>' +
										'<img class="product-img" src="./images/'+ img +'">' +
										'</div>' +
										'<div class="col">' +
										'<div class="text-muted">' + cat + '</div>' +
										'<div>' + name + '</div>' +
										'</div>' +
										// '<div class="px-3 text-center">' + jData.price +'원</div>' +
										'<div class="px-3 text-center">' + price +'원</div>' +
										'<div class="px-3 num-input-div">' +
										'<input type="text" class="num-input" id="input-' + pid + '" value="'+ value +'">' +
										'<div class="num-btn">' +
										'<button class="inc" onclick="updateValue(this,1)"/>' +
										'<button class="dec" onclick="updateValue(this,-1)"/>' +
										'</div>' +
										'</div>' +
										'<div class="text-end">' +
										'<button class="btn btn-outline-dark" onclick="cartIn(\'input-' + pid + '\', ' + pid + ',' + price + ')">담기</button>' +
										'</div>' +
										'</li>';
						}

						document.getElementById('result').innerHTML = result;

					} else {
						alert("[에러] 페이지 오류(404, 500)")
					}
				}
			}
			request.open("GET", "/api/productList", true);
			request.send();

		};
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
			<a href="./order.do" class="purchase quick-link">
				<img class="mx-auto" src="./images/purchase.png" width="28" height="28">
				<span class="cart-title">주문내역</span>
			</a>
			<a href="./cartview.do" class="cart quick-link">
				<img class="mx-auto" src="./images/cart.png" width="28" height="28">
				<span class="cart-title">장바구니</span>
				<em class="cart-count" id="cart-counter">0</em>
			</a>
			<div class="login-btn-div">
				<a class="btn btn-outline-dark login-btn" href="./login.do">로그인</a>
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

				<ul class="list-group products" id="result">
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

	function cartIn(msg, pid, unitPrice) {

		// 상품 갯수 입력 필드
		const inputElement = document.getElementById(msg);

		// 상품 갯수 ( String )
		const inputNum = inputElement ? inputElement.value : 0;

		console.log(typeof inputNum);

		if( inputNum === 0 || inputNum == null ){
			alert('상품 개수를 입력하시기 바랍니다.')
			return false;
		}

		const storedArray = JSON.parse(localStorage.getItem("items")) || [];
		const pidArray = JSON.parse(localStorage.getItem("pidArray")) || []

		const pidItem = storedArray.find(item => item.key === pid);

		if (pidItem) {
			// 이미 존재하는 경우 -> 값을 업데이트
			pidItem.number = inputNum;
			pidItem.totalPrice = unitPrice * inputNum;

		} else {
			// 존재하지 않는 경우 -> 새로 추가
			let tPrice = unitPrice * inputNum;
			storedArray.push({ key: pid, number: inputNum, unitPrice: unitPrice ,totalPrice : tPrice });
			pidArray.push(pid);
		}

		// 변경된 데이터 localStorage에 저장
		localStorage.setItem("items", JSON.stringify(storedArray));
		localStorage.setItem("pidArray", JSON.stringify(pidArray));
		// 선택 상품 갯수 표기
		document.getElementById("cart-counter").textContent = storedArray.length;

		// 팝업창 기능 (신경 x)
		const toast = document.createElement("div");
		toast.classList.add("toast-msg");
		toast.classList.add("hide");
		toast.textContent = msg + ' : 장바구니에 담겼습니다.';

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
</script>
</body>
</html>