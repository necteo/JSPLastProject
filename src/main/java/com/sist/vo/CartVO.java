package com.sist.vo;
/*
 *  NO      NOT NULL NUMBER       
	GNO              NUMBER       
	ID               VARCHAR2(20) 
	ACCOUNT          NUMBER       
	OK               NUMBER       
	REGDATE          DATE
 */

import java.util.Date;

import lombok.Data;

@Data
public class CartVO {
	private int no, gno, account, ok;
	private String id, dbday;
	private Date regdate;
	private GoodsVO gvo = new GoodsVO();

}
