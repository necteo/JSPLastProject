package com.sist.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;

public class LIkeDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	/*
	 * <insert id="likeOn" parameterType="hashmap">
	    INSERT INTO all_like
	    VALUES(al_lno_seq.nextval, #{type}, #{rno}, #{id})
	  </insert>
	  
	  <update id="likeCountIncrement" parameterType="hashmap">
	    UPDATE ${table}
	    SET likecount = likecount + 1
	    WHERE ${checks} = #{rno}
	  </update>
	 */
	public static int likeOn(Map<String, Object> map) {
		int count = 0;
		SqlSession session = null;
		try {
			session = ssf.openSession();
			session.insert("likeOn", map);
			session.update("likeCountIncrement", map);
			session.commit();
			count = session.selectOne("likeCount", map);
		} catch (Exception e) {
			session.rollback();
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return count;
	}
	
	/*
	  <delete id="likeOff" parameterType="hashmap">
	    DELETE FROM all_like
	    WHERE rno = #{rno} AND #{id] = #{id} AND type = #{type}
	  </delete>
	  
	  <update id="likeCountDecrement" parameterType="hashmap">
	    UPDATE ${table}
	    SET likecount = likecount - 1
	    WHERE ${checks} = #{rno}
	  </update>
	 */
	public static int likeOff(Map<String, Object> map) {
		int count = 0;
		SqlSession session = null;
		try {
			session = ssf.openSession();
			session.delete("likeOff", map);
			session.update("likeCountDecrement", map);
			session.commit();
			count = session.selectOne("likeCount", map);
		} catch (Exception e) {
			session.rollback();
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return count;
	}
	
	/*
	  <select id="likeCount" parameterType="hashmap" resultType="int">
	    SELECT NVL(likecount, 0) likecount
	    FROM ${table}
	    WHERE ${checks} = #{rno}
	  </select>
	  
	  <select id="likeCheck" resultType="int" parameterType="hashmap">
	    SELECT COUNT(*) FROM all_like
	    WHERE rno = #{rno} AND type = #{type} AND id = #{id}
	  </select>
	 */
	public static int likeCheck(Map<String, Object> map) {
		int count = 0;
		try {
			SqlSession session = ssf.openSession();
			count = session.selectOne("likeCheck", map);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
}
