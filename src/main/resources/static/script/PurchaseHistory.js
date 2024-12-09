// API로부터 OrderHistory와 Product 를 받아 리턴하는 함수
function getOrderHistoryData() {
    return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    resolve(JSON.parse(xhr.responseText.trim()));
                } else {
                    reject(xhr.status);
                }
            }
        }
        xhr.open('GET', `api/orderList${encodeURIComponent(startDate)}${endDate}`, true);
        xhr.send();
    });
}
function getProductData() {
    return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    resolve(JSON.parse(xhr.responseText.trim()));
                } else {
                    reject(xhr.status);
                }
            }
        }
        xhr.open('GET', `api/product`, true);
        xhr.send();
    });
}

// 주문 내역 페이지 로드
function pageLoad() {
    document.getElementById("list-space").innerHTML = ``;

    let result = ``;
    let totalPrice = 0;

    for ( let i = 0 ; i < orderHistory.length ; i++ ) {
        let order = orderHistory[i];

        // 주문 내역 정보
        let productID = order.prd_id
        let img = product[productID-1].img
        let cat = product[productID-1].cat
        let name = product[productID-1].name
        let orderNumber = order.pid
        let purchaseDate = order.ot.split('T')[0] + ' ' + order.ot.split('T')[1]
        let qty = order.qty
        let sst = order.sst
        let st = order.st
        let price = order.price.toLocaleString()
        let shippingTime = new Date(sst);
        shippingTime.setHours(14, 0, 0, 0);
        let shippingYear = shippingTime.getFullYear();
        let shippingMonth = shippingTime.getMonth() + 1;
        let shippingDay = shippingTime.getDate();
        if ( diffShippingDate[i] === 1 || diffShippingDate[i] === 3 ) {
            result += `<div class="border border-secondary rounded-3 p-3 mb-2">`;
            if ( st === 1 ) {
                if ( shippingTime - Date.now() > 0 ) {
                    result += `<span className="d-flex flex-row-reverse me-3" style="font: italic 1.2rem 'D2Coding', serif;">배송 준비 중 - ${shippingYear}년 ${shippingMonth}월 ${shippingDay}일 14시 출발 예정</span>`;
                } else {
                    result += `<span className="d-flex flex-row-reverse me-3" style="font: italic 1.2rem 'D2Coding', serif;">배송 완료</span>`;
                }
            } else {
                result += `<span className="d-flex flex-row-reverse me-3" style="font: italic 1.2rem 'D2Coding', serif;">환불</span>`;

            }
        }

        if ( diffOrderDate[i] === 1 || diffOrderDate[i] === 3 ) {
            result += `<li class="purchase-group-item">
								<div class="ms-1 mb-1 d-flex justify-content-between">
									<span>주문번호 : ${orderNumber} ( ${purchaseDate} )</span>
								</div>
								<div class="d-flex purchase-list-container">
									<ul class="col list-group">`;
        }

        // 총 금액 계산
        totalPrice += order.price;

        // 주문 내역 리스트 추가
        result += `<li class="list-group-item d-flex align-items-center"  data-prdid=${productID} data-pid=${orderNumber}>
											<div>
												<i class="bi bi-arrow-down-left-circle-fill"></i>
												<img class="product-img" src="./images/${img}">
											</div>
											<div class="col">
												<div class="text-muted">${cat}</div>
												<div>${name}</div>
											</div>
											<div class="px-3">${qty}개</div>
											<div class="px-3 text-center">${price}원</div>
							`;
        if ( judPaging ) {
            result += `<div class="d-flex chk-refund-space" style="padding-left: 20px">
								<input type="checkbox" id="chk-refund-${i}" class="chk-refund" data-prdid=${productID} data-pid=${orderNumber}>
								<label for="chk-refund" class="chk-refund-label"></label>
								<label for="chk-refund" class="chk-refund-label">환불</label>
							</div>
						</li>`;
        }
        // 주문 일자가 다를경우 새로운 주문 그룹 생성
        if ( diffOrderDate[i] === 2 || diffOrderDate[i] === 3 ) {
            totalPrice = totalPrice.toLocaleString();
            if ( !judPaging ){
                result += `</li>
							</ul>
								<div class="px-3 my-auto">
									<div class="my-4 d-flex justify-content-between">
										<span class="pe-4">총 금액</span>
										<span class="ps-4">${totalPrice}원</span>
									</div>`;
                if ( st === 1 ) {
                    result +=`<button class="w-100 btn btn-dark" onclick="refundLoading(event)">환불하기</button>
										</div>`;
                } else {
                    result += `<button class="w-100 refunded-btn">환불완료</button>
										</div>`;
                }
            }
            result += `</div>
						</li>`;
            if ( diffShippingDate[i] !== 2 && diffShippingDate[i] !== 3 ) {
                result += `<hr>`;
            }
            totalPrice = 0;
        }

        if ( diffShippingDate[i] === 2 || diffShippingDate[i] === 3 ) {
            result += `</div>`;
            if ( judPaging ){
                if ( ( i % 10 ) === 9 ) {
                    result += `<button class="w-100 btn btn-dark" onclick="refundPaging(event)">환불하기</button>`
                } else { result += `<hr>`; }
            } else { result += `<hr>`; }
        }
    }
    document.getElementById("list-space").innerHTML = result;
}

