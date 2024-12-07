package com.example.project01.dao;

import com.example.project01.dto.CustomerTO;
import com.example.project01.mapper.CustomerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerDAO {

    @Autowired
    CustomerMapper customerMapper;

    public String emailCheck(CustomerTO to) {

        String checkEmail = customerMapper.joinCheck(to);

        if (checkEmail != null && !checkEmail.equals("") && checkEmail.equals(to.getEmail()) ) {
            // 가입된 이메일이면, "1" 반환
            return "1";

        } else {
            // 가입된 이메일이 없으면, 유저 생성 및 JoinCk = "0"
            int flag = customerMapper.userInsert(to);

            if (flag == 1) {
                return "0";
            } else {
                return "2";
            }
        }
    }

    public int loginCheck(CustomerTO to) {

        Integer cid = customerMapper.userCheck(to);
        if (cid != null && cid != 0) {
            return cid;
        } else {
            return 0;
        }
    }

    // 해당 유저 데이터 가져오기
    public CustomerTO selectUser(CustomerTO to) {

        to = customerMapper.selectUserData(to);

        return to;
    }
}
