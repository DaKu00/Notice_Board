package com.example.demo.dao.mybatis;

import java.sql.PreparedStatement;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.io.FileVO;
import com.example.demo.io.UserVO;

@Mapper
public interface BbsMapper {

	@Select("SELECT * FROM bbs")
	List<BbsVO> getUserList();
	
	@Select("SELECT pw FROM login WHERE id = #{id}")
	String login_check(String id);

	@Select("SELECT * FROM upfile WHERE num = #{num}")
	FileVO getFileByNum(int num);


	@Select("SELECT * FROM bbs WHERE num = #{num}")
	BbsVO getUserByNum(int num);

	@Insert("INSERT INTO bbs(title,writer,wdate,contents,hit,pnum) VALUES('댓글', #{writer}, now(), #{contents}, 0, #{pnum})")
	@Options(useGeneratedKeys = true, keyProperty = "num")
	int insertBbs(BbsVO bbs);

	@Select("WITH RECURSIVE cte AS (\r\n"
			+ "  SELECT     num,                          -- # Non-Recursive query 가 필수로 있어야 함\r\n"
			+ "             CAST(title AS CHAR(100)) title, -- 이름 왼쪽에 들여쓰기 공백을 추가하기 위함\r\n" + "             pnum,\r\n"
			+ "             wdate,\r\n" + "             writer,\r\n"
			+ "             1 AS lvl,                       -- 최상위 부모 행으로부터의 차수(1부터 시작)\r\n"
			+ "             @rn:=(@rn+1) AS topid            -- 최상위 부모 행들의 행번호(1부터 증가함)\r\n" + "             \r\n"
			+ "  FROM        (\r\n" + "            SELECT * FROM bbs ORDER BY wdate DESC -- 최신글 순으로 부모 행 정렬\r\n"
			+ "          )t1, (SELECT @rn:=0)t2          -- 행번호로 사용할 변수(@rn) 선언\r\n"
			+ "  WHERE      pnum = 0                         -- 최상위 행만을 선택함\r\n"
			+ "  UNION                                      -- 아래는 바깥에 선언된 cte를 참조하는 커리(필수)\r\n"
			+ "  SELECT     e.num,\r\n"
			+ "             CONCAT(REPEAT('', p.lvl*2), e.title) title,   -- 차수를 이용한 들여쓰기\r\n"
			+ "             e.pnum,\r\n" + "             e.wdate,\r\n" + "             e.writer,\r\n"
			+ "             p.lvl+1 AS lvl,                 -- 부모글의 차수에 1을 증가하여 자식 글의 차수 설정\r\n"
			+ "             p.topid AS pnum                  -- 자식 글에는 최상위 부모 글의 번호를 설정\r\n" + "  FROM       bbs e\r\n"
			+ "  INNER JOIN cte p\r\n" + "          ON p.num = e.pnum\r\n" + ")\r\n"
			+ "SELECT num, title, pnum as mgr, writer, wdate, lvl, topid FROM cte where pnum = 0 ORDER BY topid, lvl, wdate DESC")
	List<BbsVO> test();

	@Select("WITH RECURSIVE cte AS (\r\n"
			+ "  SELECT     num,                          -- # Non-Recursive query 가 필수로 있어야 함\r\n"
			+ "             CAST(title AS CHAR(100)) title, -- 이름 왼쪽에 들여쓰기 공백을 추가하기 위함\r\n" + "             pnum,\r\n"
			+ "             writer,\r\n" + "				contents,\r\n" + "             wdate,\r\n"
			+ "				CAST(LPAD(num,6,0) AS CHAR(100)) AS path,"
			+ "             1 AS lvl,                       -- 최상위 부모 행으로부터의 차수(1부터 시작)\r\n"
			+ "             @rn:=(@rn+1) AS topid            -- 최상위 부모 행들의 행번호(1부터 증가함)\r\n" + "  FROM        (\r\n"
			+ "            SELECT * FROM bbs ORDER BY wdate DESC -- 최신글 순으로 부모 행 정렬\r\n"
			+ "          )t1, (SELECT @rn:=0)t2          -- 행번호로 사용할 변수(@rn) 선언\r\n"
			+ "  WHERE      pnum = 0 AND num = #{num}                        -- 최상위 행만을 선택함\r\n"
			+ "  UNION                                      -- 아래는 바깥에 선언된 cte를 참조하는 커리(필수)\r\n"
			+ "  SELECT     e.num,\r\n"
			+ "             CONCAT(REPEAT('　', p.lvl*2), e.title) title,   -- 차수를 이용한 들여쓰기\r\n"
			+ "             e.pnum,\r\n" + "             e.writer,\r\n" + "				e.contents,\r\n"
			+ "             e.wdate,\r\n" + "				CONCAT(p.path, '/', LPAD(e.num,6,0)) AS path,"
			+ "             p.lvl+1 AS lvl,                 -- 부모글의 차수에 1을 증가하여 자식 글의 차수 설정\r\n"
			+ "             p.topid AS pnum                  -- 자식 글에는 최상위 부모 글의 번호를 설정\r\n" + "  FROM       bbs e\r\n"
			+ "  INNER JOIN cte p\r\n" + "          ON p.num = e.pnum\r\n" + ")\r\n"
			+ "SELECT num, title, writer, contents, pnum as mgr, wdate, lvl-2 AS lvl, topid FROM cte WHERE lvl > 1 ORDER BY topid, topid, path")
	List<BbsVO> oneDat(int num);

	@Update("UPDATE bbs SET contents=#{contents} WHERE num=#{num}")
	int updateG(BbsVO u);

	@Update("UPDATE bbs SET hit=#{hit} WHERE num=#{num}")
	int addHit(BbsVO u);
	
	@Insert("INSERT INTO bbs(title,writer,wdate,contents,hit,pnum) VALUES(#{title}, #{writer}, now(), #{contents}, 0, 0)")
	@Options(useGeneratedKeys = true, keyProperty = "num")
	int addF(BbsVO b);

	
	@Insert("INSERT INTO upfile (fileNum, num, filename, filesize) VALUES(null, #{num}, #{filename}, #{filesize})")
	int upfile(FileVO f);
	
}