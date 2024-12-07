// common.js

// 로그인 세션 여부 확인 함수
function loginSessionCheck(callback) {
    const request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if(request.readyState === 4) {
            if(request.status === 200) {

                const result = JSON.parse(request.responseText.trim());

                if( result.loginStatus === "loginYes" ) { callback("loginYes");
                } else if(result.loginStatus === "loginNo" ) { callback("loginNo");
                } else {
                    alert("[에러] 서버 오류");
                    callback(null);
                }

            } else {
                alert("[에러] 페이지 오류(404, 500)");
                callback(null);
            }
        }
    }

    request.open("GET", "/api/loginSessionCheck", true);
    request.send();
}

// 로그아웃 함수
function logout(callback) {
    const request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if(request.readyState === 4) {
            if(request.status === 200) {

                const result = JSON.parse(request.responseText.trim());

                if( result.logoutStatus === "success" ) { callback("success");
                } else {
                    alert("[에러] 서버 오류");
                    callback(null);
                }

            } else {
                alert("[에러] 페이지 오류(404, 500)");
                callback(null);
            }
        }
    }
    request.open("GET", "/api/logout", true);
    request.send();
}

// 현재 로그인 중인 사용자의 데이터 가져오기
function userData(callback) {
    const request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if(request.readyState === 4) {
            if(request.status === 200) {

                const jsonData = JSON.parse(request.responseText.trim());

                if( jsonData.selectStatus === "success" ) {

                    const userForm = {
                        email : jsonData.email,
                        addr : jsonData.addr,
                        zip : jsonData.zip,
                    };

                    callback(userForm);

                } else {
                    alert("[에러] 서버 오류");
                    callback(null);
                }

            } else {
                alert("[에러] 페이지 오류(404, 500)");
                callback(null);
            }
        }
    }
    request.open("GET", "/api/userData", true);
    request.send();
}

