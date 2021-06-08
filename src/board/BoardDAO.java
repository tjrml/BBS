package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
	private static BoardDAO instance = new BoardDAO();

	private BoardDAO() {
	}

	public static BoardDAO getInstance() {
		return instance;
	}

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
	public int writing(Board border) throws SQLException {
		int result = -1;
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
	public Board seleteOne(int idx) throws SQLException {
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
				return new Board(title, content, writer, date);
			}
		}
		return null;
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
	public List<Board> boardPrint(int index, int numPerPage) throws SQLException {
		List<Board> list = new ArrayList<Board>();
		String query = "SELECT * FROM border ORDER BY idx DESC LIMIT ?, ?";
		try (Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			pstmt.setInt(1, index);
			pstmt.setInt(2, numPerPage);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int idx = rs.getInt("idx");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				Timestamp time = rs.getTimestamp("date");
				String date = time.toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
				int hit = rs.getInt("hit");
				list.add(new Board(idx, title, writer, date, hit));
			}
			return list;
		}
	}

	// 조회수 증가
	public int hitUP(int idx, int hit) {
		String query = "UPDATE border SET hit = ? WHERE idx = ?";
		try (Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			pstmt.setInt(1, hit);
			pstmt.setInt(2, idx);
			int result = pstmt.executeUpdate();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 검색 총 갯수
		public int searchCount(String key, String value) throws SQLException {
			int count = 0;
			String query = "SELECT COUNT(*) FROM border WHERE " + key + " LIKE ?";
			try (Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);) {
				pstmt.setString(1, "%"+value+"%");
				ResultSet rs = pstmt.executeQuery(); 
					while (rs.next()) {
					count = rs.getInt(1);
					System.out.println(count);
					return count;
				}
				return -1;
			}
		}
	
	// 검색
	public List<Board> search(String key, String value, int index, int numPerPage) throws SQLException {
		List<Board> list = new ArrayList<Board>();
		String query = "SELECT * FROM border WHERE " + key + " LIKE ? ORDER BY idx DESC LIMIT ?, ?";
		try (Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(query);) {
			pstmt.setString(1, "%" + value + "%");
			pstmt.setInt(2, index);
			pstmt.setInt(3, numPerPage);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int idx = rs.getInt("idx");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				Timestamp time = rs.getTimestamp("date");
				String date = time.toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
				int hit = rs.getInt("hit");
				list.add(new Board(idx, title, writer, date, hit));
			}
			return list;
		}
	}
	
}


