// register.js
const emailElement = document.getElementById("id-input").value.trim();
const pwdElement = document.getElementById("pw-input").value.trim();
const pwdChkElement = document.getElementById("pwchk-input").value.trim();
const addrElement = document.getElementById("address-input").value.trim();
const zipElement = document.getElementById("zipcode-input").value.trim();

let cart = JSON.parse(localStorage.getItem("cart")) || [];
const count = document.getElementById('cart-counter');
window.onload = function(){

}

document.getElementById("formJoin").addEventListener("submit", (e) => {
    e.preventDefault();

    let email = emailElement.value;
    let pwd = pwdElement.value;
    let pwdChk = pwdChkElement.value;
    let addr = addrElement.value;
    let zip = zipElement.value;

    if(email === "") {
        alert("이메일을 입력하시기 바랍니다.");
    } else if(pwd === "") {
        alert("비밀번호를 입력하시기 바랍니다.");
    } else if(pwdChk === "") {
        alert("비밀번호 확인을 입력하시기 바랍니다.");
    } else if(addr === "") {
        alert("주소를 입력해주시기 바랍니다.");
    } else if(zip === "") {
        alert("우편번호를 입력해주시기 바랍니다.")
    } else {
        alert("테스트");
        // fetch('/api/customer/login', {
        //     method: 'POST',
        //     headers: {
        //         'Content-Type': 'application/json',
        //     },
        //     body: JSON.stringify({email, pwd})
        // })
        //     .then(resp => resp.json())
        //     .then(res => {
        //         if(res.success) {
        //             // window.location.href = '/main.do';
        //         } else {
        //             alert('로그인 실패 : ' + res.message);
        //         }
        //     })
        //     .catch(e => console.error('[에러] : ',e));
    }
});

function dupEmailCheck() {

}