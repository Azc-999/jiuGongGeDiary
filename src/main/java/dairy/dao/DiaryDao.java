package dairy.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import dairy.DBTool.ConnDB;
import dairy.model.Diary;

public class DiaryDao {
	private ConnDB conn = null;// 创建数据库连接对象

	public DiaryDao() {	//构造方法
		conn = new ConnDB();// 实例化数据库连接对象
	}
	/**
	 * 查询日记
	 * @param sql
	 * @return
	 */
	public List<Diary> queryDiary(String sql){
		ResultSet rs = conn.select(sql);
		List<Diary> list = new ArrayList<Diary>();
		try {
			while (rs.next()) {
				Diary diary = new Diary();
				diary.setId(rs.getInt(1));// 获取并设置日记ID
				diary.setTitle(rs.getString(2));// 获取并设置日记标题
				diary.setAddress(rs.getString(3));// 获取并设置图片地址
				Date date;
				try {
					date = DateFormat.getDateTimeInstance().parse(
							rs.getString(4));
					diary.setWriteTime(date);// 设置写日记的时间
				} catch (ParseException e) {
					e.printStackTrace();
				}

				diary.setUserid(rs.getInt(5));// 获取并设置用户ID
				diary.setUsername(rs.getString(6));// 获取并设置用户名
				list.add(diary);// 将日记信息保存到list集合中

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			conn.close();// 关闭数据库连接
		}
		return list;	//返回信息
	}
	/**
	 * 保存日记
	 * @param diary
	 * @return
	 */
	public int saveDiary(Diary diary) {
		String sql = "INSERT INTO dy_diary (title,address,userid) VALUES('"
				+ diary.getTitle() + "','" + diary.getAddress() + "',"
				+ diary.getUserid() + ")";		//定义SQL语句
		int res = conn.update(sql);// 执行更新语句
		conn.close();// 关闭数据库连接
		return res;	//返回值
	}
	/**
	 * 删除日记
	 * @param id
	 * @return
	 */
	public int delDiary(int id) {
		String sql = "DELETE FROM dy_diary WHERE id=" + id;
		int res = 0;
		try {
			res = conn.update(sql);// 执行更新语句
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();// 关闭数据连接
		}
		return res;	//返回值
	}
}
