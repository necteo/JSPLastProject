package com.sist.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.ReserveVO;

public class AdminDAO {
	private static SqlSessionFactory ssf = CreateSqlSessionFactory.getSsf();
	
	/*
	 * <select id="reserveAdminListData" resultMap="reserveMap">
	    SELECT no, ri.fno, id, rday, time, inwon, ok, name, phone, poster
	    FROM reserve_info ri, menupan_food mf
	    WHERE ri.fno = mf.fno
	    ORDER BY no DESC
	  </select>
	 */
	public static List<ReserveVO> reserveAdminListData() {
		List<ReserveVO> list = null;
		try {
			SqlSession session = ssf.openSession();
			list = session.selectList("reserveAdminListData");
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/*
	 * <update id="reserveOk" parameterType="int">
	    UPDATE reserve_info
	    SET ok = 1
	    WHERE no = #{no}
	  </update>
	 */
	public static void reserveOk(int no) {
		try {
			SqlSession session = ssf.openSession(true);
			session.update("reserveOk", no);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
