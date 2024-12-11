function cartIcon() {
    let existingCart = JSON.parse(localStorage.getItem('cart')) || {}; // localStorage에서 값 가져오기
    //장바구니 아이콘에 표시하기
    let productCount = Object.keys(existingCart).length;
    document.getElementById('cart-counter').innerHTML = productCount;
}