// shop.jsp 상품 목록 호출
let cart = JSON.parse(localStorage.getItem("cart")) || [];
const count = document.getElementById('cart-counter');

window.onload = function () {
    loginCheck()
    callOrder();
    count.innerHTML = cart.length.toString();
}

function loginCheck() {
    let btnBox = document.getElementById('auth-check');
    fetch('/api/customer/login/status')
        .then(resp => resp.json())
        .then(res => {
            if(res.success) {
                btnBox.innerHTML = `<a class="btn btn-outline-dark login-btn" href="#" onclick="setLogout()">로그아웃</a>`;
            } else {
                btnBox.innerHTML = `<a class="btn btn-outline-dark login-btn" href="/login.do">로그인</a>`;
            }
        })
        .catch(e => console.error('[에러] : ',e));
}

function setLogout() {
    fetch('/api/customer/logout')
    .then(resp => resp.json())
    .then(res => {
        if(res.success) {
            window.location.href = '/main.do';
        } else {
            alert('알 수 없는 에러가 발생했습니다.');
        }
    })
}

function callOrder() {
    fetch('/api/order/history')
        .then(resp => resp.json())
        .then(res => {
            if(res.success) {
                const box = document.getElementById('purchase-list-box');
                let result = '';
                for(let i=0; i<res.purchase.length; i++) {
                    let item = res.purchase[i];
                    result += `<li class="purchase-group-item">
                        <div class="ms-1 mb-1 d-flex justify-content-between">
                            <span>주문번호 : ${String(item.pid).padStart(5,'0')} ( 주문 시각 : ${formatDate(item.ot)} )</span>
                            <span class="me-3">${item.st}</span>
                        </div>
                        <div class="d-flex purchase-list-container">
                            <ul class="col list-group">`;
                        let totalPrice = 0;
                        for(let j=0; j<res.lists[i].length; j++) {
                            let row = res.lists[i][j];
                            result += `<li class="list-group-item d-flex align-items-center">
                                    <div>
                                        <img class="product-img" src="./images/${row.img}">
                                    </div>
                                    <div class="col">
                                        <div class="text-muted">${row.cat}</div>
                                        <div>${row.name}</div>
                                    </div>
                                    <div class="px-3">${row.qty}개</div>
                                    <div class="px-3 text-center">${formatPrice(row.qty * row.price)}</div>
                                </li>`
                            totalPrice += row.qty * row.price;
                        }

                    result += `</ul>
                            <div class="px-3 my-auto">
                                <div class="my-4 d-flex justify-content-between">
                                    <span class="pe-4">총 금액</span>
                                    <span class="ps-4">${formatPrice(totalPrice)}</span>
                                </div>
                                <button class="w-100 btn btn-dark" onclick="">환불하기</button>
                            </div>
                        </div>
                        <hr>
                    </li>`
                }
                box.innerHTML = result;
            }
        })
}

function refunds(btn) {
    fetch('/api/customer/refunds/status', {
        method: "PUT",
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(cart)
    })
}

function formatPrice(price) {
    return price.toLocaleString() + '원';
}

function formatDate(time) {
    const date = new Date(time);

    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}