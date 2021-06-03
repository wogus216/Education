package com.spring.sample.web.test.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.web.test.service.ITestService;

@Controller
public class TestController {

	//객체주입 받겠다.
	@Autowired
	public ITestService iTestService;
	
	@RequestMapping(value="/test1")
	
	public ModelAndView test1(ModelAndView mav) throws Throwable {
		
		List<HashMap<String, String>>list
					= iTestService.getBList();
		
		mav.addObject("list", list);
		
		mav.setViewName("test/test1");
	
		return mav;
		
	}
	
	
//	@RequestMapping(value="/testMList")
//	public ModelAndView testMList(ModelAndView mav) throws Throwable{
//		
//		List<HashMap<String, String>>list1
//							= iTestService.getMList();
//		
//		mav.addObject("list", list1);
//		
//		mav.setViewName("test/testMList");
//		
//		return mav;
//	}
	
	@RequestMapping(value="/test2")
	public ModelAndView tes2(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		if(params.get("bNo") !=null) {
			//단일 컬럼은 해쉬맵으로 갖고온다
			HashMap<String, String> data
			=iTestService.getB(params);
			
			mav.addObject("data", data);
			
			mav.setViewName("test/test2");
			
		} else {
			//redirect: 주소 => 해당주소로 이동. 즉, 컨트롤러에서 컨트롤러로 이동
			//					get방식만 적용됨
			mav.setViewName("redirect:test1");
		}
		
		return mav;
	}

	@RequestMapping(value="/ajaxTest")
	public  ModelAndView ajaxtest(ModelAndView mav) {
		
		mav.setViewName("test/ajaxTest");
		return mav;
	}
	
	@RequestMapping(value="/test3")
	public ModelAndView test3(ModelAndView mav) {
		mav.setViewName("test/test3");
		
		return mav;
	}
	
	@RequestMapping(value="/test3s")
	public ModelAndView test3s(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		
		int cnt = iTestService.addB(params);
		
		if(cnt > 0) {
			mav.setViewName("redirect:test1");
		} else {
			mav.addObject("msg", "등록실패");
			mav.setViewName("redirect:test3");
		}
		return mav;
	}
}
