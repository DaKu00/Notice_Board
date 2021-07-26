package com.example.demo.dao.mybatis;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.mapper.UserMapper;
import com.example.demo.io.FileVO;
import com.example.demo.io.UserVO;

@Repository
public class BbsDAO {
	@Autowired
	private BbsMapper bbsMapper;

	public List<BbsVO> getUserList() {
		return bbsMapper.getUserList();
	}

	public BbsVO selectByNum(int num) {
		return bbsMapper.getUserByNum(num);
	}
	
	public int addF(BbsVO b) {
		return bbsMapper.addF(b);
	}
	
	public List<BbsVO> test() {
		return bbsMapper.test();
	}
	
	public int insertBbs(BbsVO vo) {
		return bbsMapper.insertBbs(vo);
	}
	
	
	public List<BbsVO> oneDat(int n) {
		return bbsMapper.oneDat(n);
	}
	
	public int updateG(BbsVO vo) {
		return bbsMapper.updateG(vo);
	}
	
//
//   public int insert(UserVO userVO) {
//      return userMapper.insertUser(userVO);
//   }
//
//   public int addAndGetKey(UserVO userVO) {
//      return userMapper.addAndGetKey(userVO);
//   }
//
//   public int update(UserVO userVO) {
//      return userMapper.updateUser(userVO);
//   }
//
//   public int delete(int num) {
//      return userMapper.deleteUser(num);
//   }
}