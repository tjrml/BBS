package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
	// DB연결
	public Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/member", "root", "root");
	}
	
	// 회원가입
	public int join(User user) throws SQLException {
		int result = 0;
		String query = "INSERT INTO user(id, password, name, age)" + "VALUE(?, ?, ?, ?)";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setInt(4, user.getAge());
			result = pstmt.executeUpdate();
		}
		return result;
	}
	// 로그인
	public boolean login(String loginId, String loginPw) throws SQLException {
		boolean result = false;
		String query = "SELECT * FROM user WHERE id = ? and password = ?";
		try (Connection conn = getConnection();) {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, loginId);
			pstmt.setString(2, loginPw);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				if (rs.getString("id").equals(loginId) && rs.getString("password").equals(loginPw)) {
					return true;
				}
			}
		}
		return result;
	}
}
