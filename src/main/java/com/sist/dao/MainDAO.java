package com.sist.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.ChefVO;
import com.sist.vo.FoodVO;
import com.sist.vo.RecipeVO;

public class MainDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	/*
	 *   <select id="mainTopData" resultType="FoodVO">
		    SELECT * 
		    FROM (SELECT * FROM menupan_food 
		    	  ORDER BY DBMS_RANDOM.VALUES)
		    WHERE ROWNUM = 1
		  </select>
	 */
	public static FoodVO mainTopData() {
		SqlSession session = ssf.openSession();
		FoodVO vo = session.selectOne("mainTopData");
		session.close();
		return vo;
	}
	
	/*
	 *    <select id="mainHitTop4" resultType="FoodVO">
		    SELECT fno, name, theme, hit, likecount, replycount, type, address
		    FROM (SELECT fno, name, theme, hit, likecount, replycount, type, address
		    	  FROM menupan_food
		    	  ORDER BY hit DESC)
		    WHERE rownum &lt;= 4
		  </select>
		  
		  <select id="mainLikeTop4" resultType="FoodVO">
		    SELECT fno, name, theme, hit, likecount, replycount, type, address, 
		    FROM (SELECT fno, name, theme, hit, likecount, replycount, type, address
		    	  FROM menupan_food
		    	  ORDER BY likecount DESC)
		    WHERE rownum &lt;= 4
		  </select>
	 */
	public static List<FoodVO> mainHitTop4() {
		SqlSession session = ssf.openSession();
		List<FoodVO> list = session.selectList("mainHitTop4");
		session.close();
		return list;
	}
	
	public static List<FoodVO> mainLikeTop4() {
		SqlSession session = ssf.openSession();
		List<FoodVO> list = session.selectList("mainLikeTop4");
		session.close();
		return list;
	}
	// Cookie
	// 뉴스 / 실시간 동영상(레시피)
	
	/*
	 * <select id="mainTopChefData" resultType="ChefVO">
	    SELECT *
	    FROM (SELECT * FROM chef 
	    	  ORDER BY DBMS_RANDOM.VALUE)
	    WHERE ROWNUM = 1
	  </select>
	  
	  <select id="mainRecipeTop5" resultType="RecipeVO">
	    SELECT no, poster, title
	    FROM (SELECT fno, poster, title
	    	  FROM recipe
	    	  ORDER BY no DESC)
	    WHERE rownum &lt;= 5
	  </select>
	 */
	public static ChefVO mainTopChefData() {
		SqlSession session = ssf.openSession();
		ChefVO vo = session.selectOne("mainTopChefData");
		session.close();
		return vo;
	}
	
	public static List<RecipeVO> mainRecipeTop5() {
		SqlSession session = ssf.openSession();
		List<RecipeVO> list = session.selectList("mainRecipeTop5");
		session.close();
		return list;
	}

}
