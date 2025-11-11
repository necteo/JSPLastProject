package com.sist.vo;
/*
 *  JNO     NOT NULL NUMBER       
	TYPE             NUMBER       
	RNO              NUMBER       
	ID               VARCHAR2(20) 
	REGDATE          DATE
 */

import java.util.Date;

import lombok.Data;
@Data
public class JjimVO {
	private int jno, type, rno;
	private String id, dbday;
	private Date regdate;
	private FoodVO fvo = new FoodVO();
	private GoodsVO gvo = new GoodsVO();
	private RecipeVO rvo = new  RecipeVO();

}
