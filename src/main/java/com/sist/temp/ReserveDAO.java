package com.sist.temp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class ReserveDAO {
	private Connection conn;
	private PreparedStatement ps;
	private String url = "jdbc:oracle:thin:@localhost:1521:XE";
	private static ReserveDAO dao;
	
	public ReserveDAO() {
		try {
			Class.forName("Oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) { }
	}
	
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(url, "hr", "happy");
		} catch (Exception e) { }
	} // session.openSession()
	
	public void disConnection() {
		try {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) { }
	} // session.close()
	
	public static ReserveDAO newInstance() {
		if (dao == null)
			dao = new ReserveDAO();
		return dao;
	}
	
	public void insert(int no, String time) {
		try {
			getConnection();
			String sql = "INSERT INTO reserve_date "
					   + "VALUES(?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ps.setString(2, time);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
	}

}
