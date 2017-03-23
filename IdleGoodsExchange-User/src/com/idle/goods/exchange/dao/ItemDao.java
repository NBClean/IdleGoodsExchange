package com.idle.goods.exchange.dao;

import com.idle.goods.exchange.domain.Item;

/**
 * Created by Linda on 3/23/2017.
 */
public class ItemDao {
    public static boolean insert(Item item){
        return true;
    }

    public static Item query(Item item){
        return new Item();
    }

    public static boolean update(){
        return true;
    }
}
