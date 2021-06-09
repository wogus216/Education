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
	public ModelAndView testLogin(HttpSession session,ModelAndView mav) {
		if(session.getAttribute("sMNo") != null) {//로그인 상태
			mav.setViewName("redirect:testO");
		} else { // 비 로그인 상태
			mav.setViewName("test/testLogin");
		}
		
		
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

	@RequestMapping(value="/testLogout")
	public ModelAndView testLogout(
			//셋션을 받아옴
			HttpSession session,
			ModelAndView mav) {
		//session 초기화
		session.invalidate();
		//로그인 화면 으로 넘어감
		mav.setViewName("redirect:testLogin");
		
		return mav;
		
	}
}
