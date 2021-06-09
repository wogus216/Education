package com.spring.sample.web.test.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.test.service.ITestService;

@Controller
public class TestController {

	//객체주입 받겠다.
	@Autowired
	public IPagingService iPagingService;
	
	@Autowired
	public ITestService iTestService;
	
	@RequestMapping(value="/test1")
	
	public ModelAndView test1(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		// 현재 페이지
		int page = 1; 
		if(params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
		// 총 게시글 수 
		int cnt = iTestService.getBCnt(params);
		
		// 페이징 정보 취득
		PagingBean pb= iPagingService.getPagingBean(page, cnt); 
		//글번호 P 없으면 글번호
		//게시글 시작번호, 종료번호 할당
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		// 목록 취득
		List<HashMap<String, String>>list= iTestService.getBList(params);
		
		mav.addObject("list", list);
		mav.addObject("pb", pb);
		mav.addObject("page", page);
		mav.addObject("cnt", cnt);
		
		mav.setViewName("test/test1");
	
		return mav;
		
	}
	

	//등록
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
	//상세보기
	@RequestMapping(value="/test3")
	public ModelAndView test3(ModelAndView mav) {
		mav.setViewName("test/test3");
		
		return mav;
	}
	
	@RequestMapping(value="/test3s")
	public ModelAndView test3s(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) {
	
			
			try {
				int cnt = iTestService.addB(params);
				
				if(cnt > 0 ) {
					 mav.setViewName("redirect:test1");
				} else {
					 mav.addObject("msg", "등록실패");
					 mav.setViewName("test/test3s");
				}
				
			} catch (Throwable e) {
				e.printStackTrace();
				 mav.addObject("msg", "오류발생");
				 mav.setViewName("test/test3s");
			}
			
		
		return mav;
	}
	//수정
	@RequestMapping(value="/test4")
	public ModelAndView test4(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		if(params.get("bNo") !=null) {
			//단일 컬럼은 해쉬맵으로 갖고온다
			HashMap<String, String> data=iTestService.getB(params);
			
			mav.addObject("data", data);
			
			mav.setViewName("test/test4");
			
		} else {
			//redirect: 주소 => 해당주소로 이동. 즉, 컨트롤러에서 컨트롤러로 이동
			//					get방식만 적용됨
			mav.setViewName("redirect:test1");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/test4s")
	public ModelAndView test4s(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) {
	
			
			try {
				int cnt = iTestService.updateB(params);
				
				mav.addObject("cnt", cnt);
					
			} catch (Throwable e) {
				e.printStackTrace();
				mav.addObject("msg", "오류발생");
			}
			
			mav.setViewName("test/test4s");
		
		return mav;
	}
	
	@RequestMapping(value="/test5s")
	public ModelAndView test5s(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) {
	
			
			try {
				int cnt = iTestService.deleteB(params);
				
				if(cnt > 0 ) {
					 mav.setViewName("redirect:test1");
				} else {
					 mav.addObject("msg", "등록실패");
					 mav.setViewName("test/test5s");
				}
				
			} catch (Throwable e) {
				e.printStackTrace();
				 mav.addObject("msg", "오류발생");
				 mav.setViewName("test/test5s");
			}
			
		
		return mav;
	}
}
