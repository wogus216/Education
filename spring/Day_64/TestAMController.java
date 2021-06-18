package com.spring.sample.web.testa.controller;

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
import com.spring.sample.util.Utils;
import com.spring.sample.web.test.service.ITestLService;
import com.spring.sample.web.test.service.ITestMService;

@Controller
public class TestAMController {

	@Autowired
	public ITestMService iTestMService;
	
	@Autowired
	public ITestLService iTestLService;
	
	@Autowired
	public IPagingService iPagingService;
	
	
	
	@RequestMapping(value="/testAMLogin")
	public ModelAndView testALogin(ModelAndView mav) {

		mav.setViewName("testa/testAMLogin");

		return mav;
	}
	
	
	@RequestMapping(value="/testAMLogins",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
		@ResponseBody // Spring에 view임을 제시, 오늘의 제일 중요한점 바로 웹으로 넘긴다. jsp 같은 역활을 한다.
		public String testAMLogins(
			HttpSession session,
			@RequestParam HashMap<String, String> params) throws Throwable{
		// ObjectMapper : 객체를 문자열로 전환 - Jackson 라이브러리
		ObjectMapper mapper = new ObjectMapper();
		//model은 데이터를 담고있는 것
		// 데이터 보관용 map
		// 모든 형태를 받기위해서 벨류값 형태 Object
		Map<String, Object> modelMap = new HashMap<String, Object>();

		//mPw의 값을 암호화 후 mPw로 넣겠다.
		params.put("mPw", Utils.encryptAES128(params.get("mPw")));
		
		System.out.println("비밀번호:"+ Utils.decryptAES128(params.get("mPw")));
		
		HashMap<String, String> data = iTestLService.getM(params);
		System.out.println("data:"+data);
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
	
	
	 @RequestMapping(value="/testAMList")
	 public ModelAndView testAMList(
			 @RequestParam HashMap<String, String> params,
			 ModelAndView mav) {

		 int page = 1;
		 if(params.get("page") != null) {
			 page = Integer.parseInt(params.get("page"));
		 }

		 System.out.println("목록"+page);
		 mav.addObject("page", page);
		 mav.setViewName("testa/testAMList");

		 return mav;

	 }
	 
	 

		@RequestMapping(value="/testAMLists",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody
		public String testAMLists(
				@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
	
		// 현재 페이지
		int page = Integer.parseInt(params.get("page"));
	
	
		// 총 게시글 수 
		int cnt = iTestMService.getMCnt(params);
	
		// 페이징 정보 취득
		PagingBean pb= iPagingService.getPagingBean(page, cnt); 
	
		//글번호 P 없으면 글번호
		//게시글 시작번호, 종료번호 할당
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
	
		// 목록 취득
		List<HashMap<String, String>>list= iTestMService.getMList(params);
		System.out.println("목록"+list);
		modelMap.put("list", list);
		modelMap.put("pb", pb);
	
		return mapper.writeValueAsString(modelMap);
	}
		
		@RequestMapping(value="/testAMLogout")
		public ModelAndView testALogout(HttpSession session,
				ModelAndView mav) {
			session.invalidate();

			mav.setViewName("redirect:testAMLogin");
			return mav;
		}
		
		
		@RequestMapping(value ="/testAMWrite")
		public ModelAndView testABWrite(ModelAndView mav) {

			mav.setViewName("testa/testAMWrite");

			return mav;

		}

		@RequestMapping(value="/testAMWrites",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody 
		public String testAMWrites(
				@RequestParam HashMap<String, String> params) throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();

			//mPw의 값을 암호화 후 mPw로 넣겠다.
			params.put("mPw", Utils.encryptAES128(params.get("mPw")));
			
			try {
				int cnt = iTestMService.addM(params);

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
		
		@RequestMapping(value="/testAM")
		public ModelAndView testAM(
				@RequestParam HashMap<String, String> params,
				ModelAndView mav) throws Throwable {
				
			HashMap<String, String> data = iTestMService.getM(params);
			
			mav.addObject("data", data);
			
			mav.setViewName("testa/testAM");
			
			return mav;
			
		}
		//수정	
		@RequestMapping(value="/testAMUpdate")
		public ModelAndView testAMUpdate(
				@RequestParam HashMap<String, String> params,
				ModelAndView mav) throws Throwable{
			
			HashMap<String, String> data = iTestMService.getM(params);
			
			mav.addObject("data", data);
			System.out.println("data:"+data);
			
			mav.setViewName("testa/testAMUpdate");
			
			return mav;
		}
		
		@RequestMapping(value="/testAMUpdates",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
		@ResponseBody 
		public String testAMUpdates(
				@RequestParam HashMap<String, String> params) throws Throwable {
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			//mPw의 값을 암호화 후 mPw로 넣겠다.
			params.put("mPw", Utils.encryptAES128(params.get("mPw")));
			
			
			try {
				int cnt = iTestMService.updateM(params);
				
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
		
		
	@RequestMapping(value="/testAMDeletes",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String testAMDeletes(
			@RequestParam HashMap<String, String> params) throws Throwable {
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	try {
		int cnt = iTestMService.deleteM(params);
		
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