// session.js
window.onload = function () {
    checkSession();
    setupLinks();
};

// 세션 확인 및 로그인/로그아웃 버튼 처리
function checkSession() {
    const loginBtnDiv = document.querySelector('.login-btn-div');
    const sessionRequest = new XMLHttpRequest();
    sessionRequest.onreadystatechange = function () {
        if (sessionRequest.readyState === 4) {
            if (sessionRequest.status === 200) {
                const response = JSON.parse(sessionRequest.responseText);
                if(response.status === "logged_in"){
                    updateLogoutButton(loginBtnDiv);
                } else {
                    loginBtnDiv.innerHTML = `<a class="btn btn-outline-dark login-btn" href="/login.do">로그인</a>`;
                }
            }
        }
    };
    sessionRequest.open("GET", "/api/checkSession", true);
    sessionRequest.send();
}

// 특정 링크 클릭 시 세션 확인
function setupLinks() {
    document.querySelectorAll('.quick-link').forEach(link => {
        link.onclick = function (event) {
            event.preventDefault();
            const sessionCheckRequest = new XMLHttpRequest();
            sessionCheckRequest.onreadystatechange = function () {
                if (sessionCheckRequest.readyState === 4) {
                    if (sessionCheckRequest.status === 200) {
                        const response = JSON.parse(sessionCheckRequest.responseText);
                        if(response.status === "logged_in"){
                            window.location.href = link.getAttribute('href');
                        } else {
                            alert("로그인이 필요합니다.");
                            window.location.href = "/login.do";
                        }

                    }
                }
            };
            sessionCheckRequest.open("GET", "/api/checkSession", true);
            sessionCheckRequest.send();
        };
    });
}

// 로그아웃 버튼 설정 함수
function updateLogoutButton(loginBtnDiv) {
    loginBtnDiv.innerHTML = `<a class="btn btn-outline-dark logout-btn" href="#">로그아웃</a>`;
    document.querySelector('.logout-btn').onclick = function (event) {
        event.preventDefault();
        const logoutRequest = new XMLHttpRequest();
        logoutRequest.onreadystatechange = function () {
            if (logoutRequest.readyState === 4 && logoutRequest.status === 200) {
                window.localStorage.clear();
                alert("로그아웃 되었습니다.");
                loginBtnDiv.innerHTML = `<a class="btn btn-outline-dark login-btn" href="/login.do">로그인</a>`;
                window.location.href = "/main.do";
            }
        };
        logoutRequest.open("GET", "/api/logout", true);
        logoutRequest.send();
    };
}
