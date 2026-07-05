package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.UserDAO;
import com.food.Model.User;
import com.food.utility.DBConnection;

public class UserDAOImpl implements UserDAO {

	private static final String INSERT_QUERY = "INSERT INTO user(userName, email, password, role, "
			+ " address, createDate, lastLoginDate, phoneNumber) Values(?,?,?,?,?,?,?,?)"; 

	private static final String SELECT_QUERY = "SELECT * FROM user WHERE userId = ? ";

	private static final String UPDATE_QUERY = "UPDATE user SET userName = ?, email = ?, password = ?,"
			+ " address = ?, lastLoginDate = ?, phoneNumber = ? WHERE userId = ? ";

	private static final String DELETE_QUERY ="DELETE FROM user WHERE userId = ? ";

	private static final String SELECT_ALL_QUERY = "SELECT * FROM user ";


	@Override
	public int addUser(User user) {
		int i = 0;
		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(INSERT_QUERY);

			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getRole());
			pstmt.setString(5, user.getAddress());
			pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pstmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
			pstmt.setString(8, user.getPhoneNumber());

			 i = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}

	@Override
	public User getUser(int userId) {

		User user = null;

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_QUERY);

			pstmt.setInt(1, userId);

			ResultSet res = pstmt.executeQuery();

			while(res.next()) {

				int id = res.getInt("userId");
				String userName = res.getString("userName");
				String password = res.getString("password");
				String email = res.getString("email");
				String address = res.getString("address");
				String role = res.getString("role");
				Timestamp createDate = res.getTimestamp("createDate");
				Timestamp lastLoginDate = res.getTimestamp("lastLoginDate");
				String phoneNumber = res.getString("phoneNumber");

				user = new User(id, userName, email, password, role, address, createDate, lastLoginDate, phoneNumber);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user;
	}

	@Override
	public void updateUser(User user) {

		Connection connection = DBConnection.getConnection();
		
		try {
			
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_QUERY);
			
			pstmt.setString(1, user.getUserName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getAddress());
			pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			pstmt.setString(6, user.getPhoneNumber());
			pstmt.setInt(7, user.getUserId());
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteUser(int userId) {

		Connection connection = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_QUERY);
			
			pstmt.setInt(1, userId);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<User> getAllUsers() {
		
		List<User> list = new ArrayList<User>();
		
		Connection connection = DBConnection.getConnection();
		
		try {
			Statement stmt = connection.createStatement();
			
			ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY);
			
			while(res.next()) {

				int userId = res.getInt("userId");
				String userName = res.getString("userName");
				String email = res.getString("email");
				String password = res.getString("password");
				String role = res.getString("role");
				String address = res.getString("address");
				Timestamp createDate = res.getTimestamp("createDate");
				Timestamp lastLoginDate = res.getTimestamp("lastLoginDate");
				String phoneNumber = res.getString("phoneNumber");

				User user = new User(userId, userName, email, password, role, address, createDate, lastLoginDate, phoneNumber);
				list.add(user);
  
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public User getUserByEmail(String email) {
		
		User user = null;
		String sql = "SELECT * FROM user WHERE email = ?";
		
		try(Connection connection = DBConnection.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(sql)){
			
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user = new User();
				user.setUserId(rs.getInt("userId"));
				user.setUserName(rs.getString("userName"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setRole(rs.getString("role"));
				user.setAddress(rs.getString("address"));
				user.setCreateDate(rs.getTimestamp("createDate"));
			    user.setLastLoginDate(rs.getTimestamp("lastLoginDate"));
			    user.setPhoneNumber("phoneNumber");
				
			}
			
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

}











