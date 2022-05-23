package dairy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import dairy.DBTool.ConnDB;
import dairy.model.User;

public class UserDao {
	private ConnDB conn = null;	//鍒涘缓鏁版嵁搴撳疄渚嬪寲瀵硅薄
	
	public UserDao(){	// 鏋勯�犳柟娉�
		conn = new ConnDB();	//瀹炰緥鍖栨暟鎹簱杩炴帴瀵硅薄
	}
	/**
	 * 楠岃瘉鐢ㄦ埛鐧诲綍锛岃繑鍥炲�间负1鍗崇櫥褰曟垚鍔�
	 * @param user
	 * @return
	 */
	public int login(User user) {
		int flag = 0;
		String sql = "SELECT * FROM dy_user where uname='"+ user.getUname() + "'"; //瀹氫箟SQL璇彞
		ResultSet rs = conn.select(sql);// 鎵цSQL璇彞
		try {
			if (rs.next()) {
				String upwd = user.getUpwd();// 鑾峰彇瀵嗙爜
				int uid = rs.getInt(1);// 鑾峰彇id
				if (upwd.equals(rs.getString(3))) {
					flag = uid;
					rs.last(); // 瀹氫綅鍒版渶鍚庝竴鏉¤褰�
					int rowSum = rs.getRow();// 鑾峰彇璁板綍鎬绘暟
					rs.first();// 瀹氫綅鍒扮涓�鏉¤褰�
					if (rowSum != 1) {
						flag = 0;
					}
				} else {
					flag = 0;
				}
			} else {
				flag = 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			flag = 0;
		} finally {
			conn.close();// 鍏抽棴鏁版嵁搴撹繛鎺�
		}
		return flag;// 杩斿洖缁撴灉
	}
	/**
	 * 妫�娴嬬敤鎴峰悕鏄惁鍗犵敤
	 * @param sql
	 * @return
	 */
	public String checkUser(String sql) {
		ResultSet rs = conn.select(sql); // 鎵ц鏌ヨ璇彞
		String result = null;
		try {
			if (rs.next()) {
				result = "寰堟姳姝夛紝鈥�" + rs.getString(2) + "鈥濆凡缁忚娉ㄥ唽锛�";
			} else {
				result = "1"; // 琛ㄧず鐢ㄦ埛娌℃湁琚敞鍐�
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			conn.close(); // 鍏抽棴鏁版嵁搴撹繛鎺�
		}
		return result; // 杩斿洖鍒ゆ柇缁撴灉
	}
	/**
	 * 鐢ㄦ埛娉ㄥ唽
	 * @param sql
	 * @return
	 */
	public String add(String sql) {
		int rtn = conn.update(sql); // 鎵ц鏇存柊璇彞
		String result = "";
		if (rtn > 0) {
			result = "鐢ㄦ埛娉ㄥ唽鎴愬姛锛�";
		} else {
			result = "鐢ㄦ埛娉ㄥ唽澶辫触锛�";
		}
		conn.close(); // 鍏抽棴鏁版嵁搴撶殑杩炴帴
		return result; // 杩斿洖鎵ц缁撴灉
	}
	/**
	 * 鎵惧洖瀵嗙爜_1
	 * @param uname
	 * @return
	 */
	public String findUpwd_1(String uname) {
		String sql = "SELECT question FROM dy_user WHERE uname='" + uname+ "'";//瀹氫箟SQL璇彞
		ResultSet rs = conn.select(sql);// 鎵цSQL璇彞
		String result = "";
		try {
			if (rs.next()) {
				result = rs.getString(1);// 鑾峰彇鏁版嵁
			} else {
				result = "鎮ㄨ緭鍏ョ殑鐢ㄦ埛鍚嶄笉瀛樺湪锛�"; 
			}
		} catch (SQLException e) {
			e.printStackTrace();
			result = "鎮ㄨ緭鍏ョ殑鐢ㄦ埛鍚嶄笉瀛樺湪锛�"; 
		} finally {
			conn.close(); // 鍏抽棴鏁版嵁搴撹繛鎺�
		}
		return result;
	}
	/**
	 * 鎵惧洖瀵嗙爜_2
	 * @param username
	 * @param question
	 * @param answer
	 * @return
	 */
	public String findUpwd_2(String username, String question, String answer) {
		String sql = "SELECT upwd FROM dy_user WHERE uname='" + username
				+ "' AND question='" + question + "' AND answer='" + answer
				+ "'";	//瀹氫箟SQL璇彞
		ResultSet rs = conn.select(sql);// 鎵цSQL璇彞
		String result = "";
		try {
			if (rs.next()) {
				result = rs.getString(1);// 鑾峰彇鏁版嵁
			} else {
				result = "鎮ㄨ緭鍏ョ殑瀵嗙爜鎻愮ず闂绛旀閿欒锛�"; // 琛ㄧず杈撳叆鐨勫瘑鐮佹彁绀洪棶棰樼瓟妗堥敊璇�
			}
		} catch (SQLException e) {
			e.printStackTrace();// 杈撳嚭寮傚父淇℃伅
		} finally {
			conn.close(); // 鍏抽棴鏁版嵁搴撹繛鎺�
		}
		return result;
	}
}
