// shop.jsp 상품 목록 호출
let cart = JSON.parse(localStorage.getItem("cart")) || [];
const count = document.getElementById('cart-counter');
const allPrice = document.getElementById('all-product-price');
const cartList = document.getElementById('cart-list');

const priceArr = [];

window.onload = function () {
    loginCheck();
    callCart();
    loadCustomerData()
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

function callCart() {
    fetch('/api/product/cart/list', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(cart)
    })
        .then(response => response.json())
        .then(data => {
            let result = '';
            if(data.length > 0) {
                for (let i = 0; i < data.length; i++) {
                    let row = data[i];
                    priceArr.push({"pid":row.pid, "price": row.price});
                    let index = cart.findIndex(item => item.pid === row.pid);

                    result += `<li class="list-group-item d-flex align-items-center position-relative">
                            <div>
                                <img class="product-img" src="./images/${row.img}">
                            </div>
                            <div class="col">
                                <div class="text-muted">${row.cat}</div>
                                <div>${row.name}</div>
                            </div>
                            <div class="px-3 text-center price-total">${formatPrice(priceQtyMul(row.price, cart[index].qty))}</div>
                            <div class="px-3 num-input-div">
                                <input type="text" class="num-input" data-i="${row.pid}" data-k="${row.stk}" data-p="${row.price}" value="${cart[index].qty}">
                                <div class="num-btn">
                                    <button class="inc" onclick="updateCart(this,1, '${row.pid}','${row.price}','${row.stk}')"></button> <!-- Up Arrow -->
                                    <button class="dec" onclick="updateCart(this,-1, ${row.pid},'${row.price}','${row.stk}')"></button> <!-- Down Arrow -->
                                </div>
                            </div>
                            <a class="delete-btn" href="#" onclick="deleteToCart('${row.pid}',this)">X</a>
                        </li>`;
                }
                // data-i="${index}" data-k="${row.stk}" data-p="${row.price}" 구조 변경 필요 보안에 취약.
                // 그래도 일단은 주문을 할때는 사용자 정보와 로컬스토리지의 정보를 가지고 진행된다.
                // 근데 이것도 수정해버리면? 다른 방식도 생각해봐야 한다. 추후에 테이블 생성은 필요할 것 같다.(시간이 남는다면)
                // 우선은 로컬스토리지를 이용해서 진행하는 것을 우선으로 생각하자.
            } else {
                result += `<li class="list-group-item align-items-center text-center my-auto">상품을 담아주세요!</li>`;
            }
            cartList.innerHTML = result;
            reducePrice();

            document.querySelectorAll(".num-input").forEach(input => {
                input.addEventListener("input", function () {
                    this.value = this.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자 제거
                });
                input.addEventListener("blur", function () {
                    const totalDiv = this.closest('.list-group-item').querySelector('.price-total');
                    const pid = parseInt(this.getAttribute("data-i"), 10);
                    const stk = parseInt(this.getAttribute("data-k"), 10);
                    const price = parseInt(this.getAttribute("data-p"), 10);
                    if (this.value === '' || this.value === null || this.value === undefined) this.value = 1;
                    if (this.value > stk) this.value = stk;
                    totalDiv.innerHTML = formatPrice(priceQtyMul(price, this.value));
                    console.log(this.value);
                    updateStorage(pid, this.value);
                });
            });
        }).catch(e => {
        console.log('/product/cart/list 요청 실패 : ',e);
    });
}

function loadCustomerData() {
    fetch('/api/customer/cart/info')
        .then(resp => resp.json())
        .then(res => {
            if(res.success) {
                document.getElementById('id-input').value = res.customer.email;
                document.getElementById('address-input').value = res.customer.addr;
                document.getElementById('zipcode-input').value = res.customer.zip;
            } else {
                console.log(res);
                // window.location.href = '/login.do';
            }
        })
}


function deleteToCart(pid, button) {
    const itemBox = button.closest('.list-group-item');

    const cartIndex = cart.findIndex(item => item.pid === pid);

    if (cartIndex !== -1) {
        cart.splice(cartIndex, 1);
    }

    itemBox.remove();
    localStorage.setItem("cart", JSON.stringify(cart));
    if (cart.length < 1) {
        cartList.innerHTML = `<li class="list-group-item align-items-center text-center my-auto">상품을 담아주세요!</li>`;;
    }
    reducePrice();
    count.innerHTML = cart.length.toString();
}

function updateCart(button, change, pid, price, stk) {
    const numInput = button.closest('.num-input-div').querySelector('.num-input');
    const totalDiv = button.closest('.list-group-item').querySelector('.price-total');
    let qty = parseInt(numInput.value, 10) || 0; // 값이 없으면 0으로 초기화
    qty += change;
    if (qty < 1) qty = 1; // 최소값 제한
    if (qty > stk) qty = stk;

    updateStorage(pid, qty);
    numInput.value = qty;
    totalDiv.innerHTML = formatPrice(priceQtyMul(price, qty));
}

function updateStorage(pid, qty) {
    if (qty === '' || qty === null || qty === undefined) qty = 1;

    let data = cart.find(item => item.pid === pid);

    if (data) {
        data.qty = parseInt(qty,10);
    }

    localStorage.setItem("cart", JSON.stringify(cart));
    reducePrice();
}

function formatPrice(price) {
    return price.toLocaleString() + '원';
}
function priceQtyMul(price, qty){
    return  parseInt(price, 10) * parseInt(qty, 10);
}

function reducePrice() {
    const priceMap = new Map(priceArr.map((item) => [item.pid, item.price]));

    let total = cart.reduce((total, item) => {
        const price = priceMap.get(item.pid);
        if (price !== undefined && price !== null) {
            return total + priceQtyMul(price, item.qty);
        }
        return total;
    }, 0);

    allPrice.innerHTML = formatPrice(total);
}