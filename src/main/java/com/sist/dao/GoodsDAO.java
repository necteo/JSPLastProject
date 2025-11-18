package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.GoodsVO;
import com.sist.vo.OrdersVO;

public class GoodsDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	/*
	 * <select id="goodsListData" resultType="GoodsVO" parameterType="hashmap">
	    SELECT no, goods_name, goods_sub, goods_price, goods_discount, goods_poster, hit, num
	    FROM (SELECT no, goods_name, goods_sub, goods_price, goods_discount, goods_poster, hit, rownum num
	    	  FROM (SELECT no, goods_name, goods_sub, goods_price, goods_discount, goods_poster, hit)
	    	  		FROM ${goods} ORDER BY no)
	    WHERE num BETWEEN #{start} AND #{end}
	  </select>
	  
	  <select id="goodsTotalPage" resultType="int" parameterType="hashmap">
	     SELECT CEIL(COUNT(*) / 12)
	     FROM ${goods}
	  </select>
	 */
	public static List<GoodsVO> goodsListData(Map<String, Object> map) {
		SqlSession session = ssf.openSession();
		List<GoodsVO> list = session.selectList("goodsListData", map);
		session.close();
		return list;
	}
	
	public static int goodsTotalPage(Map<String, Object> map) {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("goodsTotalPage", map);
		session.close();
		return total;
	}
	
	/*
	 * <update id="goodsHitIncrement" parameterType="hashmap">
	  	UPDATE ${goods} 
	  	SET hit = hit + 1
	  	WHERE no = #{no}
	  </update>
	  
	  <select id="goodsDetailData" resultType="GoodsVO" parameterType="hashmap">
	  	SELECT * FROM ${goods}
	  	WHERE no = #{no}
	  </select>
	 */
	public static GoodsVO goodsDetailData(Map<String, Object> map) {
		SqlSession session = ssf.openSession();
		session.update("goodsHitIncrement", map);
		session.commit();
		GoodsVO vo = session.selectOne("goodsDetailData", map);
		session.close();
		return vo;
	}
	
	public static GoodsVO goodsCookieData(Map<String, String> map) {
		SqlSession session = ssf.openSession();
		GoodsVO vo = session.selectOne("goodsDetailData", map);
		session.close();
		return vo;
	}
	
	public static void orderInsert(OrdersVO vo) {
		try {
			SqlSession session = ssf.openSession(true);
			session.insert("orderInsert", vo);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * <select id="orderListData" parameterType="string" resultMap="orderMap">
	    SELECT o.no, o.gno, goods_poster, goods_name, goods_price, account, TO_CHAR(regdate, 'YYYY-MM-DD') dbday
	    FROM orders o, goods_all g
	    WHERE o.gno = g.no
	    AND id = #{id}
	  </select>
	 */
	public static List<OrdersVO> orderListData(String id) {
		List<OrdersVO> list = null;
		try {
			SqlSession session = ssf.openSession();
			list = session.selectList("orderListData", id);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/*
	 * <select id="orderDetailData" parameterType="int" resultMap="orderMap">
	    SELECT o.no, o.gno, goods_poster, goods_name, goods_price, account, TO_CHAR(regdate, 'YYYY-MM-DD') dbday,
	    	   name, post, addr1, addr2, msg
	    FROM orders o, goods_all g
	    WHERE o.gno = g.no
	    AND o.no = #{no}
	  </select>
	 */
	public static OrdersVO orderDetailData(int no) {
		OrdersVO vo = null;
		try {
			SqlSession session = ssf.openSession();
			vo = session.selectOne("orderDetailData", no);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

}
