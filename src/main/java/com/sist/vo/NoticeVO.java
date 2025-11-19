package com.sist.vo;
/*
 *  NO       NOT NULL NUMBER         
	STATE    NOT NULL VARCHAR2(20)   
	NAME              VARCHAR2(51)   
	SUBJECT  NOT NULL VARCHAR2(2000) 
	CONTENT  NOT NULL CLOB           
	REGDATE           DATE           
	HIT               NUMBER         
	FILENAME          VARCHAR2(260)  
	FILESIZE          VARCHAR2(200)
	FILECOUNT          NUMBER
 */

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	private int no, hit, filecount;
	private String state, name, subject, content, filename, filesize, dbday;
	private Date regdate;

}
