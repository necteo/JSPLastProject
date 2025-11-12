package com.sist.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.FoodVO;

public class ReserveDAO {
	private static SqlSessionFactory ssf = CreateSqlSessionFactory.getSsf();

	/*
	 * <select id="reserveFoodListData" resultType="FoodVO" parameterType="string">
	    SELECT fno, name, poster, type, rownum
	    FROM (SELECT fno, name, poster, type
	    	  FROM menupan_food ORDER BY fno)
	    WHERE rownum %lt;= 100
	    AND type LIKE '%' || #{type} || '%'
	  </select>
	 */
	public static List<FoodVO> reserveFoodListData(String type) {
		List<FoodVO> list = null;
		try {
			SqlSession session = ssf.openSession();
			list = session.selectList("reserveFoodListData", type);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
