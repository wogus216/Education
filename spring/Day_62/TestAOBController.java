package com.spring.sample.web.tests.controller;

import java.util.HashMap;
import java.util.List;
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
import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.tests.service.ITestAOBService;

@Controller
public class TestAOBController {

	@Autowired
	public ITestAOBService iTestAOBService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value="/testAOBLogin")
	public ModelAndView testAOBLogin(ModelAndView mav) {
		
		mav.setViewName("tests/testAOBLogin");
				return mav;
		
	}
	
	@RequestMapping(value="/testAOBLogins",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
		@ResponseBody //// Spring에 view임을 제시, 오늘의 제일 중요한점 바로 웹으로 넘긴다. jsp 같은 역활을 한다.
		public String testAOBLogins(
				HttpSession session,
				@RequestParam HashMap<String, String> params) throws Throwable {
		// ObjectMapper : 객체를 문자열로 전환 - Jackson 라이브러리	
		ObjectMapper mapper = new ObjectMapper();
		//model은 데이터를 담고있는 것
		// 데이터 보관용 map
	// 모든 형태를 받기위해서 벨류값 형태 Object
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		HashMap<String, String> data = iTestAOBService.getM(params);
		System.out.println("data"+data);
		if(data != null) { //사용자 정보있음
			session.setAttribute("sMNo", data.get("M_NO"));
			session.setAttribute("sMNm", data.get("M_NM"));
			System.out.println(session.getAttribute("sMNm"));
		
			modelMap.put("Msg", "success");
		} else { //사용자 정보가 없음
			modelMap.put("Msg", "failed");
			
		}
		return mapper.writeValueAsString(modelMap);
		
	}
	
	@RequestMapping(value="testAOBList")
	public ModelAndView testAOBList(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) {
		
		int page = 1;
		
		System.out.println("목록"+params);
		if(params.get("page") != null) {
			page = Integer.parseInt(params.get("page"));
		}
		mav.addObject("page", page);
		mav.setViewName("tests/testAOBList");
		
		return mav;
		
	}
	
	@RequestMapping(value="/testAOBLists",
	method = RequestMethod.POST,
	produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testAOBLists(
			@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper =new ObjectMapper();
		System.out.println("mapper"+mapper);
		Map<String, Object> modelMap = new HashMap<String, Object>();
	
			//현재페이지
			int page = Integer.parseInt(params.get("page"));
			
			//총게시글수
			int cnt = iTestAOBService.getOBCnt(params);
			
			//페이징 정보 취득
			PagingBean pb = iPagingService.getPagingBean(page, cnt);
			
			//게시글시작번호, 종료번호
			params.put("startCnt", Integer.toString((pb.getStartCount())));
			params.put("endCnt", Integer.toString((pb.getEndCount())));
			
			//목록취득
			List<HashMap<String, String>>list= iTestAOBService.getOBList(params);
			
			modelMap.put("list", list);
			modelMap.put("pb", pb);
			
			System.out.println("modelMap"+modelMap);
			
		return mapper.writeValueAsString(modelMap);
	}
	
	//로그아웃
	@RequestMapping(value="/testAOBLogout")
	public ModelAndView testAOBLogout(
			HttpSession session,
			ModelAndView mav) {
		
		session.invalidate();
		
		mav.setViewName("tests/testAOBLogin");
		return mav;
		
	}
	
	//작성
	@RequestMapping(value="/testAOBWrites",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String testAOBWrites(
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();

		try {
			int cnt = iTestAOBService.writeOB(params);

			if(cnt > 0) {
				modelMap.put("msg", "success");

			} else {
				modelMap.put("msg", "failed");
			}

		} catch (Throwable e) {
			e.printStackTrace();
			modelMap.put("msg", "error");
		}


		return mapper.writeValueAsString(modelMap);

	}
}
