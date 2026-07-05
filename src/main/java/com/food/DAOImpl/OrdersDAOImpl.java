package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.OrdersDAO;
import com.food.Model.Orders;
import com.food.utility.DBConnection;

public class OrdersDAOImpl implements OrdersDAO {

	private static final String INSERT_QUERY = "INSERT INTO orders(userId, ordersDate, totalAmount, status, paymentMethod, restaurantId)"
			+ " Values(?,?,?,?,?,?)";

	private static final String SELECT_QUERY = "SELECT * FROM orders WHERE ordersId = ? ";

	private static final String UPDATE_QUERY ="UPDATE orders SET userId = ?, ordersDate = ?, totalAmount = ?, status = ?, paymentMethod = ?, restaurantId = ? "
			+ " WHERE ordersId = ? ";

	private static final String DELETE_QUERY = "DELETE FROM orders WHERE ordersId = ? ";

	private static final String SELECT_ALL_QUERY = "SELECT * FROM orders";
	
	private static final String GET_ORDERS_BY_USER_ID ="SELECT * FROM orders WHERE userId = ? ORDER BY ordersDate DESC";
			

	@Override
	public int addOrders(Orders orders) {
		int ordersId=0;

		
		try (Connection connection = DBConnection.getConnection();
			PreparedStatement pstmt = connection.prepareStatement(INSERT_QUERY, Statement.RETURN_GENERATED_KEYS)){

			pstmt.setInt(1, orders.getUserId());
			pstmt.setObject(2, orders.getOrdersDate());
			pstmt.setDouble(3, orders.getTotalAmount());
			pstmt.setString(4, orders.getStatus());
			pstmt.setString(5, orders.getPaymentMethod());
			pstmt.setInt(6, orders.getRestaurantId());
			pstmt.executeUpdate();
			
			ResultSet res = pstmt.getGeneratedKeys();
			if(res.next()) {
				ordersId = res.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ordersId;
	}

	@Override
	public Orders getOrders(int ordersId) {
		Orders orders = null;

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_QUERY);

			pstmt.setInt(1, ordersId);

			ResultSet res = pstmt.executeQuery();

			while(res.next()) {
                int id = res.getInt("ordersId");
                int userId = res.getInt("userId");
				Timestamp ordersDate = res.getTimestamp("ordersDate");
				double totalAmount = res.getDouble("totalAmount");
				String status = res.getString("status");
				String paymentMethod = res.getString("paymentMethod");
				int restaurantId = res.getInt("restaurantId");

				orders = new Orders(ordersId, userId, ordersDate, totalAmount, status, paymentMethod,restaurantId);

			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orders;
	}

	@Override
	public void updateOrders(Orders orders) {

		Connection connection = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_QUERY);
			
			pstmt.setInt(1, orders.getUserId());
			pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
			pstmt.setDouble(3, orders.getTotalAmount());
			pstmt.setString(4, orders.getStatus());
			pstmt.setString(5, orders.getPaymentMethod());
			pstmt.setInt(6, orders.getRestaurantId());
			pstmt.setInt(7, orders.getOrdersId());
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrders(int ordersId) {

		Connection connection = DBConnection.getConnection();
		
		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_QUERY);
			
			pstmt.setInt(1, ordersId);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Orders> getAllOrders() {
		
		ArrayList<Orders> list = new ArrayList<Orders>();
		
		Connection connection = DBConnection.getConnection();
		
		try {
			Statement stmt = connection.createStatement();
			
			ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY);
			
			
			while(res.next()) {
				
                int ordersId = res.getInt("ordersId");
                int userId = res.getInt("userId");
				Timestamp ordersDate = res.getTimestamp("ordersDate");
				double totalAmount = res.getDouble("totalAmount");
				String status = res.getString("status");
				String paymentMethod = res.getString("paymentMethod");
				int restaurantId = res.getInt("restaurantId");

				Orders orders = new Orders(ordersId,userId, ordersDate, totalAmount, status, paymentMethod,restaurantId);
                list.add(orders);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public List<Orders> getOrdersByUserId(int userId) {

	    List<Orders> ordersList = new ArrayList<>();
	    
	    Connection connection = DBConnection.getConnection();

	    try {

	        PreparedStatement pstmt = connection.prepareStatement(GET_ORDERS_BY_USER_ID);

	        pstmt.setInt(1, userId);

	        ResultSet res = pstmt.executeQuery();

	        while (res.next()) {

	            Orders order = new Orders();

	            order.setOrdersId(res.getInt("ordersId"));
	            order.setUserId(res.getInt("userId"));
	            order.setOrdersDate(res.getTimestamp("ordersDate"));
	            order.setTotalAmount(res.getDouble("totalAmount"));
	            order.setStatus(res.getString("status"));
	            order.setPaymentMethod(res.getString("paymentMethod"));
	            order.setRestaurantId(res.getInt("restaurantId"));

	            ordersList.add(order);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return ordersList;
	}

	public Orders getOrderById(int ordersId) {
		
		 Orders order = null;

		    String sql = "SELECT * FROM orders WHERE ordersId = ?";

		    try (Connection con = DBConnection.getConnection();
		         PreparedStatement ps = con.prepareStatement(sql)) {

		        ps.setInt(1, ordersId);

		        ResultSet rs = ps.executeQuery();

		        if (rs.next()) {

		            order = new Orders();

		            order.setOrdersId(rs.getInt("ordersId"));
		            order.setUserId(rs.getInt("userId"));
		            order.setOrdersDate(rs.getTimestamp("ordersDate"));
		            order.setTotalAmount(rs.getDouble("totalAmount"));
		            order.setStatus(rs.getString("status"));
		            order.setPaymentMethod(rs.getString("paymentMethod"));
		            order.setRestaurantId(rs.getInt("restaurantId"));

		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		    return order;
	}


}
















