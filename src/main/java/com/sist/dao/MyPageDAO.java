package com.sist.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.ReserveVO;

public class MyPageDAO {
	private static SqlSessionFactory ssf = CreateSqlSessionFactory.getSsf();
	
	/*
	 * <!-- mypage -->
	  <select id="reserveMyPageListData" resultMap="reserveMap" parameterType="string">
	    SELECT no, ri.fno, id, rday, time, inwon, ok, name, phone, poster
	    FROM reserve_info ri, menupan_food mf
	    WHERE ri.fno = mf.fno
	    AND id = #{id}
	    ORDER BY no DESC
	  </select>
	 */
	public static List<ReserveVO> reserveMyPageListData(String id) {
		List<ReserveVO> list = null;
		try {
			SqlSession session = ssf.openSession();
			list = session.selectList("reserveMyPageListData", id);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/*
	 * <delete id="reserveCancel" parameterType="int">
	    DELETE FROM reserve_info
	    WHERE no = #{no}
	  </delete>
	 */
	public static void reserveCancel(int no) {
		try {
			SqlSession session = ssf.openSession(true);
			session.delete("reserveCancel", no);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * <select id="reserveOkData" resultMap="rMap" parameterType="no">
	    SELECT no, rday, ri.time, inwon, TO_CHAR(regdate, 'YYYY-MM-DD HH24:MI:SS') dbday, 
	    	   poster, name, phone, address, parking, score, type
	    FROM reserve_info ri, menupan_food mf
	    WHERE ri.fno = mf.fno
	    AND no = #{no}
	  </select>
	 */
	public static ReserveVO reserveOkData(int no) {
		ReserveVO vo = null;
		try {
			SqlSession session = ssf.openSession();
			vo = session.selectOne("reserveOkData", no);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

}
