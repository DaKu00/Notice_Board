package com.example.demo.dao.mybatis;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import com.example.demo.io.FileVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


@Service
public class BbsService {
	@Autowired
	private BbsDAO bd;
	
	@Autowired
	private BbsMapper bbsMapper;

// 전체 리스트 표시
	public List<BbsVO> getUserList() {
		return bbsMapper.getUserList();
	}

// 번호에 따라 한행만 출력
	public BbsVO selectByNum(int n) {
		BbsVO bvo = bbsMapper.getUserByNum(n);
		return bvo;
	}

	public BbsVO addHit(int n) {
		BbsVO bvo = bbsMapper.getUserByNum(n);
		bvo.setHit(bvo.getHit() + 1);
		bbsMapper.addHit(bvo);
		return bvo;
	}
	
	
// 부모자식 게시물, 들여쓰기
	public List<BbsVO> test() {
		List<BbsVO> list = new ArrayList<BbsVO>();

		for (BbsVO b : bbsMapper.test()) {
			if (b.getLvl() == 1) {
				list.add(b);
			}
		}

		return list;
	}

// 계층구조
	public List<BbsVO> oneDat(int n) {
		return bbsMapper.oneDat(n);
	}

	public String insertBbs(BbsVO vo) {
		if (bbsMapper.insertBbs(vo) != 0) {
			return "true";
		}
		return "false";
	}

//페이지 구현
	public PageInfo<BbsVO> getListPage(int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		PageInfo<BbsVO> pageInfo = new PageInfo<>(bd.test());
		return pageInfo;
	}
	
	public String updateG(BbsVO vo) {
		if(bbsMapper.updateG(vo) > 0) {
			return "true";
		}
		return "false";
	}
	
//로그인
	public String login_check(HttpServletRequest request) {
		String cmd = request.getParameter("cmd");
		HttpSession session = request.getSession();
		if (cmd.equals("login")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			if (pw.equals(bbsMapper.login_check(id))) {
				session.setAttribute("userid", id);
				session.setAttribute("login", true);
				request.setAttribute("pass", true);
				return "true";
			}
		}else if(cmd.equals("logout")) {
			request.setAttribute("logout", true);
			session.setAttribute("login", "false");
			session.invalidate();
			return "true";
		}
		return "false";
	}
	
	@Autowired
	private FileVO f;

	
	// 업로드
	@Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
	public boolean upload(MultipartFile[] mfiles, HttpServletRequest request, BbsVO b) {

		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/WEB-INF/upload");
		String name = null;
		long size = (long) .0;
		try {
			for (int i = 0; i < mfiles.length; i++) {
				name = mfiles[i].getOriginalFilename();
				size = mfiles[i].getSize();
				mfiles[i].transferTo(new File(savePath + "/" + name));
			}
			String msg = String.format("파일(%d)저장성공(작성자:%s)", mfiles.length, b.getWriter());
			System.out.println(msg);
			bbsMapper.addF(b);
			f.setFilename(name);
			f.setNum(b.getNum());
			f.setFilesize(size);
			bbsMapper.upfile(f);
			return true;
			
		} catch (IOException fe) {
			bbsMapper.addF(b);
			return true;
		}
		
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public FileVO Filelist_one(int n) {
		FileVO f = bbsMapper.getFileByNum(n);
		return f;
	}
	
	
}
