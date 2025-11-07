package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.EmpVO;

public class EmpDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	/*
	 * <select id="empAllData" resultMap="empMap">
	    SELECT empno, ename, job, TO_CHAR(hiredate, 'YYYY-MM-DD') dbday, dname, loc
	    FROM emp, dept
	    WHERE emp.deptno = dept.deptno
	  </select>
	  <select id="empAllNames" resultType="string">
	    SELECT ename FROM emp
	  </select>
	 */
	public static List<EmpVO> empAllData() {
		SqlSession session = ssf.openSession();
		List<EmpVO> list = session.selectList("empAllData");
		session.close();
		return list;
	}
	
	public static List<String> empAllNames() {
		SqlSession session = ssf.openSession();
		List<String> list = session.selectList("empAllNames");
		session.close();
		return list;
	}
	
	/*
	 * <select id="empFindData" resultMap="empMap" parameterType="hashmap">
	    SELECT empno, ename, job, TO_CHAR(hiredate, 'YYYY-MM-DD') dbday, dname, loc
	    FROM emp, dept
	    WHERE emp.deptno = dept.deptno
	    <trim prefix="AND ename IN(" suffix=")" suffixOverrides=")">
	      <foreach collection="nameArr" item="ename" close=")" separator=",">
	        #{ename}
	      </foreach>
	    </trim>
	  </select>
	 */
	public static List<EmpVO> empFindData(Map<String, String[]> map) {
		SqlSession session = ssf.openSession();
		List<EmpVO> list = session.selectList("empFindData", map);
		session.close();
		return list;
	}

}
