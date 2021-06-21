package com.gd.test.web.testa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gd.test.common.bean.PagingBean;
import com.gd.test.common.service.IPagingService;
import com.gd.test.util.Utils;
import com.gd.test.web.test.service.ITestLService;
import com.gd.test.web.test.service.ITestService;

@Controller
public class TestAController {
	@Autowired
	public ITestLService iTestLService;
	
	@Autowired
	public ITestService iTestService;
	
	@Autowired
	public IPagingService iPagingService;
	

	@RequestMapping(value="/testALogin")
	public ModelAndView testALogin(HttpSession session, ModelAndView mav) {
		if(session.getAttribute("sMNo") != null) { // 로그인 된 상태
			mav.setViewName("redirect:testABList");
		} else {
			mav.setViewName("testa/testALogin");
		}
		
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
		
		//mPw의 값을 암호화 후 mPw로 넣겠다.
		params.put("mPw", Utils.encryptAES128(params.get("mPw")));
		
		System.out.println("비밀번호:"+ Utils.decryptAES128(params.get("mPw")));
		
		
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
	
	@RequestMapping(value="/testABLists",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testABLists(
			@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		// 현재 페이지
		int page = Integer.parseInt(params.get("page"));
	 
				
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
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value="/testALogout")
	public ModelAndView testALogout(HttpSession session,
			ModelAndView mav) {
		session.invalidate();
		
		mav.setViewName("redirect:testALogin");
		return mav;
	}
	
	@RequestMapping(value ="/testABWrite")
	public ModelAndView testABWrite(ModelAndView mav) {
	
		mav.setViewName("testa/testABWrite");
			
		return mav;
		
	}
	
	@RequestMapping(value="/testABWrites",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String testABWrites(
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			int cnt = iTestService.addB(params);
			
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
	
	//상세보기
	@RequestMapping(value="/testAB")
	public ModelAndView testAB(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		
		HashMap<String, String> data = iTestService.getB(params);
		
		mav.addObject("data", data);
		
		mav.setViewName("testa/testAB");
		
		return mav;
		
		
	}
	
	@RequestMapping(value="/testABUpdate")
	public ModelAndView testABUpdate(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable{
		
		HashMap<String, String> data = iTestService.getB(params);
		
		mav.addObject("data", data);
		
		mav.setViewName("testa/testABUpdate");
		
		return mav;
		
		
	}
	
	
	@RequestMapping(value="/testABUpdates",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String testABUpdates(
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			int cnt = iTestService.updateB(params);
			
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
	
	@RequestMapping(value="/testABDeletes",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody 
	public String testABDeletes(
			@RequestParam HashMap<String, String> params) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			int cnt = iTestService.deleteB(params);
			
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