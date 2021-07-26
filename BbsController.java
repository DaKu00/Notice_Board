package com.example.demo.dao.mybatis;

import java.io.IOException;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.mybatis.UserDao;
import com.example.demo.io.FileVO;
import com.example.demo.io.UserVO;
import com.github.pagehelper.PageInfo;

@Controller
public class BbsController {

	@Autowired
	private BbsService bs;

	@GetMapping("/bbs/num/{n}")
	public String getUserByNum(@PathVariable int n, Model m) {
		m.addAttribute("one", bs.addHit(n));
		m.addAttribute("dat", bs.oneDat(n));
		m.addAttribute("file", bs.Filelist_one(n));
		return "bbsOne";
	}

	@GetMapping("/bbs/img")
	public @ResponseBody String test() {
		return "<img src='/image/alien.jpg'>";
	}

	@PostMapping("/bbs/download")
	public ResponseEntity<Resource> download(HttpServletRequest request, @ModelAttribute("FileVo") FileVO fv) {
		Resource resource = resourceLoader.getResource("WEB-INF/upload/" + fv.getFilename());
		String contentType = null;
		try {
			contentType = request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());
		} catch (IOException e) {
			e.printStackTrace();
		}

		if (contentType == null) {
			contentType = "application/octet-stream";
		}
		return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
				.body(resource);
	}

	@GetMapping("/bbs/page")
	public String list(Model m) {
		PageInfo<BbsVO> pageInfo = bs.getListPage(1, 3);
		m.addAttribute("pageInfo", pageInfo);
		return "bbslist";
	}
	
	@GetMapping("/bbs/datadd")
	public @ResponseBody String test(@ModelAttribute("BbsVO") BbsVO u) {
		return bs.insertBbs(u);
	}
	
	@GetMapping("/bbs/page/{pn}")
	public String list_page(@PathVariable int pn, Model m) {
		if(pn == 0) {
			pn = 1;
		}
		PageInfo<BbsVO> pageInfo = bs.getListPage(pn, 3);
		m.addAttribute("pageInfo", pageInfo);
		return "bbslist";
	}

	
	@GetMapping("/bbs/login")
	public String login() {
		return "login";
	}
	
	@PostMapping("/bbs/login_check")
	public @ResponseBody String login(HttpServletRequest request) {
		String url = bs.login_check(request);
		return url;
	}
	
	@PostMapping("/bbs/update_G")
	public @ResponseBody String updateG(@ModelAttribute("BbsVO") BbsVO u) {
		return bs.updateG(u);
	}
	
	@GetMapping("/bbs/creatG")
	public String creatG() {
		return "bbsCreatG";
	}
	
	
	@Autowired
	ResourceLoader resourceLoader;

	@PostMapping("/bbs/upload")
	public String upload(@RequestParam("files") MultipartFile[] mfiles, HttpServletRequest request,
			@ModelAttribute("bbsvo") BbsVO fu) {
		if(bs.upload(mfiles, request, fu)) {
			return "redirect:/bbs/page";
		}
		return "bbslist";
	}
}