// 조회 시작일 / 종료일 변경
function startOfDate() {
    let selectedEndDay = document.getElementById('end-date').value;

    let diffDay = 0;
    let today = new Date();
    today.setHours(9, 0, 0, 0)
    let date = new Date(this.value);
    if ( (today - date)/24/60/60/1000 < 0) {
        alert('오늘 이후로는 조회할 수 없습니다.');
        startDate = `/`;
        endDate = `/`;
        document.getElementById('start-date').value = '';
        return;
    }

    if ( selectedEndDay !== '' ) {
        diffDay = diffDate();
        if (diffDay < 0) {
            startDate = `/`;
            endDate = `/`;
            alert('조회 종료일은 조회 시작일보다 빠를 수 없습니다.');
            document.getElementById('start-date').setAttribute('data-placeholder', 'sawer');
        }
    }
}

function endOfDate() {
    let selectedStartDay = document.getElementById('start-date').value;

    let diffDay = 0;
    let today = new Date();
    today.setHours(9, 0, 0, 0)
    let date = new Date(this.value);
    if ( (today - date)/24/60/60/1000 < 0) {
        alert('오늘 이후로는 조회할 수 없습니다.');
        startDate = `/`;
        endDate = `/`;
        document.getElementById('end-date').value = '';
        return;
    }

    if ( selectedStartDay !== '' ) {
        diffDay = diffDate();
        if (diffDay < 0) {
            startDate = `/`;
            endDate = `/`;
            alert('조회 종료일은 조회 시작일보다 빠를 수 없습니다.');
            document.getElementById('end-date').value = '';
        }
    }
}

// 주문 날짜와 배송 날짜의 변동을 체크
function dateDiffList() {
    diffOrderDate = [1];
    diffShippingDate = [1];
    let tempOrderDate = '';
    let tempShippingDate = '';
    let tempRefundDate = orderHistory[0].st;
    let refundStart = [];
    let refundEnd = [];

    if ( tempRefundDate === -1 ) {
        refundStart.push(0);
    }

    for ( let i = 1 ; i < orderHistory.length ; i++ ) {
        if ( orderHistory[i].st !== tempRefundDate) {
            if ( orderHistory[i].st === -1 ) {
                refundStart.push(i);
            } else {
                refundEnd.push(i-1);
            }
            tempRefundDate = orderHistory[i].st;
        }
    }
    console.log(refundStart);
    console.log(refundEnd);
    if ( orderHistory.length === 0 ) {
        return -1;
    }
    tempOrderDate = orderHistory[0].ot;
    tempShippingDate = orderHistory[0].sst;
    for ( let i = 1 ; i < orderHistory.length-1 ; i++ ) {
        if ( tempOrderDate !== orderHistory[i].ot ) {
            diffOrderDate[i-1] += 2;
            diffOrderDate[i] = 1;
            tempOrderDate = orderHistory[i].ot;
        } else { diffOrderDate[i] = 0; }
        if ( tempShippingDate !== orderHistory[i].sst ) {
            diffShippingDate[i-1] += 2;
            diffShippingDate[i] = 1;
            tempShippingDate = orderHistory[i].sst;
        } else { diffShippingDate[i] = 0; }
    }
    let isRefund = false;
    for ( let i = 0 ; i < diffShippingDate.length ; i++ ) {
        if ( refundStart.includes(i) ) {
            diffShippingDate[i] = 1;
            if ( i-1 >= 0 && diffShippingDate[i-1] < 2 ) {
                diffShippingDate[i-1] += 2;
            }
            isRefund = true;
        }
        if ( refundEnd.includes(i) ) {
            diffShippingDate[i] = 2;
            if ( i+1 < diffShippingDate.length && diffShippingDate[i+1] !== 1 ) {
                diffShippingDate[i+1] += 1;
            }
            isRefund = false;
        }
        if ( refundEnd.includes(i) && refundStart.includes(i) ) {
            diffShippingDate[i] = 3;
            isRefund = false;
        }
    }
    console.log(diffShippingDate);
    diffOrderDate.push(2);
    diffShippingDate.push(2);
    return 1;
}

