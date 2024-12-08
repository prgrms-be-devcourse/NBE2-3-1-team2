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
    <script src="./script/admin_cost.js" async></script>
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
                    <!-- product - list -->
                </ul>
            </div>
        </div>
    </main>
</div>
</body>
</html>