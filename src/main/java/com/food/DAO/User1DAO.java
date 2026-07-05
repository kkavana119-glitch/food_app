package com.food.DAO;

import java.util.List;

import com.food.Model.User1;

public interface User1DAO {
	
	int addUser1(User1 user1);
	User1 getUser1(int userId);
	void updateUser1(User1 user1);
	void deleteUser1(int userId);
	List<User1> getAllUsers1();
	User1 validateUser1(String email, String password);
	
	

}
