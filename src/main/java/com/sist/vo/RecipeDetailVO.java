package com.sist.vo;

import lombok.Data;

/*
 *  NO                    NUMBER         
	POSTER       NOT NULL VARCHAR2(500)  
	TITLE        NOT NULL VARCHAR2(1000) 
	CHEF         NOT NULL VARCHAR2(300)  
	CHEF_POSTER  NOT NULL VARCHAR2(500)  
	CHEF_PROFILE NOT NULL VARCHAR2(500)  
	INFO1        NOT NULL VARCHAR2(100)  
	INFO2        NOT NULL VARCHAR2(100)  
	INFO3        NOT NULL VARCHAR2(100)  
	CONTENT      NOT NULL CLOB           
	FOODMAKE     NOT NULL CLOB
 */
@Data
public class RecipeDetailVO {
	private int no;
	private String poster, title, chef, chef_poster, chef_profile, info1, info2, info3, content, foodmake;

}
