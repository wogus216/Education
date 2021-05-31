package com.spring.sample.web.test.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.web.test.service.ITestService;

@Controller
public class TestController {
	
	//객체 주입받겠다.
		@Autowired
		public ITestService iTestService;
		
		@RequestMapping(value="/test1")
		
		public ModelAndView test1(ModelAndView mav) throws Throwable  {
			
			List<HashMap<String, String>>list
					=iTestService.getBList();
			
			mav.addObject("list", list);
			
			mav.setViewName("test/test1");
			
			return mav;
		}
}
