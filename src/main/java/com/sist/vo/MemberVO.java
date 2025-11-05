package com.sist.vo;

import java.util.Date;

import lombok.Data;

/*
 *  ID       NOT NULL VARCHAR2(20)  
	PWD      NOT NULL VARCHAR2(10)  
	NAME     NOT NULL VARCHAR2(51)  
	SEX               VARCHAR2(6)   
	BIRTHDAY NOT NULL VARCHAR2(20)  
	EMAIL             VARCHAR2(100) 
	POST     NOT NULL VARCHAR2(10)  
	ADDR1    NOT NULL VARCHAR2(200) 
	ADDR2             VARCHAR2(200) 
	PHONE             VARCHAR2(20)  
	CONTENT           CLOB          
	ADMIN             CHAR(1)       
	REGDATE           DATE
 */
@Data
public class MemberVO {
	private String id, pwd, name, sex, birthday, email, post, addr1, addr2, phone, content, admin, dbday;
	private Date regdate;

}
