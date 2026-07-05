package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.User1DAO;
import com.food.Model.User1;
import com.food.utility.DBConnection;

public class User1DAOImpl implements User1DAO {

	private static final String INSERT_QUERY = "INSERT INTO user1(name, email, phonenumber, password, "
			+ " confirmpassword) Values(?,?,?,?,?)"; 

	private static final String SELECT_QUERY = "SELECT * FROM user1 WHERE userId = ? ";

	private static final String UPDATE_QUERY = "UPDATE user1 SET name = ?, email = ?, phonenumber = ?, "
			+ " password = ?, confirmpassword = ? WHERE userId = ? ";

	private static final String DELETE_QUERY ="DELETE FROM user1 WHERE userId = ? ";

	private static final String SELECT_ALL_QUERY = "SELECT * FROM user1 ";


	@Override
	public int addUser1(User1 user1) {
		
		int result = 0;

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(INSERT_QUERY);

			pstmt.setString(1, user1.getName());
			pstmt.setString(2, user1.getEmail());
			pstmt.setString(3, user1.getPhone());
			pstmt.setString(4, user1.getPassword());
			pstmt.setString(5, user1.getConfirmpassword());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public User1 getUser1(int userId) {

		User1 user1 = null;

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_QUERY);

			pstmt.setInt(1, userId);

			ResultSet res = pstmt.executeQuery();

			while(res.next()) {

				int id = res.getInt("userId");
				String name = res.getString("name");
				String email = res.getString("email");
				String phonenumber = res.getString("phonenumber");
				String password = res.getString("password");
				String confirmpasword = res.getString("confirmpassword");

				user1 = new User1(userId, name, email, phonenumber, password, confirmpasword);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user1;
	}

	@Override
	public void updateUser1(User1 user1) {

		Connection connection = DBConnection.getConnection();
		
		try {
			
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_QUERY);
			
			pstmt.setString(1, user1.getName());
			pstmt.setString(2, user1.getEmail());
			pstmt.setString(3, user1.getPhone());
			pstmt.setString(4, user1.getPassword());
			pstmt.setString(5, user1.getConfirmpassword());
			pstmt.setInt(6, user1.getId());
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteUser1(int userId) {

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
	public List<User1> getAllUsers1() {
		
		List<User1> list = new ArrayList<User1>();
		
		Connection connection = DBConnection.getConnection();
		
		try {
			Statement stmt = connection.createStatement();
			
			ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY);
			
			while(res.next()) {

				int userId = res.getInt("userId");
				String name = res.getString("name");
				String email = res.getString("email");
				String phonenumber = res.getString("phonenumber");
				String password = res.getString("password");
				String confirmpassword = res.getString("confirmpassword");

				User1 user1 = new User1(userId, name, email, phonenumber, password, confirmpassword);
				list.add(user1);
  
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public User1 validateUser1(String email, String password) {
		 User1 user1 = null;

		    try {

		    	Connection connection = DBConnection.getConnection();
		        String query =
		            "SELECT * FROM user1 WHERE email=? AND password=?";

				PreparedStatement pstmt = connection.prepareStatement(query);

		        pstmt.setString(1, email);
		        pstmt.setString(2, password);

		        ResultSet rs = pstmt.executeQuery();

		        if(rs.next()) {

		            user1 = new User1();

		            user1.setId(rs.getInt("userId"));
		            user1.setName(rs.getString("name"));
		            user1.setEmail(rs.getString("email"));
		            user1.setPassword(rs.getString("password"));
		        }

		    } catch(Exception e) {
		        e.printStackTrace();
		    }

		    return user1;
	}


}











