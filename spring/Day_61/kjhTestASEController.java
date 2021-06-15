package com.spring.sample.web.tests.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.sample.common.bean.PagingBean;
import com.spring.sample.common.service.IPagingService;
import com.spring.sample.web.tests.service.kjhITestSEService;

@Controller
public class kjhTestASEController {

	@Autowired
	public kjhITestSEService kjhiTestSEService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value="/kjhtestSEList")
	public ModelAndView kjhtestSEList(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) {
		
		int page = 1;
		
		System.out.println(params);
		if(params.get("page")  != null ) {
			page = Integer.parseInt(params.get("page"));
		}
		
		mav.addObject("page", page);
		mav.setViewName("tests/kjhtestSEList");
		
		
		return mav;
	}
		
	@RequestMapping(value="/kjhtestSELists",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String kjhtestSELists(
			@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		//현재페이지
		int page = Integer.parseInt(params.get("page"));
		
		//총 게시글 수 
		int cnt = kjhiTestSEService.getSECnt(params);
		
		//페이징 정보취득 
		PagingBean pb= iPagingService.getPagingBean(page, cnt, 5, 3);
		
		//시작번호, 종료번호
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		//목록 취득
		List<HashMap<String, String>>list = kjhiTestSEService.getSEList(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value="/kjhtestSEAdd")
	public ModelAndView testSEAdd(ModelAndView mav) {

		mav.setViewName("tests/kjhtestSEAdd");
		
		return mav;
	}
	//작성
	@RequestMapping(value="/kjhtestSEAdds",
					method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String testSEAdds(
			@RequestParam HashMap<String, String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			int cnt = kjhiTestSEService.addSE(params);
			
			if(cnt > 0) {
				modelMap.put("msg", "success");
			} else {
				modelMap.put("msg", "failed");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("msg", "success");
		}
		
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value="/kjhtestSEDetail")
	public ModelAndView testSEDetail(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = kjhiTestSEService.getSE(params);
		
		mav.addObject("data", data);
		
		mav.setViewName("tests/kjhtestSEDetail");
		return mav;
		
	}
	
	
	@RequestMapping(value="/kjhtestSEUpdate")
	public ModelAndView testSEUpdate(
			@RequestParam HashMap<String, String> params,
			ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = kjhiTestSEService.getSE(params);
		
		System.out.println("수정:"+data);
		
		mav.addObject("data", data);
		mav.setViewName("tests/kjhtestSEUpdate");
		return mav;
		
	}
	
	
	//수정
	@RequestMapping(value="/kjhtestASEUpdates",
	method = RequestMethod.POST,
	produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String kjhtestASEUpdates(
	@RequestParam HashMap<String, String> params) throws Throwable{
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();
	
	try {
		int cnt = kjhiTestSEService.updateSE(params);
		System.out.println("수정2"+params);
		if(cnt > 0) {
		modelMap.put("msg", "success");
		} else {
		modelMap.put("msg", "failed");
		
		}
	
	} catch (Exception e) {
		e.printStackTrace();
		modelMap.put("msg", "success");
	}
	
	
	return mapper.writeValueAsString(modelMap);
	}
	
	//삭제
	@RequestMapping(value="/kjhtestSEDeletes",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
			@ResponseBody
			public String kjhtestSEDeletes(
			@RequestParam HashMap<String, String> params) throws Throwable{
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				int cnt = kjhiTestSEService.deleteSE(params);
				System.out.println("삭제"+params);
				if(cnt > 0) {
				modelMap.put("msg", "success");
				} else {
				modelMap.put("msg", "failed");
				
				}
			
			} catch (Exception e) {
				e.printStackTrace();
				modelMap.put("msg", "error");
			}
			
			
			return mapper.writeValueAsString(modelMap);
			}
}
