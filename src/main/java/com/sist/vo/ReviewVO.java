package com.sist.vo;
/*
 *  NO      NOT NULL NUMBER         
	CNO              NUMBER         
	TYPE    NOT NULL NUMBER         
	ID               VARCHAR2(20)   
	NAME    NOT NULL VARCHAR2(51)   
	MSG     NOT NULL VARCHAR2(4000) 
	REGDATE          DATE
 */

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	private int no, cno, type;
	private String id, name, msg, dbday;
	private Date regdate;

}
