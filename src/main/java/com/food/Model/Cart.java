package com.food.Model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
	
	static Map<Integer, CartItem> items;
	
	public Cart() {

		 items = new HashMap<Integer, CartItem>();
	}
	
	public Map<Integer, CartItem> getItems() {
		return items;
	}

	public static void addItem(CartItem cartItem) {

		int menuId = cartItem.getMenuId();
		
		if(items.containsKey(menuId)) {
			CartItem existingCartItem = items.get(menuId);
			existingCartItem.setQuantity(existingCartItem.getQuantity() + 1);
		}
		else {
			
			items.put(menuId, cartItem);
		}
	}

	public void updateItem(int itemId, int quantity) {
		
		if(items.containsKey(itemId)) {
			
			if(quantity > 0) {
				
				CartItem existingItem = items.get(itemId);
				existingItem.setQuantity(quantity);
			}
			else {
				items.remove(itemId);
			}
		}
	}

	public void removeItem(int itemId) {
		
		items.remove(itemId);
	}
}
