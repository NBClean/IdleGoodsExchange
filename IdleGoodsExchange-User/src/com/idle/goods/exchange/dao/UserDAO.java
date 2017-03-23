package com.idle.goods.exchange.dao;

import com.idle.goods.exchange.domain.User;
/**
 * Created by Linda on 3/23/2017.
 */
public class UserDAO {

    public static boolean insert(User user){

        return true;
    }

    public static User query(User user){

        return new User();
    }

    public static boolean update(User user){
        return true;
    }
}
