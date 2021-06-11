package com.spring.sample.web.testa.controller;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestAController {

	@RequestMapping(value="/testALogin")
	public ModelAndView testALogin(ModelAndView mav) {
		
		mav.setViewName("testa/testALogin");
		
		return mav;
	}
	// RequestMapping : value - 주소
	//					method - 전송방식지정
	@RequestMapping(value="/testALogins",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody // Spring에 view임을 제시, 오늘의 제일 중요한점 바로 웹으로 넘긴다.
	public String testALogins(
			@RequestParam HashMap<String, String> params) throws Throwable{
				
		return "";
		
		
	}
	
	 
	
	
}
