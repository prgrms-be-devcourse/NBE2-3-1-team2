<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- bootstrap.css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <!-- style.css -->
    <link rel="stylesheet" href="./css/style.css">
    <script src="./script/user.js" async></script>
    <title>Grids & Circle</title>
</head>

<body>
<div class="container-fluid my-4">
    <div id="modal-box">

    </div>
    <header class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <a href="/main.do">
                <img class="brand-logo" src="./images/brand_logo.png">
            </a>
        </div>
        <div class="d-flex">
            <a href="/order.do" class="purchase quick-link">
                <img class="mx-auto" src="./images/purchase.png" width="28" height="28">
                <span class="cart-title">마이페이지</span>
            </a>
            <a href="/cart.view" class="cart quick-link">
                <img class="mx-auto" src="./images/cart.png" width="28" height="28">
                <span class="cart-title">장바구니</span>
                <em class="cart-count" id="cart-counter">0</em>
            </a>
            <div class="login-btn-div" id="auth-check">
            </div>
        </div>
    </header>
    <hr>
    <main class="card cart-card">
        <aside class="float-box">
            <ul>
                <li class="float-link"><img src="./images/link.png"></li>
                <li><a href="/mypage.do"><img src="./images/user.png">회원 정보</a></li>
                <li><a href="/order.do"><img src="./images/history.png">주문 내역</a></li>
            </ul>
        </aside>
        <div class="row">
            <div class="col d-flex flex-column py-3 px-4">
                <div class="w-100">
                    <div class="d-flex justify-content-between">
                        <h5 class="align-self-center mb-0">회원 정보</h5>
                        <button class="btn btn-danger" onclick="viewDeleteModal()">회원 탈퇴</button>
                    </div>
                    <hr>
                </div>
                <ul class="user-info-box align-self-center">
                    <li class="d-flex mb-3">
                        <span class="align-content-center col-2 pe-3">이메일</span>
                        <div class="form-floating col-8 flex-grow-1">
                            <span id="email-input"></span>
                        </div>
                    </li>
                    <li class="d-flex mb-3">
                        <span class="align-content-center col-2 pe-3">비밀번호</span>
                        <div class="form-floating col-8 flex-grow-1">
                            <input type="password" class="form-control" id="pw-input" placeholder="Password">
                            <label for="pw-input">Password</label>
                        </div>
                    </li>
                    <li class="d-flex mb-1">
                        <span class="align-content-center col-2 pe-3">주소</span>
                        <div class="form-floating col-8 flex-grow-1">
                            <input type="text" class="form-control" id="address-input" placeholder="충청북도 청주시 청원구 오창읍 000-0">
                            <label for="address-input">Address</label>
                        </div>
                    </li>
                    <li class="d-flex mb-5">
                        <span class="align-content-center col-2 pe-3">우편 번호</span>
                        <div class="form-floating col-8 flex-grow-1">
                            <input type="text" class="form-control" id="zipcode-input" placeholder="00000" maxlength="5">
                            <label for="zipcode-input">Zip Code</label>
                        </div>
                    </li>
                    <li class="d-flex align-content-center">
                        <button class="btn btn-primary mx-auto" onclick="updateCustomerInfo()">회원 정보 수정</button>
                    </li>
                </ul>
            </div>
        </div>
    </main>

</div>
</body>

</html>