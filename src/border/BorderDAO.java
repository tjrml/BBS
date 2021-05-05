package border;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class BorderDAO {
	// DB연결
	public Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/member", "root", "root");
	}
	
	// 글쓰기
	public int writing(Border border) throws SQLException {
		int result = 0;
		String query = "INSERT INTO border(title, writer, contents, date)" +
						"VALUE (?, ?, ?, ?)";
		try(Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			pstmt.setString(1, border.getTitle());
			pstmt.setString(2, border.getWriter());
			pstmt.setString(3, border.getContent());
			pstmt.setTimestamp(4, border.getTime());
			result = pstmt.executeUpdate();
		}
		return result;
	}
	
	public List<Border> borderPrint() throws SQLException {
		List<Border> list = new ArrayList<Border>();
		String query = "SELECT * FROM border LIMIT 10";
		try (Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
			int idx = rs.getInt("idx");
			String title = rs.getString("title");
			String writer = rs.getString("writer");
			Timestamp time = rs.getTimestamp("date");
			time.toLocalDateTime();
			list.add(new Border(idx, title, writer, time));
			}
		}
		return list;
	}
	public static void main(String[] args) {
		Timestamp time = new Timestamp(System.currentTimeMillis());
		System.out.println(time);
	}
}
