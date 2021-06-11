package com.spring.sample.web.testa.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.sample.web.test.service.ITestLService;

@Controller
public class TestAController {
	@Autowired
	public ITestLService iTestLService;

	@RequestMapping(value="/testALogin")
	public ModelAndView testALogin(ModelAndView mav) {
		
		mav.setViewName("testa/testALogin");
		
		return mav;
	}
	// RequestMapping : value - 주소
	//					method - 전송방식지정
	// 					produces - 돌려줄 형식
	@RequestMapping(value="/testALogins",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8") //보낼데이터가 어떠한 형태인지 설정
	@ResponseBody // Spring에 view임을 제시, 오늘의 제일 중요한점 바로 웹으로 넘긴다. jsp 같은 역활을 한다.
	public String testALogins(
			HttpSession session,
			@RequestParam HashMap<String, String> params) throws Throwable{
		// ObjectMapper : 객체를 문자열로 전환 - Jackson 라이브러리
		ObjectMapper mapper = new ObjectMapper();
		//model은 데이터를 담고있는 것
		// 데이터 보관용 map
		// 모든 형태를 받기위해서 벨류값 형태 Object
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		HashMap<String, String> data = iTestLService.getM(params);
		
		if(data != null) { //사용자 정보가 있음
			session.setAttribute("sMNo", data.get("M_NO"));
			session.setAttribute("sMNm", data.get("M_NM"));
			System.out.println(session.getAttribute("sMNm"));
			
			modelMap.put("resMsg", "success");
		} else { // 사용자 정보가 없음
			modelMap.put("resMsg", "failed");
			
		}
		// "{"resMsg" : "success"}"
		// writeValueAsString :객체를 문자열로 변환 , 받는 인자값이 형태가 object라 다 받을 수 있음
		return mapper.writeValueAsString(modelMap);
		
		
	}
	
	 @RequestMapping(value="/testABList")
	 public ModelAndView testABList(
			 @RequestParam HashMap<String, String> params,
			 ModelAndView mav) {
		 
		 int page = 1;
		 
		 if(params.get("page") != null) {
			 page = Integer.parseInt(params.get("page"));
		 }
	
		 mav.addObject("page", page);
		 mav.setViewName("testa/testABList");
		 
		 return mav;
		 
	 }
	
	
}
