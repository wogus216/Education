package com.spring.sample.web.test.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
			//HttpServletRequest req,
			//스프링이 세션을 알아서 갖고온다.
			HttpSession session,
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable	{
		HashMap<String, String> data
				= iTestLService.getM(params);
		if(data != null) {
			//HttpSession session = req.getSession();
			session.setAttribute("sMNo", data.get("M_NO"));
			session.setAttribute("sMNm", data.get("M_NM"));
			System.out.println(session.getAttribute("sMNm"));
			
			
			mav.addObject("res", "success");
		} else {
			mav.addObject("res", "failed");
		}
		mav.setViewName("test/testLogins");
		
		return mav;
	}
	
	@RequestMapping(value="/testO")
	public ModelAndView testO(ModelAndView mav) {
		mav.setViewName("test/testO");
		
		return mav;
	}
	
}
