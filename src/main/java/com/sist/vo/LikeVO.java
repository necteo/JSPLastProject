package com.sist.vo;

import lombok.Data;

/*
 *  LNO  NOT NULL NUMBER       
	TYPE          NUMBER       
	RNO           NUMBER       
	ID            VARCHAR2(20)
 */
@Data
public class LikeVO {
	private int lno, type, rno;
	private String id;

}
