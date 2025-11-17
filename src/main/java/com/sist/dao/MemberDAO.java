package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.MemberVO;

public class MemberDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	/*
	 * <select id="memberIdCheck" resultType="int" parameterType="string">
	     SELECT COUNT(*)
	     FROM mvcMemeber
	     WHERE id = #{id}
	   </select>
	 */
	public static int memberIdCheck(String id) {
		int count = 0;
		try {
			SqlSession session = ssf.openSession();
			count = session.selectOne("memberIdCheck", id);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	// 회원가입
	/*
	 * <insert id="memberInsert" parameterType="MemberVO">
	     INSERT INTO mvcMember VALUES(
	     	#{id},
	     	#{pwd},
	     	#{name},
	     	#{sex},
	     	#{birthday},
	     	#{email},
	     	#{post},
	     	#{addr1},
	     	#{addr2},
	     	#{phone},
	     	#{content},
	     	'n',
	     	SYSDATE
	     )   
	   </insert>
	 */
	public static void memberInsert(MemberVO vo) {
		try {
			SqlSession session = ssf.openSession(true);
			session.insert("memberInsert", vo);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 로그인 처리
	public static MemberVO memberLogin(String id, String pwd) {
		MemberVO vo = new MemberVO();
		try {
			SqlSession session = ssf.openSession();
			int count = session.selectOne("memberIdCheck", id);
			if (count== 0) {
				vo.setMsg("NOID");
			} else {
				MemberVO dbvo = session.selectOne("memberInfoData", id);
				if (pwd.equals(dbvo.getPwd())) {
					vo.setMsg("OK");
					vo.setId(dbvo.getId());
					vo.setPwd(pwd);
					vo.setName(dbvo.getName());
					vo.setSex(dbvo.getSex());
					vo.setPost(dbvo.getPost());
					vo.setAddr1(dbvo.getAddr1());
					vo.setAddr2(dbvo.getAddr2());
					vo.setAdmin(dbvo.getAdmin());
					vo.setPhone(dbvo.getPhone());
				} else {
					vo.setMsg("NOPWD");
				}
			}
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	/*
	 * <select id="memberInfoData" resultType="MemberVO" parameterType="string">
	     SELECT id, name, sex, pwd, admin, post, addr1, addr2, phone
	     FROM mvcMember
	     WHERE id = #{id}
	   </select>
	 */
	public static MemberVO memberInfoData(String id) {
		MemberVO vo = null;
		try {
			SqlSession session = ssf.openSession();
			vo = session.selectOne("memberInfoData", id);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

}
