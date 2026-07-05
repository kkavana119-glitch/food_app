package com.food.Model;

import java.sql.Timestamp;

public class User1 {
	
	private int id;
	private String name;
	private String email;
	private String phone;
	private String password;
	private String confirmpassword;
	
	public User1() {
		// TODO Auto-generated constructor stub
	}
	
	public User1(String name, String email, String phone, String password,String confirmpassword) {
		super();
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.password = password;
		this.confirmpassword = confirmpassword;
	}
	
	
	
	
	public User1(int id, String name, String email, String phone, String password, String confirmpassword) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.password = password;
		this.confirmpassword = confirmpassword;
	}

	public User1(String email, String password,String confirmpassword) {
		super();
		this.email = email;
		this.password = password;
		this.confirmpassword = confirmpassword;
	}

	
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	
	public String getConfirmpassword() {
		return confirmpassword;
	}

	public void setConfirmpassword(String confirmpassword) {
		this.confirmpassword = confirmpassword;
	}

	@Override
	public String toString() {
		return "User1 [id=" + id + ", name=" + name + ", email=" + email + ", phone=" + phone + ", password=" + password
				+ ", confirmpassword=" + confirmpassword + "]";
	}
	
	
	

}
