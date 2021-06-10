package com.spring.sample.web.test.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.test.service.ITestLService;

@Controller
public class TestLController {

	@Autowired
	public IPagingService iPagingService;
	
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
	
	@RequestMapping(value="/testO")
	public ModelAndView testO(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		//페이지 취득
		int page = 1;
		
		if(params.get("page") !=null) {
			page = Integer.parseInt(params.get("page"));
		}
		
		//총 글 개수
		int cnt = iTestLService.getObCnt(params);
		
		
		//페이징 계산
		PagingBean pb = iPagingService.getPagingBean(page, cnt);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		//목록 취득
		List<HashMap<String, String>> list
						=iTestLService.getObList(params);
		//jsp로 넘긴다.
		System.out.println(list);
		System.out.println(params);
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("pb", pb);
		
		
		mav.setViewName("test/testO");
		
		return mav;
	}
	
	@RequestMapping(value="testOWrite")
	public ModelAndView testOWrite(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
			
		try {
			int cnt = iTestLService.writeOb(params);
			
			if(cnt > 0) {
				mav.setViewName("redirect: testO");
			} else {
				mav.addObject("res", "failed");
				mav.setViewName("test/testOWrite");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res", "error");
			mav.setViewName("test/testOWrite");
		}
		
		return mav;
		
	}
	
	@RequestMapping(value="testOUpdate")
	public ModelAndView testOUpdate(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
				
		try {
			int cnt = iTestLService.updateOb(params);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mav.setViewName("test/testOUpdate");
		return mav;
	}

	@RequestMapping(value="testODelete")
	public ModelAndView testODelete(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav
			) throws Throwable {
		
		try {
			int cnt = iTestLService.deleteOb(params);
			
			if(cnt > 0) {
				mav.setViewName("redirect: testO");
			} else {
				mav.addObject("res", "failed");
				mav.setViewName("test/testODelete");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("res", "error");
			mav.setViewName("test/testODelete");
		}
		
		
		return mav;
		
	}
}
