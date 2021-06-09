package com.spring.sample.web.test.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.web.test.service.ITestLService;

@Controller
public class TestLController {

	@Autowired
	public ITestLService iTestLService;
	
	@RequestMapping(value="/testLogin")
	public ModelAndView testLogin(ModelAndView mav) {
		mav.setViewName("test/testLogin");
		
		return mav;
	}
	
	@RequestMapping(value="/testLogins")
	public ModelAndView testLogins(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable	{
		HashMap<String, String> data
				= iTestLService.getM(params);
		
		
		return mav;
	}
	
}
