// shop.jsp 상품 목록 호출
let cart = JSON.parse(localStorage.getItem("cart")) || [];
const count = document.getElementById('cart-counter');

window.onload = function () {
    loginCheck()
    callList();
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

}


function formatPrice(price) {
    return price.toLocaleString() + '원';
}
