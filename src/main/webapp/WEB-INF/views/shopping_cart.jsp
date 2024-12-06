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
    <script src="./script/cart.js" async></script>
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
            <div class="login-btn-div" id="auth-check">
            </div>
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
                    <ul class="list-group products col" id="cart-list">
                        <!-- cart - list -->
                    </ul>
                    <div class="mx-3 purchase-form">
                        <hr>
                        <div class="d-flex justify-content-between mt-2">
                            <span>총 금액</span>
                            <span id="all-product-price"></span>
                        </div>
                        <hr>
                        <form id="order-form">
                            <div class="form-floating mb-2">
                                <input type="email" class="form-control" id="email-input" placeholder="name@example.com" readonly>
                                <label for="email-input">Email@Example.com</label>
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
</body>
</html>