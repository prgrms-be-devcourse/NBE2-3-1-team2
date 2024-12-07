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
    <script src="./script/order.js" async></script>
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
            <div class="col-md d-flex flex-column align-items-start py-3 px-4">
                <div class="w-100">
                    <div class="d-flex">
                        <h5 class="col mb-0 align-self-center">주문내역</h5>
                        <div class="date-box">
                            <span class="date-label mx-1 date-box-label">조회 기간</span>
                            <div class="d-inline">
                                <label>
                                    <input type="date" class="date-picker" id="start-date">
                                </label>
                                <span class="date-label mx-1">~</span>
                                <label>
                                    <input type="date" class="date-picker me-1" id="end-date">
                                </label>
                                <label>
                                    <button class="btn btn-primary date-btn" onclick="getDateHistory()">조회</button>
                                </label>
                            </div>
                        </div>
                    </div>
                    <hr>
                </div>
                <ul class="purchase-group" id="purchase-list-box">

                </ul>
            </div>
        </div>
    </main>

</div>
</body>

</html>