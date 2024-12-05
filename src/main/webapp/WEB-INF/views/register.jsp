<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- style.css -->
    <link rel="stylesheet" href="./css/style.css">
    <!-- bootstrap.css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="./script/register.js" async></script>
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
    <main class="card form-login p-5 mt-5">
        <form id="formJoin">
            <div class="w-100">
                <h5>회원가입</h5>
                <hr>
            </div>

            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="id-input" placeholder="name@example.com">
                <label for="id-input">Email@Example.com</label>
            </div>
            <div class="form-floating mb-1">
                <input type="password" class="form-control" id="pw-input" placeholder="Password">
                <label for="pw-input">Password</label>
            </div>
            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="pwchk-input" placeholder="Password Check">
                <label for="pwchk-input">Password Check</label>
            </div>

            <div class="form-floating mb-1">
                <input type="text" class="form-control" id="address-input" placeholder="충청북도 청주시 청원구 오창읍 000-0">
                <label for="address-input">Address</label>
            </div>

            <div class="form-floating mb-5">
                <input type="text" class="form-control" id="zipcode-input" placeholder="00000" maxlength="5">
                <label for="zipcode-input">Zip Code</label>
            </div>


            <div class="d-flex flex-column">
                <button class="btn btn-outline-dark w-50 mx-auto py-2" type="submit">회원가입</button>
            </div>
        </form>
    </main>

</div>
</body>

</html>