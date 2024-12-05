// register.js
const emailElement = document.getElementById("id-input");
const pwdElement = document.getElementById("pw-input");
const pwdChkElement = document.getElementById("pwchk-input");
const addrElement = document.getElementById("address-input");
const zipElement = document.getElementById("zipcode-input");

let cart = JSON.parse(localStorage.getItem("cart")) || [];
const count = document.getElementById('cart-counter');
window.onload = function(){
    addEvent();
}

document.getElementById("formJoin").addEventListener("submit", (e) => {
    e.preventDefault();

    let email = emailElement.value;
    let pwd = pwdElement.value;
    let pwdChk = pwdChkElement.value;
    let addr = addrElement.value;
    let zip = zipElement.value;

    if(email === "" || email === undefined) {
        alert("이메일을 입력하시기 바랍니다.");
    } else if(pwd === "") {
        alert("비밀번호를 입력하시기 바랍니다.");
    } else if(pwdChk === "") {
        alert("비밀번호 확인을 입력하시기 바랍니다.");
    } else if(addr === "") {
        alert("주소를 입력해주시기 바랍니다.");
    } else if(zip === "") {
        alert("우편번호를 입력해주시기 바랍니다.")
    } else if(pwd !== pwdChk) {
        alert("입력하신 비밀번호가 서로 다릅니다.")
        pwdChkElement.value = "";
    } else if(zip.length !== 5) {
        alert("우편번호를 형식에 맞게 입력해주세요. (ex. 00000)");
    } else {
        let reqData = {
            'email': email,
            'pwd': pwdChk,
            'addr': addr,
            'zip': zip,
        }
        fetch('/api/customer/join', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(reqData)
        })
            .then(resp => resp.json())
            .then(res => {
                console.log(res.success);
                if(res.success) {
                    window.location.href = '/login.do';
                } else {
                    alert(res.message);
                }
            })
            .catch(e => console.error('[에러] : ',e));
    }
});

function addEvent() {
    zipElement.addEventListener("input", function () {
        this.value = this.value.replace(/[^0-9]/g, ""); // 숫자가 아닌 문자 제거
    })
    emailElement.addEventListener("blur", function () {
        let email = emailElement.value;
        fetch('/api/customer/join/email', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                "email": email,
            })
        })
            .then(resp => resp.json())
            .then(res => {
                if(!res.success) {
                    alert(res.message);
                    emailElement.value = '';
                }
            })
            .catch(err => console.log(err));
    })
    pwdChkElement.addEventListener("blur", function () {
        let pwd = pwdElement.value;
        let pwdChk = this.value;
        if (pwd !== pwdChk){
            alert("입력하신 비밀번호가 서로 다릅니다.")
            this.value = "";
        }
    })

}