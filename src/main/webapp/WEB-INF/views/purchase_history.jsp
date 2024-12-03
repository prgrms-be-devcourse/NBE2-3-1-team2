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
    <main class="card cart-card">
        <div class="row">
            <div class="col-md d-flex flex-column align-items-start py-3 px-4">
                <div class="w-100">
                    <h5>주문내역</h5>
                    <hr>
                </div>
                <ul class="purchase-group">
                    <li class="purchase-group-item">
                        <div class="ms-1 mb-1 d-flex justify-content-between">
                            <span>주문번호 : 00001 ( 2024.12.02 01:00:00 )</span>
                            <span class="me-3">배송 전</span>
                        </div>
                        <div class="d-flex purchase-list-container">
                            <ul class="col list-group">
                                <li class="list-group-item d-flex align-items-center">
                                    <div>
                                        <img class="product-img" src="./images/coffee_bean_01.png">
                                    </div>
                                    <div class="col">
                                        <div class="text-muted">커피콩</div>
                                        <div>Columbia Nariñó</div>
                                    </div>
                                    <div class="px-3">5개</div>
                                    <div class="px-3 text-center">25,000원</div>
                                </li>
                                <li class="list-group-item d-flex align-items-center">
                                    <div>
                                        <img class="product-img" src="./images/coffee_bean_01.png">
                                    </div>
                                    <div class="col">
                                        <div class="text-muted">커피콩</div>
                                        <div>Columbia Nariñó</div>
                                    </div>
                                    <div class="px-3">5개</div>
                                    <div class="px-3 text-center">25,000원</div>
                                </li>
                            </ul>
                            <div class="px-3 my-auto">
                                <div class="my-4 d-flex justify-content-between">
                                    <span class="pe-4">총 금액</span>
                                    <span class="ps-4">50,000원</span>
                                </div>
                                <button class="w-100 btn btn-dark">환불하기</button>
                            </div>
                        </div>
                        <hr>
                    </li>
                    <li class="purchase-group-item">
                        <div class="ms-1 mb-1 d-flex justify-content-between">
                            <span>주문번호 : 00002 ( 2024.12.02 03:30:00 )</span>
                            <span class="me-3">배송 전</span>
                        </div>
                        <div class="d-flex purchase-list-container">
                            <ul class="col list-group">
                                <li class="list-group-item d-flex align-items-center">
                                    <div>
                                        <img class="product-img" src="./images/coffee_bean_01.png">
                                    </div>
                                    <div class="col">
                                        <div class="text-muted">커피콩</div>
                                        <div>Columbia Nariñó</div>
                                    </div>
                                    <div class="px-3">5개</div>
                                    <div class="px-3 text-center">25,000원</div>
                                </li>
                                <li class="list-group-item d-flex align-items-center">
                                    <div>
                                        <img class="product-img" src="./images/coffee_bean_01.png">
                                    </div>
                                    <div class="col">
                                        <div class="text-muted">커피콩</div>
                                        <div>Columbia Nariñó</div>
                                    </div>
                                    <div class="px-3">5개</div>
                                    <div class="px-3 text-center">25,000원</div>
                                </li>
                                <li class="list-group-item d-flex align-items-center">
                                    <div>
                                        <img class="product-img" src="./images/coffee_bean_01.png">
                                    </div>
                                    <div class="col">
                                        <div class="text-muted">커피콩</div>
                                        <div>Columbia Nariñó</div>
                                    </div>
                                    <div class="px-3">5개</div>
                                    <div class="px-3 text-center">25,000원</div>
                                </li>
                            </ul>
                            <div class="px-3 my-auto">
                                <div class="my-4 d-flex justify-content-between">
                                    <span class="pe-4">총 금액</span>
                                    <span class="ps-4">75,000원</span>
                                </div>
                                <button class="w-100 btn btn-dark">환불하기</button>
                            </div>
                        </div>
                        <hr>
                    </li>
                </ul>
            </div>
        </div>
    </main>
</div>
</body>

</html>