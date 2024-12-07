// shop.jsp 상품 목록 호출
let cart = JSON.parse(localStorage.getItem("cart")) || [];
const count = document.getElementById('cart-counter');

window.onload = function () {
    loginCheck();
    callUserData();
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

function callUserData() {
    fetch('/api/customer/info')
        .then(resp => resp.json())
        .then(res => {
            if(res.success) {
                document.getElementById('email-input').innerHTML = res.data.email;
                document.getElementById('address-input').value = res.data.addr;
                document.getElementById('zipcode-input').value = res.data.zip;
            }
        })
        .catch(err => console.log(err));
}

function viewDeleteModal() {
    const modal = document.getElementById('modal-box');

    modal.innerHTML = `<div class="d-flex" id="modal-password" onclick="closeModal()">
            <div class="card form-login p-4 align-self-center" id="modal-bubble">
                <div class="w-100">
                    <div class="d-flex justify-content-between">
                        <h5 class="align-self-center mb-0">비밀번호 확인</h5>
                        <button class="btn btn-outline-danger" onclick="closeModal()">X</button>
                    </div>
                    <hr>
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control" id="resign-input" placeholder="Password">
                    <label for="resign-input">Password</label>
                </div>
                <div class="d-flex flex-column mt-3">
                    <button class="btn btn-danger mx-auto py-2" onclick="resignUser()">회원 탈퇴</button>
                </div>
            </div>
        </div>`;
    document.getElementById('modal-bubble').addEventListener('click', function (e) {
        e.stopPropagation();
    })
}

function closeModal() {
    const modal = document.getElementById('modal-password');
    modal.remove();
}

function resignUser() {
    const pwInput = document.getElementById('resign-input');

    fetch('/api/customer/resign', {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            'pwd':pwInput.value
        }),
    })
        .then(resp => resp.json())
        .then(res => {
            if (res.success) {
                alert("회원 탈퇴가 정상적으로 진행되었습니다.");
                setLogout();
            } else {
                alert(res.message);
                window.location.reload();
            }
        })
        .catch(err => console.log(err));
}

function updateCustomerInfo() {
    const pwInput = document.getElementById('pw-input');
    const addrInput = document.getElementById('address-input');
    const zipcodeInput = document.getElementById('zipcode-input');

    fetch('/api/customer/update', {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            'pwd':pwInput.value,
            'addr':addrInput.value,
            'zip':zipcodeInput.value
        }),
    })
        .then(resp => resp.json())
        .then(res => {
            if (res.success) {
                alert("회원 정보가 정상적으로 수정되었습니다.");
                window.location.reload()
            } else {
                alert(res.message);
            }
        })
        .catch(err => console.log(err));
}