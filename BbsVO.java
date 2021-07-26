package com.example.demo.dao.mybatis;

public class BbsVO {
	private int num;
	private String title;
	private String writer;
	private String wdate;
	private String contents;
	private int hit;
	private int mgr;
	private int lvl;
	private int pnum;
	
	public BbsVO() {
		setNum(num);
		setTitle(title);
		setWriter(writer);
		setContents(contents);
		setHit(hit);
		setPnum(pnum);
	}
	@Override
	public String toString() {
		String p = String.format("%d\t%s\t%s\t%s\t%s\t%d\t%d<br>", num, title, writer, wdate, contents, hit, pnum);
		return p;
	}
	
	public int getPnum() {
		return pnum;
	}

	public void setPnum(int pnum) {
		this.pnum = pnum;
	}

	public int getLvl() {
		return lvl;
	}

	public void setLvl(int lvl) {
		this.lvl = lvl;
	}
	
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public int getMgr() {
		return mgr;
	}

	public void setMgr(int mgr) {
		this.mgr = mgr;
	}
}
