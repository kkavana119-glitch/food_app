package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.RestaurantDAO;
import com.food.Model.Restaurant;
import com.food.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

	private static final String INSERT_QUERY = "INSERT INTO restaurant(restaurantName, cuisineType, deliveryTime, address, rating, isActive, imagePath)"
			+ " values(?,?,?,?,?,?,?)";

	private static final String SELECT_QUERY = "SELECT * FROM restaurant WHERE restaurantId = ? ";

	private static final String UPDATE_QUERY = "UPDATE restaurant SET restaurantName = ?, cuisineType = ?, deliveryTime = ?, "
			+ " address = ?, rating = ?, imagePath = ?  WHERE restaurantId = ? ";

	private static final String DELETE_QUERY = "DELETE FROM restaurant WHERE restaurantId = ?";

	private static final String SELECT_ALL_QUERY = "SELECT * FROM restaurant";

	@Override
	public void addRestaurant(Restaurant restaurant) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(INSERT_QUERY);

			pstmt.setString(1, restaurant.getRestaurantName());
			pstmt.setString(2, restaurant.getCuisineType());
			pstmt.setInt(3, restaurant.getDeliveryTime());
			pstmt.setString(4, restaurant.getAddress());
			pstmt.setDouble(5, restaurant.getRating());
			pstmt.setBoolean(6, restaurant.isActive());
			pstmt.setString(7, restaurant.getImagePath());


			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Restaurant getRestaurant(int restaurantId) {

		Restaurant restaurant = null;

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_QUERY);

			pstmt.setInt(1, restaurantId);

			ResultSet res = pstmt.executeQuery();

			while(res.next()) {

				int id = res.getInt("restaurantId");
				String restaurantName = res.getString("restaurantName");
				String cuisineType = res.getString("cuisineType");
				int deliveryTime = res.getInt("deliveryTime");
				String address = res.getString("address");
				double rating = res.getDouble("rating");
				boolean isActive = res.getBoolean("isActive");
				String imagePath = res.getString("imagePath");


				restaurant = new Restaurant(restaurantId, restaurantName, cuisineType, deliveryTime, address, rating, isActive, imagePath);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return restaurant;
	}

	@Override
	public void updateRestaurant(Restaurant restaurant) {

		
		Connection connection = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_QUERY);
			
			pstmt.setString(1, restaurant.getRestaurantName());
			pstmt.setString(2, restaurant.getCuisineType());
			pstmt.setInt(3, restaurant.getDeliveryTime());
			pstmt.setString(4, restaurant.getAddress());
			pstmt.setDouble(5, restaurant.getRating());
			pstmt.setString(6, restaurant.getImagePath());
			pstmt.setInt(7, restaurant.getRestaurantId());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteRestaurant(int restaurantId) {

		Connection connection = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_QUERY);
			
			pstmt.setInt(1, restaurantId);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Restaurant> getAllRestaurants() {
		
		ArrayList<Restaurant> list = new ArrayList<Restaurant>();
		
		Connection connection = DBConnection.getConnection();
		
		try {
			Statement stmt = connection.createStatement();
			
			ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY);
			
			while(res.next()) {
				
				int restaurantId = res.getInt("restaurantId");
				String restaurantName = res.getString("restaurantName");
				String cuisineType = res.getString("cuisineType");
				int deliveryTime = res.getInt("deliveryTime");
				String address = res.getString("address");
				double rating = res.getDouble("rating");
				boolean isActive = res.getBoolean("isActive");
				String imagePath = res.getString("imagePath");
				
				Restaurant restaurant = new Restaurant(restaurantId, restaurantName, cuisineType, deliveryTime, address, rating, isActive, imagePath);
				list.add(restaurant);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public Restaurant getRestaurantById(int restaurantId) {

	    Restaurant restaurant = null;

	    try {

	        Connection con = DBConnection.getConnection();

	        String sql = "SELECT * FROM restaurant WHERE restaurantId=?";

	        PreparedStatement pstmt = con.prepareStatement(sql);

	        pstmt.setInt(1, restaurantId);

	        ResultSet rs = pstmt.executeQuery();

	        if(rs.next()) {

	            restaurant = new Restaurant();

	            restaurant.setRestaurantId(rs.getInt("restaurantId"));
	            restaurant.setRestaurantName(rs.getString("restaurantName"));
	            restaurant.setCuisineType(rs.getString("cuisineType"));
	            restaurant.setRating(rs.getFloat("rating"));
	            restaurant.setImagePath(rs.getString("imagePath"));
	            restaurant.setActive(rs.getBoolean("isActive"));

	        }

	    } catch(Exception e) {
	        e.printStackTrace();
	    }

	    return restaurant;
	}

}
