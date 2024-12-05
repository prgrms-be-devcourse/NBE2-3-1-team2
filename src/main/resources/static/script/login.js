// login.js
let cart = JSON.parse(localStorage.getItem("cart")) || [];
const emailElement = document.getElementById("id-input");
const pwdElement = document.getElementById("pw-input");
const count = document.getElementById('cart-counter');
window.onload = function(){
    count.innerHTML = cart.length.toString();
    submitForm()
}

function submitForm() {
    document.getElementById("formLogin").addEventListener("submit", (e) => {
        e.preventDefault();

        let email = emailElement.value;
        let pwd = pwdElement.value;

        if(email === "") {
            alert("이메일을 입력하시기 바랍니다.");
        } else if(pwd === "") {
            alert("비밀번호를 입력하시기 바랍니다.");
        } else {
            fetch('/api/customer/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({email, pwd})
            })
                .then(resp => resp.json())
                .then(res => {
                    if(res.success) {
                        window.location.href = '/main.do';
                    } else {
                        alert('로그인 실패 : ' + res.message);
                    }
                })
                .catch(e => console.error('[에러] : ',e));
        }
    });
}



function rememberId(check) {

}