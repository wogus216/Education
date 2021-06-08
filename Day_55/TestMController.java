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
import com.spring.sample.web.test.service.ITestMService;

@Controller
public class TestMController {
	//객체를 주입 받겠다.
	@Autowired
	public IPagingService iPagingService;

	@Autowired
	public ITestMService iTestMService;
	
	@RequestMapping(value="/testMList")
	public ModelAndView testMService(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		System.out.println("궁금"+params);
		//현재 페이지
		int page = 1;
		if(params.get("page") != null) {
				page = Integer.parseInt(params.get("page"));
		}
		
		//총 게시글 수
		int maxCount = iTestMService.getMCnt(params);
		int viewCnt= 5;
		int pageCnt= 5;
		//페이징 정보 취득
		PagingBean pb = iPagingService.getPagingBean(page, maxCount, viewCnt, pageCnt);
		
		//글번호 p 없으면 글번호
		// 게시글 시작번호, 종료번호 할당
		//빈형식으로 취득
		params.put("startCnt",Integer.toString(pb.getStartCount()));
		params.put("endCnt",Integer.toString(pb.getEndCount()));
		

		System.out.println(params);
		List<HashMap<String, String>>list
					= iTestMService.getMList(params);
		mav.addObject("list1", list);
		mav.addObject("pb", pb);
		mav.addObject("page", page);
		mav.addObject("maxCount", maxCount);
		
		
		mav.setViewName("test/testMList");
			
			return mav;
	}
	
	@RequestMapping(value="/testMDetail")
	public ModelAndView testm2(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		if(params.get("mNo") != null) {
			HashMap<String, String> data
						= iTestMService.getM(params);
			
		mav.addObject("data", data);
		
		mav.setViewName("test/testMDetail");
		} else {
			mav.setViewName("redirect:testMList");
		}
		return mav;
		
	}
	
	@RequestMapping(value="/testMAdd")
	public ModelAndView testMAdd(ModelAndView mav) {
		mav.setViewName("test/testMAdd");
		
		return mav;
	}
	
	@RequestMapping(value="/testMAdds")
	public ModelAndView testMAdds(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav){
				
	
		try {
			int cnt = iTestMService.addM(params);
			
			if(cnt > 0) {
				mav.setViewName("redirect: testMList");
			} else {
				mav.addObject("msg", "문제발생");
				mav.setViewName("redirect: testMAdds");
			}
		} catch (Throwable e) {
			e.printStackTrace();
			mav.addObject("msg", "오류발생");
			mav.setViewName("test/testMAdds");
			
			
		}
		
		
		return mav;
		 
	}
	@RequestMapping(value="/testMUpdate")
	public ModelAndView testMUpdate(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		if(params.get("mNo") != null) {
			HashMap<String, String> data
						= iTestMService.getM(params);
			
		mav.addObject("data", data);
		
		mav.setViewName("test/testMUpdate");
		} else {
			mav.setViewName("redirect:testMList");
		}
		return mav;
		
	}
	
	@RequestMapping(value="/testMUpdates")
	public ModelAndView testMUpdates(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav){
				
	
		try {
			int cnt = iTestMService.updateM(params);
			
			mav.addObject("cnt", cnt);
				
			
		} catch (Throwable e) {
			e.printStackTrace();
			mav.addObject("msg", "오류발생");
			
		}
		mav.setViewName("test/testMUpdates");
		
		
		return mav;
	}
	
	
	@RequestMapping(value="/testMDeletes")
	public ModelAndView testMdeltes(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav){
				
	
		try {
			int cnt = iTestMService.deleteM(params);
			
			if(cnt > 0) {
				mav.setViewName("redirect: testMList");
			} else {
				mav.addObject("msg", "문제발생");
				mav.setViewName("redirect: testMDeletes");
			}
		} catch (Throwable e) {
			e.printStackTrace();
			mav.addObject("msg", "오류발생");
			mav.setViewName("test/testMDeletes");
			
			
		}
		
		return mav;
		 
	}
}//class end
