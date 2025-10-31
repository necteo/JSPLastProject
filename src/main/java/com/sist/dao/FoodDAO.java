package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.FoodVO;

// 오라클만 연동
public class FoodDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}

	/*
	 * <select id="foodListData" resultType="FoodVO" parameterType="hashmap">
			SELECT fno, name, type, address, poster, likecount, replycount, num
			FROM (SELECT fno, name, type, address, poster, likecount, replycount, rownum num
				  FROM (SELECT fno, name, type, address, poster, likecount, replycount
				  		FROM menupan_food ORDER BY fno))
			WHERE num BETWEEN #{start} AND #{end}	
		</select>
		
		<select id="foodTotalPage" resultType="int">
			SELECT CEIL(COUNT(*) / 20) FROM menupan_food
		</select>
	 */
	// 목록 읽기
	public static List<FoodVO> foodListData(Map<String, Integer> map) {
		SqlSession session = null;
		List<FoodVO> list = null;
		try {
			session = ssf.openSession();
			list = session.selectList("foodListData", map);	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}
	
	// 총페이지
	public static int foodTotalPage() {
		SqlSession session = null;
		int total = 0;
		try {
			session = ssf.openSession();
			total = session.selectOne("foodTotalPage");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return total;
	}
	
}
