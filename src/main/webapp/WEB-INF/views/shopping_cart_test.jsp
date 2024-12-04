<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- bootstrap.css -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
	<!-- style.css -->
	<link rel="stylesheet" href="./css/style.css">
	<title>Grids & Circle</title>
	<script type="text/javascript">
		window.onload = function() {

			// localStorage 데이터를 Json으로 가져오기
			const storedArray = JSON.parse(localStorage.getItem("items")) || [];

			// console.log(storedArray);

			let result = '';

			if( storedArray.length > 0 ) {

				const request = new XMLHttpRequest();
				request.onreadystatechange = function () {
					if ( request.readyState == 4 ) {
						if ( request.status == 200 ) {
							// 정상처리

							// json 형태로 출력
							const jsonData = JSON.parse( request.responseText.trim());

							// 정상 출력 확인
							console.log(jsonData);

							// 제품 리스트 구성
							for ( let i=0; i < jsonData.length; i++ ) {

								let jData = jsonData[i];

								result += '<li class="list-group-item d-flex align-items-center position-relative">' +
										'<div>' +
										'<img class="product-img" src="./images/'+ jData.img +'">' +
										'</div>' +
										'<div class="col">' +
										'<div class="text-muted">' + jData.cat + '</div>' +
										'<div>' + jData.name + '</div>' +
										'</div>' +
										'<div class="px-3 text-center">' + jData.price +'원</div>' +
										'<div class="px-3 num-input-div">' +
										'<input type="text" class="num-input" id="input-' + jData.pid + '" value="1">' +
										'<div class="num-btn">' +
										'<button class="inc" onclick="updateValue(this,1)"/>' +
										'<button class="dec" onclick="updateValue(this,-1)"/>' +
										'</div>' +
										'</div>' +
										'<div class="text-end">' +
										'<button class="btn btn-outline-dark" onclick="cartIn(\'input-' + jData.pid + '\', ' + jData.pid + ')">담기</button>' +
										'</div>' +
										'</li>';
							}

						} else {
							alert("[에러] 페이지 오류(404, 500)")
						}
					}
				}

				// 담은 상품 id 가져오기
				const pidArray = JSON.parse(localStorage.getItem("pidArray")) || [];

				const params = new URLSearchParams();
				params.append("pidArray", JSON.stringify(pidArray));	// url 쿼리 파라미터로 변환 (타입 : String)

				// console.log(params.toString());
				// console.log(typeof params.toString());

				request.open("GET", "/api/cartList?" + params.toString(), true);

				request.send();


			} else {
				result += '<li class="list-group-item d-flex align-items-center">' +
				'<div>' +
				'<h3> 담긴 상품이 없습니다 </h3>' +
				'</div>' +
				'</li>';
			}

			document.getElementById('result').innerHTML = result;

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
<%--				<a href="" class="cart quick-link">--%>
<%--					<img class="mx-auto" src="./images/cart.png" width="28" height="28">--%>
<%--					<span class="cart-title">장바구니</span>--%>
<%--					<em class="cart-count" id="cart-counter">0</em>--%>
<%--				</a>--%>
<%--				<div class="login-btn-div">--%>
<%--					<a class="btn btn-outline-dark login-btn" href="">로그인</a>--%>
<%--				</div>--%>
			</div>
		</header>
		<hr>
		<main class="card cart-card">
			<div class="row">
				<div class="col d-flex flex-column align-items-start py-3 px-4">
					<div class="w-100">
						<h5>장바구니</h5>
						<hr>
					</div>
					<div class="d-flex w-100 cart-container">
						<ul class="list-group products col" id="result">

							<li class="list-group-item d-flex align-items-center position-relative">
								<div>
									<img class="product-img" src="./images/coffee_bean_01.png">
								</div>
								<div class="col">
									<div class="text-muted">커피콩</div>
									<div>Columbia Nariñó</div>
								</div>
								<div class="px-3 text-center">5,000원</div>
								<div class="px-3 num-input-div">
									<input type="text" class="num-input" value="1">
									<div class="num-btn">
										<button class="inc" onclick="updateCart(this,1)" /> <!-- Up Arrow -->
										<button class="dec" onclick="updateCart(this,-1)" /> <!-- Down Arrow -->
									</div>
								</div>
								<a class="delete-btn" href="">X</a>
							</li>

						</ul>
						<div class="mx-3 purchase-form">
							<hr>
							<div class="d-flex justify-content-between mt-2">
								<span>총 금액</span>
								<span>50,000원</span>
							</div>
							<hr>
							<form action="" method="">
								<div class="form-floating mb-2">
									<input type="email" class="form-control" id="id-input" placeholder="name@example.com">
									<label for="id-input">Email@Example.com</label>
								</div>
								<div class="form-floating mb-2">
									<input type="text" class="form-control" id="address-input" placeholder="충청북도 청주시 청원구 오창읍 000-0">
									<label for="address-input">Address</label>
								</div>
								<div class="form-floating mb-2">
									<input type="text" class="form-control" id="zipcode-input" placeholder="00000">
									<label for="zipcode-input">Zip Code</label>
								</div>
								<div class="mt-5">
									<button class="btn btn-dark w-100" type="submit">주문하기</button>
								</div>
							</form>
						</div>
					</div>

				</div>
			</div>
		</main>
	</div>

	<script>
		// 숫자 증가/감소 로직
		function updateCart(button, change) {
			const input = button.closest('.num-input-div').querySelector('.num-input');
			let curValue = parseInt(input.value, 10) || 0; // 값이 없으면 0으로 초기화
			curValue += change;
			if (curValue < 1) curValue = 1; // 최소값 제한
			input.value = curValue;
		}

		// 숫자 이외의 값 입력 방지
		document.querySelectorAll(".num-input").forEach(input => {
			input.addEventListener("input", function () {
				this.value = this.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자 제거
			});
		});
	</script>
</body>

</html>