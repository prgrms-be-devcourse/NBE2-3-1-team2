<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- style.css -->
    <link rel="stylesheet" href="./css/style.css">
    <!-- bootstrap.css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="./script/shop.js" async></script>
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
            <a href="/cart.view" class="cart quick-link">
                <img class="mx-auto" src="./images/cart.png" width="28" height="28">
                <span class="cart-title">장바구니</span>
                <em class="cart-count" id="cart-counter">0</em>
            </a>
            <div class="login-btn-div">
                <a class="btn btn-outline-dark login-btn" href="/login.do">로그인</a>
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
                <ul class="list-group products" id="products-list">
                    <!-- format -->
<%--                    <li class="list-group-item d-flex align-items-center">--%>
<%--                        <div>--%>
<%--                            <img class="product-img" src="./images/coffee_bean_01.jpg">--%>
<%--                        </div>--%>
<%--                        <div class="col">--%>
<%--                            <div class="text-muted">커피콩</div>--%>
<%--                            <div>Columbia Nariñó</div>--%>
<%--                        </div>--%>
<%--                        <div class="px-3 text-center">5,000원</div>--%>
<%--                        <div class="px-3 num-input-div">--%>
<%--                            <input type="text" class="num-input" value="1">--%>
<%--                            <div class="num-btn">--%>
<%--                                <button class="inc" onclick="updateValue(this,1)"></button> <!-- Up Arrow -->--%>
<%--                                <button class="dec" onclick="updateValue(this,-1)"></button> <!-- Down Arrow -->--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="text-end">--%>
<%--                            <button class="btn btn-outline-dark" onclick="createToastMsg(1)">담기</button>--%>
<%--                        </div>--%>
<%--                    </li>--%>
                </ul>
            </div>
        </div>
    </main>
    <div id="toast-container">
    </div>
</div>
</body>
</html>