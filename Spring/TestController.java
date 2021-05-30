package com.test.spring.test.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.test.spring.test.service.ITestService;

@Controller
public class TestController {
	//@Autowired 아래 지정된 변수에 대상 객체를 주입한다.
	@Autowired
	public ITestService iTestService;
		
	@RequestMapping(value="/test1")
	
	/*
	 * ModelAndView : 데이터와 뷰를 담을 수 있는 클래스
	 */
	public ModelAndView test1(ModelAndView mav) {
		
		//ViewResoloverr : "/WEB-INF/views/test/test1.jsp"
		mav.setViewName("test/test1"); // jsp 위치지정
		
		return mav;
	}
	//@HttpServletRequest : 요청과 관련된 데이터 집합(사용자에서 넘어온 것)
	//@RequestParam(value=값)변수타입 변수명 : 값에 해당하는 key가 넘어올 때
	//									//key에 연결된 값을 변수에 담는다.
	//@ReuestParam 변수타입 변수명 : 변수명과 동일한 key가 넘어올 때
	//							 key에 연결된 값을 변수에 담는다.
	//@RequestParam HashMap : 넘어오는 Key와 Value들을 Map에 담는다.
	//@RequestParam(value=값) List 변수명 : 값에 해당하는 Key들이 넘어올 때
	//  List는 체크박스 할 때 사용			      Key에 연결된 값들을 리스트에 담는다.
	//HttpServletResponse: 응답에 대한 정보(보낼형태, 헤더정보)
	@RequestMapping(value="/test2")
	public ModelAndView test2(HttpServletRequest req,
			@RequestParam(value="txt") String s,
			@RequestParam String txt,
			@RequestParam HashMap<String, String> params,
			@RequestParam (value="txt") ArrayList<String> list,
														   ModelAndView mav) {
		System.out.println(req.getParameter("txt"));
		System.out.println(s);
		System.out.println(txt);
		System.out.println(params.get("txt"));
		System.out.println(list.get(0));
		
		//req.setAttribute("test","Hi~");
		
		mav.addObject("test","Hi2!!"); // Model에 값을 담는다.
		
		List<HashMap<String, String>> data
						= new ArrayList<HashMap<String, String>>();
		for(int i = 10; i > 0 ; i--) {
			HashMap<String, String> temp
						= new HashMap<String, String>();
			
			temp.put("no", Integer.toString(i));
			temp.put("title", "test" + i);
			
			data.add(temp);
			
		}
		mav.addObject("data", data);
		
		mav.setViewName("test/test2");
		
		return mav;
	}
	// 주소가 생길때 마다 아래 형식을 만들어준다.
	@RequestMapping(value="/ajaxTest")
	public ModelAndView at(ModelAndView mav) {
		
		mav.setViewName("test/ajaxTest");

		return mav;
	}
	
	@RequestMapping(value="/ajaxTest1")
	public ModelAndView at1(ModelAndView mav) {
		
		mav.setViewName("test/ajaxTest1");

		return mav;
	}
	
	@RequestMapping(value="/ajaxTestT")
	public ModelAndView at2(ModelAndView mav) {
		
		mav.setViewName("test/ajaxTestT");

		return mav;
	}
	
	@RequestMapping(value="/ajaxSimpleData")
	public ModelAndView at3(ModelAndView mav) {
		mav.setViewName("test/ajaxSimpleData");
		
		return mav;
	}
	
	@RequestMapping(value="/test3")
	public ModelAndView test3(ModelAndView mav) {
		
		iTestService.test();
		
		mav.setViewName("test/test3");
		
		return mav;
	}
	
	@RequestMapping(value="/test4")
	public ModelAndView test4(
			@RequestParam int num,
			ModelAndView mav) {
		
		String gugu=iTestService.gugu(num); //문자열 변환
		
		mav.setViewName("test/test4");
		
		mav.addObject("gugu", gugu);
		return mav;
	}
}
