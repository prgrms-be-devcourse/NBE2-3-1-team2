function deleteAccount() {
    if (confirm("정말로 회원탈퇴를 진행하시겠습니까?")) {
        // 회원탈퇴 로직 호출 (예: API 요청)
        console.log("##########")
        const request = new XMLHttpRequest();
        request.open("POST", "/api/deleteAccount", true);
        request.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        request.onreadystatechange = function () {
            if (request.readyState === 4) {
                if (request.status === 200) {
                    const response = JSON.parse(request.responseText);
                    if(response.status === "delete_success"){
                        alert("회원탈퇴가 완료되었습니다.");
                        window.location.href = "/main.do";
                    } else {
                        console.log("회원 탈퇴 실패")
                    }
                }
            }
        };
        request.send(); // 서버로 전달할 데이터
    }
}
