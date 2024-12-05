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
            window.location.reload();
        } else {
            alert('알 수 없는 에러가 발생했습니다.');
        }
    })
}

function callList() {
    fetch('/api/product/list')
        .then(response => response.json())
        .then(data => {
            let productList = document.getElementById('products-list');
            let result = '';
            for (let i = 0; i < data.length; i++) {
                let row = data[i];
                result += `<li class="list-group-item d-flex align-items-center">
                    <div>
                        <img class="product-img" src="./images/${row.img}">
                    </div>
                    <div class="col">
                        <div class="text-muted">${row.cat}</div>
                        <div>${row.name}</div>
                    </div>
                    <div class="px-3 text-center">${formatPrice(parseInt(row.price),10)}</div>
                    <div class="px-3 num-input-div">
                        <input type="text" class="num-input" value="1">
                        <div class="num-btn">
                            <button class="inc" onclick="updateValue(this,1)"></button> <!-- Up Arrow -->
                            <button class="dec" onclick="updateValue(this,-1)"></button> <!-- Down Arrow -->
                        </div>
                    </div>
                    <div class="text-end">
                        <button class="btn btn-outline-dark" onclick="addToCart('${row.name}', '${row.pid}', this)">담기</button>
                    </div>
                </li>`;
            }
            productList.innerHTML = result;
            document.querySelectorAll(".num-input").forEach(input => {
                input.addEventListener("input", function () {
                    this.value = this.value.replace(/[^0-9]/g, ""); // 숫자가 아닌 문자 제거
                });
                input.addEventListener("blur", function () {
                    if (this.value === '' || this.value === null || this.value === undefined) this.value = 1;
                });
            });
        }).catch(e => {
            console.log('GET 요청 실패 : ',e);
        });
}

function addToCart(name, pid, button) {
    const numInput = button.closest('.list-group-item').querySelector('.num-input-div').querySelector('.num-input');
    if (numInput.value === null || numInput.value === undefined || numInput.value === '') {
        alert('상품 개수를 입력하시기 바랍니다.');
        numInput.value = 1;
        return false;
    }
    const qty = parseInt(numInput.value, 10);

    const cartIndex = cart.findIndex(item => item.pid === pid);

    if (cartIndex !== -1) {
        cart[cartIndex].qty += qty;
    } else {
        let tmp = {
            "pid" : pid,
            "qty" : qty,
        };
        cart.push(tmp);
    }


    count.innerHTML = cart.length.toString();

    localStorage.setItem("cart", JSON.stringify(cart));
    createToastMsg(name);
}

function createToastMsg(msg) {
    const toast = document.createElement("div");
    toast.classList.add("toast-msg");
    toast.classList.add("hide");
    toast.textContent = msg + ' 상품을 장바구니에 담았습니다.';

    // 토스트 컨테이너에 추가
    const toastContainer = document.getElementById("toast-container");
    toastContainer.appendChild(toast);
    setTimeout(() => toast.classList.remove("hide"), 500);

    // 3초 후에 메시지를 사라지게 하고 DOM에서 제거
    setTimeout(() => {
        toast.classList.add("hide");
        setTimeout(() => toast.remove(), 500); // 애니메이션이 끝난 후 제거
    }, 2000);
}

function updateValue(button, change) {
    const numInput = button.closest('.num-input-div').querySelector('.num-input');
    let qty = parseInt(numInput.value, 10) || 0; // 값이 없으면 0으로 초기화
    qty += change;
    if (qty < 1) qty = 1; // 최소값 제한
    numInput.value = qty;
}

function formatPrice(price) {
    return price.toLocaleString() + '원';
}
