package com.food.Model;

public class OrderItem {
	
	private int orderItemId;
	private int ordersId;
	private int quantity;
	private double itemTotal;
	private int menuId;
	
	public OrderItem() {
		// TODO Auto-generated constructor stub
	}
	
	

	public OrderItem(int orderItemId,int ordersId, int quantity, double itemTotal,int menuId) {
		super();
		this.orderItemId = orderItemId;
		this.ordersId = ordersId;
		this.quantity = quantity;
		this.itemTotal = itemTotal;
		this.menuId = menuId;
	}
	


	public OrderItem(int ordersId,int quantity, double itemTotal,int menuId) {
		super();
		this.ordersId = ordersId;
		this.quantity = quantity;
		this.itemTotal = itemTotal;
		this.menuId = menuId;
	}



	public int getOrderItemId() {
		return orderItemId;
	}



	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}



	public int getQuantity() {
		return quantity;
	}



	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}



	public double getItemTotal() {
		return itemTotal;
	}



	public void setItemTotal(double itemTotal) {
		this.itemTotal = itemTotal;
	}

	

	public int getOrdersId() {
		return ordersId;
	}



	public void setOrdersId(int ordersId) {
		this.ordersId = ordersId;
	}



	public int getMenuId() {
		return menuId;
	}



	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}



	@Override
	public String toString() {
		return "OrderItem [orderItemId=" + orderItemId + ", ordersId=" + ordersId + ", quantity=" + quantity
				+ ", itemTotal=" + itemTotal + ", menuId=" + menuId + "]";
	}



}
