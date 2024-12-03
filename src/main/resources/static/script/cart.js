// shop.jsp 상품 목록 호출
let cart = JSON.parse(localStorage.getItem("cart")) || [];
const count = document.getElementById('cart-counter');
callCart();
count.innerHTML = cart.length.toString();


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
            let cartList = document.getElementById('cart-list');
            let result = '';
            if(data.length > 0) {
                for (let i = 0; i < data.length; i++) {
                    let row = data[i];
                    let index = cart.findIndex(item => item.pid === row.pid);
                    result += `<li class="list-group-item d-flex align-items-center position-relative">
                            <div>
                                <img class="product-img" src="./images/${row.img}">
                            </div>
                            <div class="col">
                                <div class="text-muted">${row.cat}</div>
                                <div>${row.name}</div>
                            </div>
                            <div class="px-3 text-center">${formatPrice(parseInt(row.price),10)}</div>
                            <div class="px-3 num-input-div">
                                <input type="text" class="num-input" data-i="${index}" value="${cart[index].qty}">
                                <div class="num-btn">
                                    <button class="inc" onclick="updateCart(this,1, ${index})"></button> <!-- Up Arrow -->
                                    <button class="dec" onclick="updateCart(this,-1, ${index})"></button> <!-- Down Arrow -->
                                </div>
                            </div>
                            <a class="delete-btn" href="#" onclick="deleteToCart('${row.pid}',this)">X</a>
                        </li>`;
                }
            } else {
                result += `<li class="list-group-item align-items-center text-center my-auto">상품을 담아주세요!</li>`;
            }

            cartList.innerHTML = result;
            document.querySelectorAll(".num-input").forEach(input => {
                input.addEventListener("input", function () {
                    this.value = this.value.replace(/[^0-9]/g, ''); // 숫자가 아닌 문자 제거
                });
                input.addEventListener("blur", function () {
                    const index = parseInt(this.getAttribute("data-i"), 10);
                    if (this.value === '' || this.value === null || this.value === undefined) this.value = 1;
                    updateStorage(index, this.value);
                });
            });
        }).catch(e => {
        console.log('/product/cart/list 요청 실패 : ',e);
    });
}



function deleteToCart(pid, button) {
    const itemBtn = button.closest('.list-group-item');

    const cartIndex = cart.findIndex(item => item.pid === pid);

    if (cartIndex !== -1) {
        cart.splice(cartIndex, 1);
    }

    itemBtn.remove();
    localStorage.setItem("cart", JSON.stringify(cart));
    count.innerHTML = cart.length.toString();
}

function updateCart(button, change, index) {
    const arrowBtn = button.closest('.num-input-div').querySelector('.num-input');
    let qty = parseInt(arrowBtn.value, 10) || 0; // 값이 없으면 0으로 초기화
    qty += change;
    if (qty < 1) qty = 1; // 최소값 제한

    updateStorage(index, qty);

    arrowBtn.value = qty;
}

function updateStorage(index, qty) {
    if (qty === '' || qty === null || qty === undefined) qty = 1;

    if (index !== -1) {
        cart[index].qty = qty;
    }

    localStorage.setItem("cart", JSON.stringify(cart));
}

function formatPrice(price) {
    return price.toLocaleString() + '원';
}