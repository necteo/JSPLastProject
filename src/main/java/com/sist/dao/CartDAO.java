package com.sist.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.CartVO;

public class CartDAO {
	private static SqlSessionFactory ssf = CreateSqlSessionFactory.getSsf();
	
	/*
	 * <insert id="cartInsert" parameterType="CartVO">
	    INSERT INTO cart VALUES(cart_no_seq.nextval, #{gno}, #{id}, #{account}, 0, SYSDATE)
	  </insert>
	  
	  <update id="cartUpdate" parameterType="CartVO">
	    UPDATE cart
	    SET account = account + #{account}
	    WHERE gno = #{gno} AND id = #{id}
	  </update>
	  
	  <select id="cartCount" resultType="int" parameterType="CartVO">
	    SELECT COUNT(*)
	    FROM cart
	    WHERE gno = #{gno} AND id = #{id}
	  </select>
	 */
	public static void cartInsert(CartVO vo) {
		try {
			SqlSession session = ssf.openSession();
			int count = session.selectOne("cartCount", vo);
			if (count == 0) {
				session.insert("cartInsert", vo);
			} else {
				session.update("cartUpdate", vo);
			}
			session.commit();
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * <select id="cartMyListData" resultMap="cartMap" parameterType="string">
	    SELECT c.no, goods_poster, goods_name, goods_price, account, ok, TO_CHAR(regdate, 'YYYY-MM-DD') dbday
	    FROM cart c, goods_all g
	    WHERE c.gno = g.no
	    AND id = #{id}
	    ORDER BY c.no DESC
	  </select>
	 */
	public static List<CartVO> cartMyListData(String id) {
		List<CartVO> list = null;
		try {
			SqlSession session = ssf.openSession();
			list = session.selectList("cartMyListData", id);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/*
	 * <delete id="cartCancel" parameterType="int">
	    DELETE FROM cart
	    WHERE no = #{no}
	  </delete>
	 */
	public static void cartCancel(int no) {
		try {
			SqlSession session = ssf.openSession(true);
			session.delete("cartCancel", no);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
