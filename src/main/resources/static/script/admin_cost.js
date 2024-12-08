// shop.jsp 상품 목록 호출

const insert = document.getElementById('table-insert-box');

window.onload = function () {
    loginCheck()
    callData();
}

function loginCheck() {
    let btnBox = document.getElementById('auth-check');
    fetch('/api/admin/login/status')
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
    fetch('/api/admin/logout')
    .then(resp => resp.json())
    .then(res => {
        if(res.success) {
            window.location.reload();
        } else {
            alert('알 수 없는 에러가 발생했습니다.');
        }
    })
}

function callData() {
    fetch('/api/admin/dashboard')
        .then(resp => resp.json())
        .then(res => {
            if(res.success) {
                customer.innerHTML = formatNumber(res.totalCustomer) + '명';
                purchase.innerHTML = formatNumber(res.todaySales) + '원';
                product.innerHTML = formatNumber(res.totalProduct) + '개';
                console.log(res);

                let result = '';
                for (let i = res.purchase.length - 1; i >= 0; i--) {
                    let row = res.purchase[i];
                    result += `<div class="d-flex p-2 border-top dash-info-item">
                                <div class="col-3 text-center">
                                    ${row.date}
                                </div>
                                <div class="col-3 text-center">
                                    ${formatNumber(row.sold)+'개'}
                                </div>
                                <div class="col-3 text-center">
                                    ${formatNumber(row.sales)+'원'}
                                </div>`
                    if(row.increase > 0) {
                        result += `<div class="col-3 text-center text-primary">
                            ${'+'+formatNumber(row.increase.toFixed(2))+' %'}
                        </div>`
                    } else if (row.increase < 0){
                        result += `<div class="col-3 text-center text-danger">
                            ${formatNumber(row.increase.toFixed(2))+' %'}
                        </div>`
                    } else {
                        result += `<div class="col-3 text-center text-dark">
                            ${formatNumber(row.increase.toFixed(2))+' %'}
                        </div>`
                    }
                    result += `</div>`
                }
                insert.innerHTML = result;
            }
        })
        .catch(e => console.log(e));
}

function formatNumber(num) {
    return num.toLocaleString();
}
