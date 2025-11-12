package com.sist.vo;
/*
 *  NO      NOT NULL NUMBER       
	ID               VARCHAR2(20) 
	FNO              NUMBER       
	RDAY    NOT NULL VARCHAR2(20) 
	TIME    NOT NULL VARCHAR2(30) 
	INWON   NOT NULL VARCHAR2(20) 
	OK               NUMBER       
	REGDATE          DATE
 */

import java.util.Date;

import lombok.Data;

@Data
public class ReserveVO {
	private int no, fno, ok;
	private String id, rday, time, inwon, dbday;
	private Date regdate;
	private FoodVO vo = new FoodVO();

}
