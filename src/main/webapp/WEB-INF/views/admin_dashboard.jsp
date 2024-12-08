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
    <script src="./script/admin_dashboard.js" async></script>
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
                    <h5 class="mx-3">대시보드</h5>
                    <hr>
                </div>
                <div class="p-4 d-flex w-100  flex-column">
                    <div class="d-flex justify-content-center">
                        <div class="col m-4 p-3 text-center dash-info-box align-content-center">
                            <h6>총 회원 수</h6>
                            <span id="total-customer">1234</span>
                        </div>
                        <div class="col m-4 p-3 text-center dash-info-box align-content-center">
                            <h6>일일 매출</h6>
                            <span id="daily-purchase">1234</span>
                        </div>
                        <div class="col m-4 p-3 text-center dash-info-box align-content-center">
                            <h6>판매 상품 수량</h6>
                            <span id="pending-product">1234</span>
                        </div>
                    </div>
                    <hr>
                    <div class="d-flex flex-column table-box">
                        <div class="d-flex p-2 dash-info-header">
                            <div class="col-3 text-center">
                                날짜
                            </div>
                            <div class="col-3 text-center">
                                일일 판매 수량
                            </div>
                            <div class="col-3 text-center">
                                일일 판매 금액
                            </div>
                            <div class="col-3 text-center">
                                전일 대비 매출 상승량
                            </div>
                        </div>
                        <div id="table-insert-box">
                            <div class="d-flex p-2 border-top dash-info-item">
                                <div class="col-3 text-center">
                                    2024-12-07
                                </div>
                                <div class="col-3 text-center">
                                    100
                                </div>
                                <div class="col-3 text-center">
                                    1,000,000원
                                </div>
                                <div class="col-3 text-center">
                                    56%
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>