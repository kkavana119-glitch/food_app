package com.food.DAO;

import java.util.List;

import com.food.Model.Orders;

public interface OrdersDAO {
	
	int addOrders(Orders orders);
	Orders getOrders(int ordersId);
	void updateOrders(Orders orders);
	void deleteOrders(int ordersId);
	List<Orders> getAllOrders();
	List<Orders> getOrdersByUserId(int userId);
	Orders getOrderById(int ordersId);
	
}
