package dairy.DBTool;

import java.sql.*;

public class ConnDB {
	
	public static String user = "root";  //瀹氫箟杩炴帴鐢ㄦ埛鍚�
	public static String password = "335800";  //瀹氫箟杩炴帴瀵嗙爜
	public Connection conn = null; // 澹版槑Connection瀵硅薄鐨勫疄渚�
	public Statement stmt = null; // 澹版槑Statement瀵硅薄鐨勫疄渚�
	public ResultSet rs = null; // 澹版槑ResultSet瀵硅薄鐨勫疄渚�
	private static String ClassName = "com.mysql.jdbc.Driver"; // 瀹氫箟淇濆瓨鏁版嵁搴撻┍鍔ㄧ殑鍙橀噺
	public static String url = "jdbc:mysql://127.0.0.1:3306/diary";  //瀹氫箟椹卞姩杩炴帴鍦板潃
	/**
	 * 鑾峰彇杩炴帴鐨勮鍙�
	 * @return
	 */
	public static Connection getConnection() {
		Connection conn = null;
		try { // 鎹曟崏寮傚父
			Class.forName(ClassName); // 瑁呰浇鏁版嵁搴撻┍鍔�
			conn=DriverManager.getConnection(url,user,password);
		} catch (Exception e) {
			e.printStackTrace(); // 杈撳嚭寮傚父
		}
		return conn; // 杩斿洖鏁版嵁搴撹繛鎺ュ璞�
	}
	/**
	 * 鎵ц鏌ヨ璇彞
	 * @param sql
	 * @return
	 */
	public ResultSet select(String sql) {
		try { // 鎹曟崏寮傚父
			conn = getConnection(); //璋冪敤getConnection()鏂规硶鏋勯�犲疄渚媍onn
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace(); // 杈撳嚭寮傚父
		}
		return rs; // 杩斿洖缁撴灉闆嗗璞�
	}
	/**
	 * 鎵ц鏇存柊鎿嶄綔
	 * @param sql
	 * @return
	 */
	public int update(String sql) {
		int result = 0; // 瀹氫箟淇濆瓨杩斿洖鍊肩殑鍙橀噺
		try { // 鎹曟崏寮傚父
			conn = getConnection(); // 璋冪敤getConnection()鏂规硶鏋勯�犲疄渚媍onn
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql); // 鎵ц鏇存柊璇彞
		} catch (SQLException e) {
			result = 0; // 灏嗕繚瀛樿繑鍥炲�肩殑鍙橀噺璧嬪�间负0
			e.printStackTrace(); // 杈撳嚭寮傚父
		}
		return result; // 杩斿洖淇濆瓨杩斿洖鍊肩殑鍙橀噺
	}
	/**
	 * 鍏抽棴鏁版嵁搴�
	 */
	public void close() {
		try { // 鎹曟崏寮傚父
			if (rs != null) { 
				rs.close(); // 鍏抽棴ResultSet瀵硅薄
			}
			if (stmt != null) { 
				stmt.close(); // 鍏抽棴Statement瀵硅薄
			}
			if (conn != null) {
				conn.close(); // 鍏抽棴Connection瀵硅薄
			}
		} catch (Exception e) {
			e.printStackTrace(System.err); // 杈撳嚭寮傚父
		}
	}
}
