package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.Model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/MenuManagementServlet")

public class MenuManagementServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		

		 MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
		 
		 String action = req.getParameter("action");

	        // DELETE
	        if ("delete".equals(action)) {

	            int id = Integer.parseInt(req.getParameter("id"));

	            menuDAOImpl.deleteMenu(id);

	            resp.sendRedirect(req.getContextPath() + "/MenuManagementServlet");
	            return;
	        }
	     

	        // LOAD ALL MENU ITEMS
	        List<Menu> menuList = menuDAOImpl.getAllMenus();

	        req.setAttribute("menuList", menuList);
	        
	        RequestDispatcher rd = req.getRequestDispatcher("menuManagement.jsp");
	        rd.forward(req, resp);
	    
	}
	

}
