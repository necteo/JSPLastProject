package com.sist.vo;
/*
 *  NO         NOT NULL NUMBER       
	BNO                 NUMBER       
	ID                  VARCHAR2(20) 
	NAME       NOT NULL VARCHAR2(51) 
	MSG        NOT NULL CLOB         
	REGDATE             DATE         
	GROUP_ID            NUMBER       
	GROUP_STEP          NUMBER       
	GROUP_TAP           NUMBER       
	ROOT                NUMBER       
	DEPTH               NUMBER
 */

import java.util.Date;

import lombok.Data;

@Data
public class BoardReplyVO {
	private int no, bno, group_id, group_step, group_tab, depth, root;
	private String id, name, msg, dbday;
	private Date regdate;

}
