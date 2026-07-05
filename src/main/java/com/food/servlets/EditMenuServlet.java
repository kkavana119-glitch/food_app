package com.food.servlets;

import java.io.IOException;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.Model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditMenuServlet")

public class EditMenuServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
		
		int id = Integer.parseInt(req.getParameter("id"));

        Menu menu = menuDAOImpl.getMenu(id); // we will create this method

        req.setAttribute("menu", menu);
        
        RequestDispatcher rd = req.getRequestDispatcher("editMenu.jsp");
        rd.forward(req, resp);
        

	}

}
