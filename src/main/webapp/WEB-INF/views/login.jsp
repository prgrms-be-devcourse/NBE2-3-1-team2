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
    <script src="./script/login.js" async></script>
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
        <form id="formLogin">
            <div class="w-100">
                <h5>로그인</h5>
                <hr>
            </div>

            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="id-input" placeholder="name@example.com">
                <label for="id-input">Email</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="pw-input" placeholder="Password">
                <label for="pw-input">Password</label>
            </div>

<%--            <div class="form-check text-start my-3">--%>
<%--                <input class="form-check-input" type="checkbox" value="remember-me" id="rem-chk">--%>
<%--                <label class="form-check-label" for="rem-chk">--%>
<%--                    이메일 기억하기--%>
<%--                </label>--%>
<%--            </div>--%>
            <div class="d-flex flex-column mt-3">
                <button class="btn btn-outline-dark w-50 mx-auto py-2" type="submit">로그인</button>
                <div class="text-center mt-4">
                    <a href="/join.do" class="reg-link">회원가입</a>
                </div>
            </div>
        </form>
    </main>

</div>
</body>

</html>