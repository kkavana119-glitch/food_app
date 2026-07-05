package com.food.Model;

public class Menu {
	
	private int menuId;
	private String itemName;
	private String description;
	private double price;
	private boolean isAvailable;
	private String category;
	private int restaurantId;
	private String imagePath;
	
	public Menu() {
		// TODO Auto-generated constructor stub
	}

	
	public Menu(int menuId,  String itemName, String description, double price, boolean isAvailable, String category, int restaurantId, String imagePath) {
		super();
		this.menuId = menuId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.category = category;
		this.restaurantId = restaurantId;
		this.imagePath = imagePath;
	}
	

	public Menu( String itemName, String description, double price, boolean isAvailable, String category,int restaurantId, String imagePath) {
		super();
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.category = category;
		this.restaurantId = restaurantId;
		this.imagePath = imagePath;
	}



	public int getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public int getMenuId() {
		return menuId;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public String getItemName() {
		return itemName;
	}



	public void setItemName(String itemName) {
		this.itemName = itemName;
	}



	public String getDescription() {
		return description;
	}



	public void setDescription(String description) {
		this.description = description;
	}



	public double getPrice() {
		return price;
	}



	public void setPrice(double price) {
		this.price = price;
	}



	public boolean isAvailable() {
		return isAvailable;
	}



	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}



	public String getCategory() {
		return category;
	}



	public void setCategory(String category) {
		this.category = category;
	}
	
	



	@Override
	public String toString() {
		return "Menu [menuId=" + menuId + ", restaurantId=" + restaurantId + ", itemName=" + itemName + ", description="
				+ description + ", price=" + price + ", isAvailable=" + isAvailable + ", category=" + category
				+ ", imagePath=" + imagePath + "]";
	}



	
}
