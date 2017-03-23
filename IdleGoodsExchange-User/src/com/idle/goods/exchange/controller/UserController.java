package com.idle.goods.exchange.controller;

import com.idle.goods.exchange.domain.User;
import com.idle.goods.exchange.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Linda on 3/22/2017.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/register")
    public String userRegister(){
        return "user/register";
    }

    @RequestMapping("/login")
    public String userLogin(){
        return "user/welcome";
    }

    @RequestMapping(method= RequestMethod.POST)
    public ModelAndView createUser(User user){
        userService.registerUser(user);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/user/createSuccess");
        mav.addObject(user);
        return mav;
    }
}
