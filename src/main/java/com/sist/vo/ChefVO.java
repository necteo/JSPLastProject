package com.sist.vo;

import lombok.Data;

/*
 * NO        NOT NULL NUMBER        
POSTER    NOT NULL VARCHAR2(260) 
CHEF      NOT NULL VARCHAR2(200) 
MEM_CONT1          VARCHAR2(100) 
MEM_CONT3          VARCHAR2(100) 
MEM_CONT7          VARCHAR2(100) 
MEM_CONT2          VARCHAR2(100)
 */
@Data
public class ChefVO {
	private int no;
	private String poster, chef, mem_cont1, mem_cont3, mem_cont7, mem_cont2;

}
