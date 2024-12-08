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
    <script src="./script/login_admin.js" async></script>
    <title>Grids & Circle</title>
</head>

<body>
<div class="container-fluid my-4">
    <header class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <a href="/management.view">
                <img class="brand-logo" src="./images/brand_logo.png">
            </a>
        </div>
        <div class="d-flex">
            <a href="/management.customer" class="purchase quick-link">
                <img class="mx-auto" src="./images/user.png" width="28" height="28">
                <span class="cart-title">고객관리</span>
            </a>
            <a href="/management.product" class="cart quick-link">
                <img class="mx-auto" src="./images/product.png" width="28" height="28">
                <span class="cart-title">상품관리</span>
            </a>
            <a href="/management.cost" class="cart quick-link">
                <img class="mx-auto" src="./images/cost.png" width="28" height="28">
                <span class="cart-title">매출현황</span>
            </a>
            <div class="login-btn-div" id="auth-check">
                <a class="btn btn-outline-dark login-btn" href="/management.login">로그인</a>
            </div>
        </div>
    </header>
    <hr>
    <main class="card form-login p-5 mt-5">
        <form id="formLogin">
            <div class="w-100">
                <h5>관리자 로그인</h5>
                <hr>
            </div>

            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="email-input" placeholder="name@example.com">
                <label for="email-input">Email</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="pw-input" placeholder="Password">
                <label for="pw-input">Password</label>
            </div>
            <div class="d-flex flex-column mt-3">
                <button class="btn btn-outline-dark w-50 mx-auto py-2" type="submit">로그인</button>
            </div>
        </form>
    </main>
</div>
</body>
</html>