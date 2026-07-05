package com.food.DAO;

import java.util.List;

import com.food.Model.OrderItem;
import com.food.Model.Orders;

public interface OrderItemDAO {
	
	void addOrderItem(OrderItem orderitem);
	OrderItem getOrderItem(int orderItemId);
	void updateOrderItem(OrderItem orderitem);
	void deleteOrderItem(int orderItemId);
	List<OrderItem> getAllOrderItem();
	

}
