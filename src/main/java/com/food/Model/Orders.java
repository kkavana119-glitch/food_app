package com.food.Model;

import java.sql.Timestamp;

public class Orders {
	
	private int ordersId;
	private int userId;
	private Timestamp ordersDate;
	private double totalAmount;
	private String status;
	private String paymentMethod;
	private int restaurantId;
	
	public Orders() {

	}
	

	public Orders(int ordersId,int userId, Timestamp ordersDate, double totalAmount, String status, String paymentMethod, int restaurantId) {
		super();
		this.ordersId = ordersId;
		this.userId = userId;
		this.ordersDate = ordersDate;
		this.totalAmount = totalAmount;
		this.status = status;
		this.paymentMethod = paymentMethod;
		this.restaurantId = restaurantId;
	}
	
	public Orders(int userId, Timestamp ordersDate, double totalAmount, String status, String paymentMethod, int restaurantId){
		super();
		this.userId = userId;
		this.ordersDate = ordersDate;
		this.totalAmount = totalAmount;
		this.status = status;
		this.paymentMethod = paymentMethod;
		this.restaurantId = restaurantId;
	}
	

	public Orders( double totalAmount, String status, String paymentMethod) {
		super();
		this.totalAmount = totalAmount;
		this.status = status;
		this.paymentMethod = paymentMethod;
	}
	

	public int getOrdersId() {
		return ordersId;
	}


	public void setOrdersId(int ordersId) {
		this.ordersId = ordersId;
	}


	public Timestamp getOrdersDate() {
		return ordersDate;
	}


	public void setOrdersDate(Timestamp ordersDate) {
		this.ordersDate = ordersDate;
	}


	public double getTotalAmount() {
		return totalAmount;
	}


	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getPaymentMethod() {
		return paymentMethod;
	}


	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}


	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getRestaurantId() {
		return restaurantId;
	}


	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}


	@Override
	public String toString() {
		return "Orders [ordersId=" + ordersId + ", userId=" + userId + ", ordersDate=" + ordersDate + ", totalAmount="
				+ totalAmount + ", status=" + status + ", paymentMethod=" + paymentMethod + ", restaurantId="
				+ restaurantId + "]";
	}


}
