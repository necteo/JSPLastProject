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
	
	/*
	 * <sql id="where-fno">
		  WHERE fno = #{fno}
		</sql>
		<update id="foodHitIncrement" parameterType="int">
		  UPDATE menupan_food
		  SET hit = hit + 1
		  WHERE fno = #{fno}
		</update>
		<select id="foodDetailData">
		  SELECT * FROM menupan_food
		  <include refid="where-fno"></include>
		</select>
	 */
	// 상세보기
	public static FoodVO foodDetailData(int fno) {
		SqlSession session = null;
		FoodVO vo = null;
		try {
			session = ssf.openSession();
			session.update("foodHitIncrement", fno);
			/// insert / update / delete => commit
			session.commit();
			vo = session.selectOne("foodDetailData", fno);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return vo;
	}
	
	// mapper.xml => 실행(X) => SQL문장 저장
	// 분산 => Front Back DBA
	public static FoodVO foodCookieData(int fno) {
		SqlSession session = ssf.openSession();
		FoodVO vo = session.selectOne("foodDetailData", fno);
		session.close();
		return vo;
	}

	/*
	 * <select id="foodFindData" resultType="FoodVO" parameterType="hashmap">
		  <include refid="select-food"/>, num
		  FROM (<include refid="select-food"/>, rownum num
		    	FROM (<include refid="select-food"/> 
		    	  	  FROM menupan_food
		    	  	  WHERE ${column} LIKE '%' || #{ss} || '%' 
		    	  	  AND 
		    	  	  <trim prefix="(" suffix=")" prefixOverrides="OR|AND">
					    <foreach collection="fdArr" item="fd">
					      <trim prefix="OR">
					        <choose>
					          <when test="fd == 'A'.toString()">
					            type LIKE '%한식%'
					          </when>
					          <when test="fd == 'B'.toString()">
					            type LIKE '%일식%'
					          </when>
					          <when test="fd == 'C'.toString()">
					            type LIKE '%중식%'
					          </when>
					          <when test="fd == 'D'.toString()">
					            type LIKE '%양식%'
					          </when>
					          <when test="fd == 'E'.toString()">
					            type LIKE '%분식%'
					          </when>
					        </choose>
					      </trim>
					    </foreach>
					  </trim>
		    	  	  ORDER BY fno
		  ))
		  WHERE num BETWEEN #{start} AND #{end}
		</select>
		<select id="foodFindCount" parameterType="hashmap" resultType="int">
		  SELECT COUNT(*) 
		  FROM menupan_food
		  WHERE ${column} LIKE '%' || #{ss} || '%' 
		  AND 
	  	  <trim prefix="(" suffix=")" prefixOverrides="OR|AND">
		    <foreach collection="fdArr" item="fd">
		      <trim prefix="OR">
		        <choose>
		          <when test="fd == 'A'.toString()">
		            type LIKE '%한식%'
		          </when>
		          <when test="fd == 'B'.toString()">
		            type LIKE '%일식%'
		          </when>
		          <when test="fd == 'C'.toString()">
		            type LIKE '%중식%'
		          </when>
		          <when test="fd == 'D'.toString()">
		            type LIKE '%양식%'
		          </when>
		          <when test="fd == 'E'.toString()">
		            type LIKE '%분식%'
		          </when>
		        </choose>
		      </trim>
		    </foreach>
		  </trim>
		</select>
	 */
	public static List<FoodVO> foodFindData(Map<String, Object> map) {
		List<FoodVO> list = null;
		try {
			SqlSession session = ssf.openSession();
			list = session.selectList("foodFindData", map);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public static int foodFindCount(Map<String, Object> map) {
		int count = 0;
		try {
			SqlSession session = ssf.openSession();
			count = session.selectOne("foodFindCount", map);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
}
