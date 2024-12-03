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

						// 정상 출력 확인
						// console.log(jsonData);

						// 제품 리스트 구성
						let result = '';
						for ( let i=0; i < jsonData.length; i++ ) {

							let jData = jsonData[i];

							result += '<li class="list-group-item d-flex align-items-center">';
							result += '<div>';
							result += '<img class="product-img" src="./images/'+ jData.img +'">';
							result += '</div>'
							result += '<div class="col">';
							result += '<div class="text-muted">' + jData.cat + '</div>';
							result += '<div>' + jData.name + '</div>';
							result += '</div>';
							result += '<div class="px-3 text-center">' + jData.price +'원</div>';
							result += '<div class="px-3 num-input-div">';
							result += '<input type="text" class="num-input" id="input-' + jData.pid + '" value="1">';
							// result += '<input type="hidden" class="product_pid" id="pid" value="' + jData.pid + '">';
							result += '<div class="num-btn">';
							result += '<button class="inc" onclick="updateValue(this,1)"/>';
							result += '<button class="dec" onclick="updateValue(this,-1)"/>';
							result += '</div>'
							result += '</div>'
							result += '<div class="text-end">';
							// result += '<button class="btn btn-outline-dark" onclick="cartIn(this, ${jData.pid})">담기</button>';
							result += '<button class="btn btn-outline-dark" onclick="cartIn(\'input-' + jData.pid + '\', ' + jData.pid + ')">담기</button>';
							result += '</div>';
							result += '</li>';
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

<%--				<ul class="list-group products">--%>
<%--					<li class="list-group-item d-flex align-items-center">--%>
<%--						<div>--%>
<%--							<img class="product-img" src="./images/coffee_bean_01.png">--%>
<%--						</div>--%>
<%--						<div class="col">--%>
<%--							<div class="text-muted">커피콩</div>--%>
<%--							<div>Columbia Nariñó</div>--%>
<%--						</div>--%>
<%--						<div class="px-3 text-center">5,000원</div>--%>
<%--						<div class="px-3 num-input-div">--%>
<%--							<input type="text" class="num-input" value="1">--%>
<%--							<div class="num-btn">--%>
<%--								<button class="inc" onclick="updateValue(this,1)" /> <!-- Up Arrow -->--%>
<%--								<button class="dec" onclick="updateValue(this,-1)" /> <!-- Down Arrow -->--%>
<%--							</div>--%>
<%--						</div>--%>
<%--						<div class="text-end">--%>
<%--							<button class="btn btn-outline-dark" onclick="createToastMsg(1)">담기</button>--%>
<%--						</div>--%>
<%--					</li>--%>
<%--				</ul>--%>

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

	function cartIn(msg, pid) {
		// console.log("msg : " + msg)
		// pid : 상품 코드 (number)
		// console.log("pid : " + pid + typeof pid)

		// 상품 갯수 입력 필드
		const inputElement = document.getElementById(msg);
		// console.log("inputElement : " + inputElement)

		// 상품 갯수 ( String )
		const inputNum = inputElement ? inputElement.value : 0;
		// console.log("inputNum : " + inputNum + typeof inputNum)

		const request = new XMLHttpRequest();
		request.onreadystatechange = function () {
			if ( request.readyState == 4 ) {
				if ( request.status == 200 ) {
					// 정상처리
					const jsonData = JSON.parse( request.responseText.trim());

					document.getElementById("cart-counter").textContent = jsonData.cartCount;

				} else {
					alert("[에러] 페이지 오류(404, 500)")
				}
			}
		}
		request.open( "POST", "/api/cart", true );

		request.setRequestHeader( 'Content-Type', 'application/x-www-form-urlencoded' );

		request.send( 'pid='+ pid +'&num=' + inputNum );

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