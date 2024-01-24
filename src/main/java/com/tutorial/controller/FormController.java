package com.tutorial.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tutorial.model.User;

import dbUtil.DbConnect;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;
import java.io.IOException;

@Controller
public class FormController {

    @RequestMapping("/saveWaterForm")
    public ModelAndView saveWaterForm(
            @RequestParam("amount") float amount,
            @RequestParam("period") String period,
            @RequestParam("file") MultipartFile file,
            @RequestParam("year") String year,
            HttpSession session
    ) {
	    ModelAndView modelAndView = new ModelAndView("userViews/formSaved");
	    
	 // Retrieve user information from the session
	 		User user = (User) session.getAttribute("user");

	 		// Check if the user is in the session
	 		if (user != null) {
	 			// Add user information to the model	
	 			modelAndView.addObject("email", user.getEmail());
	 		} else {
	 			// If user is not in the session, handle accordingly (redirect to login, show an
	 			// error, etc.)
	 			modelAndView.addObject("errorMessage", "User not found in the session. Please log in.");
	 		}
	    String email = user.getEmail();
	    
	    
	 // Check if the file isn't empty and convert it to byte array
        byte[] fileBytes = null;
        if (!file.isEmpty()) {
            try {
                fileBytes = file.getBytes();
            } catch (IOException e) {
                e.printStackTrace();
                modelAndView.addObject("message", "Error uploading file: " + e.getMessage());
                return modelAndView;
            }
        }

        // Establish database connection and insert data
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection conn = DbConnect.openConnection();
            String sql = "INSERT INTO water (amount, period, file, email, year, status) VALUES (?, ?, ?, ?, ?, 'pending')";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setFloat(1, amount);
                statement.setString(2, period);
                statement.setBytes(3, fileBytes); // Assuming you have a column to store the file as blob
                statement.setString(4, email);
                statement.setString(5, year);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                	modelAndView.addObject("message", "The form for Water Consumption was submitted successfully!");
                } else {
                    modelAndView.addObject("message", "Failed to insert the form data!");
                }
            }
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "Database error: " + ex.getMessage());
        } catch (ClassNotFoundException ex) {
	        ex.printStackTrace();
	    }

        return modelAndView;
    }
    
    @RequestMapping("/saveElectricForm")
    public ModelAndView saveElectricityForm(
            @RequestParam("amount") float amount,
            @RequestParam("period") String period,
            @RequestParam("year") String year,
            @RequestParam("file") MultipartFile file,
            HttpSession session
    ) {
    	
	    ModelAndView modelAndView = new ModelAndView("userViews/formSaved");
	    
	 // Retrieve user information from the session
 		User user = (User) session.getAttribute("user");

 		// Check if the user is in the session
 		if (user != null) {
 			// Add user information to the model	
 			modelAndView.addObject("email", user.getEmail());
 		} else {
 			// If user is not in the session, handle accordingly (redirect to login, show an
 			// error, etc.)
 			modelAndView.addObject("errorMessage", "User not found in the session. Please log in.");
 		}
 		String email = user.getEmail();
	    
	 // Check if the file isn't empty and convert it to byte array
        byte[] fileBytes = null;
        if (!file.isEmpty()) {
            try {
                fileBytes = file.getBytes();
            } catch (IOException e) {
                e.printStackTrace();
                modelAndView.addObject("message", "Error uploading file: " + e.getMessage());
                return modelAndView;
            }
        }

        // Establish database connection and insert data
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection conn = DbConnect.openConnection();
            String sql = "INSERT INTO water (amount, period, file, email, year, status) VALUES (?, ?, ?, ?, ?, 'pending')";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setFloat(1, amount);
                statement.setString(2, period);
                statement.setBytes(3, fileBytes); // Assuming you have a column to store the file as blob
                statement.setString(4, email);
                statement.setString(5, year);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    modelAndView.addObject("message", "The form for Electric Consumption was submitted successfully!");
                } else {
                    modelAndView.addObject("message", "Failed to insert the form data!");
                }
            }
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "Database error: " + ex.getMessage());
        } catch (ClassNotFoundException ex) {
	        ex.printStackTrace();
	    }

        return modelAndView;
    }
    
    @RequestMapping("/saveWasteForm")
    public ModelAndView saveWasteForm(
            @RequestParam("amount") float amount,
            @RequestParam("period") String period,
            @RequestParam("year") String year,
            @RequestParam("file") MultipartFile file,
            HttpSession session
    ) {
    	
	    ModelAndView modelAndView = new ModelAndView("userViews/formSaved");
	    
	 // Retrieve user information from the session
 		User user = (User) session.getAttribute("user");

 		// Check if the user is in the session
 		if (user != null) {
 			// Add user information to the model	
 			modelAndView.addObject("email", user.getEmail());
 		} else {
 			// If user is not in the session, handle accordingly (redirect to login, show an
 			// error, etc.)
 			modelAndView.addObject("errorMessage", "User not found in the session. Please log in.");
 		}
 		String email = user.getEmail();
	    
	 // Check if the file isn't empty and convert it to byte array
        byte[] fileBytes = null;
        if (!file.isEmpty()) {
            try {
                fileBytes = file.getBytes();
            } catch (IOException e) {
                e.printStackTrace();
                modelAndView.addObject("message", "Error uploading file: " + e.getMessage());
                return modelAndView;
            }
        }

        // Establish database connection and insert data
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection conn = DbConnect.openConnection();
            String sql = "INSERT INTO water (amount, period, file, email, year, status) VALUES (?, ?, ?, ?, ?, 'pending')";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setFloat(1, amount);
                statement.setString(2, period);
                statement.setBytes(3, fileBytes); // Assuming you have a column to store the file as blob
                statement.setString(4, email);
                statement.setString(5, year);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                	modelAndView.addObject("message", "The form for Recycle Weight was submitted successfully!");
                } else {
                    modelAndView.addObject("message", "Failed to insert the form data!");
                }
            }
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "Database error: " + ex.getMessage());
        } catch (ClassNotFoundException ex) {
	        ex.printStackTrace();
	    }

        return modelAndView;
    }
}
