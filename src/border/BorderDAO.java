package border;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.jdt.internal.compiler.batch.Main;

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
		String query = "INSERT INTO border(title, writer, contents, date)" + "VALUE (?, ?, ?, ?)";
		try (Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			pstmt.setString(1, border.getTitle());
			pstmt.setString(2, border.getWriter());
			pstmt.setString(3, border.getContent());
			pstmt.setTimestamp(4, border.getTime());
			result = pstmt.executeUpdate();
		}
		return result;
	}


	// 삭제
	public int delete(int idx) {
		String query = "DELETE FROM border WHERE idx = ?";
		try (Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			pstmt.setInt(1, idx);
			int result = pstmt.executeUpdate();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1; // DB오류
	}

	// 수정
	public int update(String title, String contents, int idx) {
		String query = "UPDATE border SET title = ?, contents = ? WHERE idx = ?";
		try (Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			pstmt.setString(1, title);
			pstmt.setString(2, contents);
			pstmt.setInt(3, idx);
			int result = pstmt.executeUpdate();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 1개만 검색
	public List<Border> seleteOne(int idx) throws SQLException {
		List<Border> list = new ArrayList<Border>();
		String query = "SELECT * FROM border WHERE idx = ?";
		try (Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			pstmt.setInt(1, idx);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				String content = rs.getString("contents");
				Timestamp date = rs.getTimestamp("date");
				list.add(new Border(title, content, writer, date));
			}
			return list;
		}
	}

	// 게시물 총 개수
	public int totalCount() throws SQLException {
		int count = 0;
		String query = "SELECT COUNT(*) FROM border";
		try (Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					count = rs.getInt(1);
					return count;
				}
			}
		}
		return -1;
	}
	

	// 게시판 화면 출력 
	public List<Border> borderPrint(int index) throws SQLException {
		List<Border> list = new ArrayList<Border>();
		String query = "SELECT * FROM border ORDER BY idx DESC LIMIT ?, 10";
		try (Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			pstmt.setInt(1, index);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int idx = rs.getInt("idx");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				Timestamp time = rs.getTimestamp("date");
				String date = time.toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
				list.add(new Border(idx, title, writer, date));
			}
			return list;
		}
	}

}
