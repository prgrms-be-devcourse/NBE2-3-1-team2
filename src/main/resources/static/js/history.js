// HTML 렌더링 함수
function renderPurchaseHistory(groupedData) {
    const purchaseGroup = document.querySelector('.purchase-group');
    purchaseGroup.innerHTML = ""; // 기존 내용을 초기화

    const orderTimes = Object.keys(groupedData);
    const totalOrders = orderTimes.length; // 총 주문 개수

    orderTimes.forEach((orderTime, index) => {
        const orderItems = groupedData[orderTime];

        // 주문 번호 계산: 최신 주문이 00001부터 시작
        const orderNumber = String(totalOrders - index).padStart(5, '0');

        // 주문 그룹 HTML 생성
        const groupItem = document.createElement('li');
        groupItem.classList.add('purchase-group-item');

        groupItem.innerHTML = `
            <div class="ms-1 mb-1 d-flex justify-content-between">
                <span>주문번호 : ${orderNumber} ( ${orderTime} )</span>
                <span class="me-3">${orderItems[0].delivery_status}</span>
            </div>
            <div class="d-flex purchase-list-container">
                <ul class="col list-group">
                    ${orderItems.map(item => `
                        <li class="list-group-item d-flex align-items-center">
                            <div>
                                <img class="product-img" src="./images/${item.image}" alt="${item.product_name}">
                            </div>
                            <div class="col">
                                <div class="text-muted">${item.category}</div>
                                <div>${item.product_name}</div>
                            </div>
                            <div class="px-3">${item.quantity}개</div>
                            <div class="px-3 text-center">${(item.total_price).toLocaleString()}원</div>
                        </li>
                    `).join('')}
                </ul>
                <div class="px-3 my-auto">
                    <div class="my-4 d-flex justify-content-between">
                        <span class="pe-4">총 금액</span>
                        <span class="ps-4">${calculateTotalPrice(orderItems).toLocaleString()}원</span>
                    </div>
                    <button class="w-100 btn btn-dark">환불하기</button>
                </div>
            </div>
            <hr>
        `;

        purchaseGroup.appendChild(groupItem);
    });
}