package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.MenuDAO;
import com.food.Model.Menu;
import com.food.utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {

	private static final String INSERT_QUERY = " INSERT INTO menu( itemName, description, price, isAvailable, category,restaurantId, imagePath)"
			+ " Values(?,?,?,?,?,?,?)";

	private static final String SELECT_QUERY =" SELECT * FROM menu WHERE menuId = ?";

	private static final String UPDATE_QUERY = "UPDATE menu SET itemName = ?, description = ?, price = ?, isAvailable = ?, "
			+ " category = ?, restaurantId = ?, imagePath = ? WHERE menuId = ? ";

	private static final String DELETE_QUERY = "DELETE FROM menu WHERE menuId = ? ";

	private static final String SELECT_ALL_QUERY = "SELECT * FROM menu ";
	
	private static final String SELECT_ALL_QUERY1 = "SELECT * FROM menu where restaurantId = ?";



	@Override
	public void addMenu(Menu menu) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(INSERT_QUERY);

			pstmt.setString(1, menu.getItemName());
			pstmt.setString(2, menu.getDescription());
			pstmt.setDouble(3, menu.getPrice());
			pstmt.setBoolean(4, menu.isAvailable());
			pstmt.setString(5, menu.getCategory());
			pstmt.setInt(6, menu.getRestaurantId());
			pstmt.setString(7, menu.getImagePath());

			pstmt.executeUpdate();


		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public Menu getMenu(int menuId) {

		Menu menu = null;

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_QUERY);

			pstmt.setInt(1, menuId);

			ResultSet res = pstmt.executeQuery();

			while(res.next()) {

				int id = res.getInt("menuId");
				String itemName = res.getString("itemName");
				String description = res.getString("description");
				double price = res.getDouble("price");
				boolean isAvailable = res.getBoolean("isAvailable");
				String category = res.getString("category");
				int restaurantId = res.getInt("restaurantId");
				String imagePath = res.getString("imagePath");

				menu = new Menu(menuId,itemName, description, price, isAvailable, category,restaurantId,  imagePath);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return menu;
	}

	@Override
	public void updateMenu(Menu menu) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(UPDATE_QUERY);
 
			pstmt.setString(1, menu.getItemName());
			pstmt.setString(2, menu.getDescription());
			pstmt.setDouble(3, menu.getPrice());
			pstmt.setBoolean(4, menu.isAvailable());
			pstmt.setString(5, menu.getCategory());
			pstmt.setInt(6, menu.getRestaurantId());
			pstmt.setString(7, menu.getImagePath());
			pstmt.setInt(8, menu.getMenuId());

			int rows = pstmt.executeUpdate();
			System.out.println("Rows updated = "+ rows);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteMenu(int menuId) {

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(DELETE_QUERY);

			pstmt.setInt(1, menuId);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Menu> getAllMenus(int restaurantId) {
		
		ArrayList<Menu> list = new ArrayList<Menu>();

		Connection connection = DBConnection.getConnection();

		try {
			PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_QUERY1);

//			ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY1);
			
			pstmt.setInt(1, restaurantId);
			
			ResultSet res = pstmt.executeQuery();
			

			while(res.next()) {

				int menuId = res.getInt("menuId");
				String itemName = res.getString("itemName");
				String description = res.getString("description");
				double price = res.getDouble("price");
				boolean isAvailable = res.getBoolean("isAvailable");
				String category = res.getString("category");
				int restaurantId1 = res.getInt("restaurantId");
				String imagePath = res.getString("imagePath");

				Menu menu = new Menu(menuId, itemName, description, price, isAvailable, category, restaurantId1, imagePath);
				list.add(menu);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	
	public List<Menu> getAllMenus() {

	    ArrayList<Menu> list = new ArrayList<>();

	    Connection connection = DBConnection.getConnection();

	    try {

	        Statement stmt = connection.createStatement();

	        ResultSet res = stmt.executeQuery("SELECT * FROM menu");

	        while(res.next()) {

	            Menu menu = new Menu(
	                res.getInt("menuId"),
	                res.getString("itemName"),
	                res.getString("description"),
	                res.getDouble("price"),
	                res.getBoolean("isAvailable"),
	                res.getString("category"),
	                res.getInt("restaurantId"),
	                res.getString("imagePath")
	            );

	            list.add(menu);
	        }

	    } catch(Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	
	public List<Menu> getMenuByCategory(String category) {

	    List<Menu> list = new ArrayList<>();

	    Connection connection = DBConnection.getConnection();

	    String query =
	            "SELECT * FROM menu WHERE LOWER(category) LIKE ? OR LOWER(itemName) LIKE ?";

	    try {

	        PreparedStatement ps = connection.prepareStatement(query);

	        ps.setString(1, "%" + category.toLowerCase() + "%");
	        ps.setString(2, "%" + category.toLowerCase() + "%");

	        System.out.println("Searching : %" + category.toLowerCase() + "%");

	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {

	            Menu m = new Menu();

	            m.setMenuId(rs.getInt("menuId"));
	            m.setItemName(rs.getString("itemName"));
	            m.setDescription(rs.getString("description"));
	            m.setPrice(rs.getDouble("price"));
	            m.setAvailable(rs.getBoolean("isAvailable"));
	            m.setCategory(rs.getString("category"));
	            m.setRestaurantId(rs.getInt("restaurantId"));
	            m.setImagePath(rs.getString("imagePath"));

	            list.add(m);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return list;
	}
}