// 날짜 차이 계산
function diffDate() {
    let today = new Date();
    let selectedStartDay = new Date(document.getElementById('start-date').value);
    let selectedEndDay = new Date(document.getElementById('end-date').value);

    let todayYear = today.getFullYear();
    let todayMonth = today.getMonth();
    let todayDay = today.getDate();

    let startYear = selectedStartDay.getFullYear();
    let startMonth = selectedStartDay.getMonth();
    let startDay = selectedStartDay.getDate();

    let endYear = selectedEndDay.getFullYear();
    let endMonth = selectedEndDay.getMonth();
    let endDay = selectedEndDay.getDate();

    let dateToday = new Date(todayYear, todayMonth, todayDay);
    let date1 = new Date(startYear, startMonth, startDay);
    let date2 = new Date(endYear, endMonth, endDay);

    let timeDifference = date2 - date1;
    let dayDifference = timeDifference / (1000 * 3600 * 24);

    let timeDifferenceTodayStartDay = dateToday - date1;
    let dayDifferenceTodayStartDay = timeDifferenceTodayStartDay / (1000 * 3600 * 24);

    let timeDifferenceTodayEndDay = dateToday - date2;
    let dayDifferenceTodayEndDay = timeDifferenceTodayEndDay / (1000 * 3600 * 24);

    startDate = `/${dayDifferenceTodayStartDay}`;
    endDate = `/${dayDifferenceTodayEndDay}`;
    return dayDifference;
}

function getStopLoadingPoint() {
    if ( judPaging ) {
        for (let i = 0; i < diffShippingDate.length; i++) {
            if (diffShippingDate[i] <= 1 && (i % 10) === 9) {
                diffShippingDate[i] += 2;
                if (diffShippingDate[i + 1] === 0 || diffShippingDate[i + 1] === 2) {
                    diffShippingDate[i + 1] += 1;
                }
            }
        }
        for (let i = 0; i < diffOrderDate.length; i++) {
            if (diffOrderDate[i] <= 1 && (i % 10) === 9) {
                diffOrderDate[i] += 2;
                if (diffOrderDate[i + 1] === 0 || diffOrderDate[i + 1] === 2) {
                    diffOrderDate[i + 1] += 1;
                }
            }
        }
    }

    console.log(diffShippingDate);
    console.log(stopLoadingPointList);

}

function refundPaging(e) {
    const button = e.target;
    let checkbox = button.closest(`.purchase-group`);
    let chkRefund = checkbox.querySelectorAll('.chk-refund');
    let prdId = '';
    let pid = '';
    let result = '{';
    let count = 0;
    for ( let i = 0 ; i < chkRefund.length ; i++ ) {
        if ( chkRefund[i].checked ) {
            prdId = chkRefund[i].getAttribute('data-prdid');
            pid = chkRefund[i].getAttribute('data-pid');
            result += `"${count}":{"pid" : ${pid}, "prd_id" : ${prdId}},`
            count += 1;
        }
    }
    let arr = result.split("");
    arr[arr.length - 1] = '}'; // 배열 수정
    result = arr.join("");
    result = JSON.parse(result);
    console.log(result);
    // let refundList = [];
    // for ( let i = 0 ; i < chkRefund.length ; i++ ) {
    // 	if ( chkRefund[i].checked ) {
    // 		refundList.push(chkRefund[i].getAttribute('data-pid'));
    // 	}
    // }
    // if ( refundList.length === 0 ) {
    // 	alert('환불할 상품을 선택해주세요.');
    // 	return;
    // }
    // let xhr = new XMLHttpRequest();
    // xhr.onreadystatechange = function () {
    // 	if (xhr.readyState == 4) {
    // 		if (xhr.status == 200) {
    // 			alert('환불이 완료되었습니다.');
    // 			location.reload();
    // 		} else {
    // 			alert('환불에 실패했습니다.');
    // 		}
    // 	}
    // }
    // xhr.open('POST', `api/refund${prdId}${pid}`, true);
    // xhr.setRequestHeader('Content-Type', 'application/json');
    // xhr.send(JSON.stringify(refundList));
}

function refundLoading(e) {
    let button = e.target;
    let checkbox = button.closest(`.purchase-group-item`);
    let pid = checkbox.querySelector('.list-group-item').dataset.pid;
    let xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            if (xhr.status == 200) {
                if ( xhr.responseText === '1' ) {
                    alert('환불이 완료되었습니다.');
                    pageWrite()
                } else {
                    alert('환불에 실패했습니다.');
                }
            } else {
                alert('환불에 실패했습니다.');
            }
        }
    }
    xhr.open('PUT', `api/refund/${pid}`, true);
    xhr.send();
}

function sayHello() {
    console.log('Hello');
}