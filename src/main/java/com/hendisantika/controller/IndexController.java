package com.hendisantika.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: hendisantika
 * Email: hendisantika@gmail.com
 * Telegram : @hendisantika34
 * Date: 7/28/17
 * Time: 4:54 PM
 * To change this template use File | Settings | File Templates.
 */

@Controller
public class IndexController {

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("author", "hendisantika");
        model.addAttribute("time", new Date());
        return "index";
    }
}
