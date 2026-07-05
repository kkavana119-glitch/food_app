package com.food.servlets;

import java.io.File;
import java.io.IOException;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.Model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UpdateMenuServlet")
@MultipartConfig

public class UpdateMenuServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	
		
		MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
		
		String menuIdStr = req.getParameter("menuId");

		System.out.println("menuId = " + menuIdStr);

		if (menuIdStr == null || menuIdStr.trim().isEmpty()) {
		    System.out.println("Error: menuId is missing!");
		    return;
		}

		   int menuId = Integer.parseInt(menuIdStr);
		   System.out.println("MENU ID = " + menuId);
//		 int id = Integer.parseInt(req.getParameter("menuId"));
	        String name = req.getParameter("itemName");
	        String desc = req.getParameter("description");
	        String category = req.getParameter("category");
	        double price = Double.parseDouble(req.getParameter("price"));
	        boolean available = Boolean.parseBoolean(req.getParameter("available"));
	        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

	        Menu m = new Menu();
	        m.setMenuId(menuId);
	        m.setItemName(name);
	        m.setDescription(desc);
	        m.setCategory(category);
	        m.setPrice(price);
	        m.setAvailable(available);
	        m.setRestaurantId(restaurantId);

	       
	        
	        Part part = req.getPart("image");

	        String imageUrl = req.getParameter("imageUrl");
	        String imagePath = req.getParameter("existingImage");

	        // First preference: Image URL
	        if (imageUrl != null && !imageUrl.trim().isEmpty()) {

	            imagePath = imageUrl.trim();

	        }
	        // Second preference: Uploaded file
	        else if (part != null && part.getSize() > 0
	                && part.getSubmittedFileName() != null
	                && !part.getSubmittedFileName().isEmpty()) {

	            String fileName = part.getSubmittedFileName();

	            String uploadPath = getServletContext().getRealPath("") + "images";

	            File folder = new File(uploadPath);

	            if (!folder.exists()) {
	                folder.mkdir();
	            }

	            part.write(uploadPath + File.separator + fileName);

	            imagePath = "images/" + fileName;

	        }
	        // Third preference: Keep existing image
	        else {

	            imagePath = req.getParameter("existingImage");

	        }

			m.setImagePath(imagePath);
			
			 menuDAOImpl.updateMenu(m);
			 System.out.println("IMAGE = " + m.getImagePath());

	        resp.sendRedirect("MenuManagementServlet");
	}

}
