package com.sist.vo;
/*
 *  NO                  NUMBER       
	TYPE                NUMBER       
	RNO                 NUMBER       
	ID                  VARCHAR2(20) 
	NAME       NOT NULL VARCHAR2(51) 
	SEX        NOT NULL VARCHAR2(10) 
	MSG        NOT NULL CLOB         
	GROUP_ID            NUMBER       
	GROUP_STEP          NUMBER       
	GROUP_TAB           NUMBER       
	ROOT                NUMBER       
	DEPTH               NUMBER       
	REGDATE             DATE
 */

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int no, type, rno, group_id, group_step, group_tab, root, depth;
	private String id, name, sex, msg, dbday;
	private Date regdate;

}
