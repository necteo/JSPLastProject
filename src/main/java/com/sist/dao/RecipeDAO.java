package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.ChefVO;
import com.sist.vo.RecipeVO;

public class RecipeDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	// 쉐프 목록
	/*
	 * <select id="chefListData" resultType="ChefVO" parameterType="hashmap">
	    SELECT no, chef, poster, mem_cont1, mem_cont2, mem_cont7, mem-cont3, num
	    FROM (SELECT no, chef, poster, mem_cont1, mem_cont2, mem_cont7, mem-cont3, rownum num
	    	  FROM (SELECT no, chef, poster, mem_cont1, mem_cont2, mem_cont7, mem-cont3
	    	  		FROM chef ORDER BY no))
	    WHERE num BETWEEN #{start} AND #{end}
	  </select>
	  <select id="chefTotalPage" resultType="int">
	  	SELECT CEIL(COUNT(*) / 30) FROM chef
	  </select>
	 */
	public static List<ChefVO> chefListData(Map<String, Integer> map) {
		SqlSession session = null;
		List<ChefVO> list = null;
		try {
			session = ssf.openSession();
			list = session.selectList("chefListData", map);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public static int chefTotalPage() {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("chefTotalPage");
		session.close();
		return total;
	}
	
	// 레시피 목록
	public static List<RecipeVO> recipeListData(Map<String, Integer> map) {
		SqlSession session = null;
		List<RecipeVO> list = null;
		try {
			session = ssf.openSession();
			list = session.selectList("recipeListData", map);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public static int recipeTotalPage() {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("recipeTotalPage");
		session.close();
		return total;
	}
	
	/*
	 * <select id="recipeCount" resultType="int">
	    SELECT COUNT(*) FROM recipe
	  </select>
	 */
	public static int recipeCount() {
		SqlSession session = ssf.openSession();
		int count = session.selectOne("recipeCount");
		session.close();
		return count;
	}
	
	// 쉐프 상세보기
	// 레시피 상세보기
	// 레시피 등록 ****
	// 레시피 검색

}
