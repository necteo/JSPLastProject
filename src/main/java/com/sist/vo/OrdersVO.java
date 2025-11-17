package com.sist.vo;
/*
 *  NO      NOT NULL NUMBER        
	GNO              NUMBER        
	ID               VARCHAR2(20)  
	NAME    NOT NULL VARCHAR2(51)  
	POST    NOT NULL VARCHAR2(10)  
	ADDR1   NOT NULL VARCHAR2(100) 
	ADDR2            VARCHAR2(100) 
	MSG     NOT NULL CLOB          
	ACCOUNT          NUMBER        
	REGDATE          DATE
 */

import java.util.Date;

import lombok.Data;

@Data
public class OrdersVO {
	private int no, gno, account, price;
	private String id, name, post, addr1, addr2, msg, dbday;
	private Date regdate;

}
