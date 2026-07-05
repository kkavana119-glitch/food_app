package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.OrderItemDAO;
import com.food.Model.OrderItem;
import com.food.Model.Orders;
import com.food.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

	private static final String INSERT_QUERY = "INSERT INTO orderitem(ordersId, quantity, itemTotal, menuId) Values(?,?,?,?)";

	private static final String SELECT_QUERY =" SELECT * FROM orderitem WHERE orderItemId = ? ";

	private static final String UPDATE_QUERY = "UPDATE orderitem SET ordersId = ?, quantity = ?, itemTotal = ? ,menuId = ?WHERE orderItemId = ? ";

	private static final String DELETE_QUERY = "DELETE FROM orderitem WHERE orderItemId = ? ";

	private static final String SELECT_ALL_QUERY = "SELECT * FROM orderitem ";

	@Override
	public void addOrderItem(OrderItem orderitem) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(INSERT_QUERY);

			pstmt.setInt(1, orderitem.getOrdersId());
			pstmt.setInt(2, orderitem.getQuantity());
			pstmt.setDouble(3, orderitem.getItemTotal());
			pstmt.setInt(4, orderitem.getMenuId());


			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public OrderItem getOrderItem(int orderItemId) {
		OrderItem orderitem = null;

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_QUERY);

			pstmt.setInt(1, orderItemId);

			ResultSet res = pstmt.executeQuery();

			while(res.next()) {

				int id = res.getInt("orderItemId");
				int ordersId = res.getInt("ordersId");
				int quantity = res.getInt("quantity");
				double itemTotal = res.getDouble("itemTotal");
				int menuId = res.getInt("menuId");

				orderitem = new OrderItem(orderItemId,ordersId, quantity, itemTotal, menuId);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return orderitem;
	}

	@Override
	public void updateOrderItem(OrderItem orderitem) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_QUERY);

			pstmt.setInt(1, orderitem.getOrdersId());
			pstmt.setInt(2, orderitem.getQuantity());
			pstmt.setDouble(3, orderitem.getItemTotal());
			pstmt.setInt(4, orderitem.getMenuId());
			pstmt.setInt(5, orderitem.getOrderItemId());

			pstmt.executeUpdate();


		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOrderItem(int orderItemId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_QUERY);

			pstmt.setInt(1, orderItemId);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<OrderItem> getAllOrderItem() {

		ArrayList<OrderItem> list = new ArrayList<OrderItem>();

		Connection connection = DBConnection.getConnection();

		try {
			Statement stmt = connection.createStatement();

			ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY);

			while(res.next()) {

				int orderItemId = res.getInt("orderItemId");
				int ordersId = res.getInt("ordersId");
				int quantity = res.getInt("quantity");
				double itemTotal = res.getDouble("itemTotal");
				int menuId = res.getInt("menuId");

				OrderItem orderitem = new OrderItem(orderItemId, ordersId,  quantity, itemTotal, menuId);
				list.add(orderitem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<OrderItem> getItemsByOrderId(int ordersId) {

		List<OrderItem> items = new ArrayList<>();

		String sql = "SELECT * FROM orderitem WHERE ordersId = ?";

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, ordersId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				OrderItem item = new OrderItem();

				item.setOrderItemId(rs.getInt("orderItemId"));
				item.setOrdersId(rs.getInt("ordersId"));
				item.setMenuId(rs.getInt("menuId"));
				item.setQuantity(rs.getInt("quantity"));
				item.setItemTotal(rs.getDouble("itemTotal"));

				items.add(item);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return items;
	}



}














