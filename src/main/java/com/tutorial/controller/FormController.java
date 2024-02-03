package com.tutorial.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tutorial.model.Form;
import com.tutorial.model.User;

import dbUtil.DbConnect;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import java.io.IOException;

@Controller
public class FormController {

	@RequestMapping("/displayWaterForm")
	@ResponseBody()
	public ModelAndView getByEmailWater(HttpSession session) {
		ModelAndView modelandview = new ModelAndView("userViews/dispWaterFormHistory");
		
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection conn = DbConnect.openConnection();

        	// Retrieve user information from the session
	 		User user = (User) session.getAttribute("user");

	 		// Check if the user is in the session
	 		if (user != null) {
	 			// Add user information to the model	
	 			modelandview.addObject("email", user.getEmail());
	 		} else {
	 			// If user is not in the session, handle accordingly (redirect to login, show an
	 			// error, etc.)
	 			modelandview.addObject("errorMessage", "User not found in the session. Please log in.");
	 		}
	 		String email = user.getEmail();
        	
    		
	        String sql = "select * from water where email = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, email);
	        ResultSet rs = ps.executeQuery();
	        List<Form> forms = new ArrayList<>();
	        while (rs.next()) {
				Form form = new Form();
			    form.setWaterYear(rs.getString("year"));
			    form.setWaterPeriod(rs.getString("period"));
			    form.setWaterAmount(rs.getDouble("amount"));
			    form.setWaterFile(rs.getBlob("file"));
			    form.setWaterStatus(rs.getString("status"));
			    // Add more fields as necessary
			    
			    forms.add(form);
			}
	        modelandview.addObject("forms", forms);
	        conn.close();
	    } catch (SQLException ex) {
	        ex.printStackTrace();
	        modelandview.addObject("message", "SQL Error: " + ex.getMessage());
	    } catch (ClassNotFoundException ex) {
	        ex.printStackTrace();
	        modelandview.addObject("message", "JDBC Driver not found: " + ex.getMessage());
	    }

	    return modelandview;
	}
	
	@RequestMapping("/updateCarbonWater")
	@ResponseBody()	
	public ModelAndView updateWater() {
        ModelAndView modelAndView = new ModelAndView("userViews/updateCarbonWater"); // Name of the JSP file for the response
        modelAndView.addObject("currentCategory", "water");
        return modelAndView;
    }
	
	@RequestMapping("/updateWaterForm")
    public ModelAndView updateWaterForm(
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
            String sql = "UPDATE water set amount = ?, file = ? WHERE year = ? and period = ? and email = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setFloat(1, amount);
                statement.setBytes(2, fileBytes);
                statement.setString(3, year);  // Assuming you have a column to store the file as blob
                statement.setString(4, period);
                statement.setString(5, email);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                	modelAndView.addObject("message", "The form for Water Consumption was updated successfully!");
                } else {
                    modelAndView.addObject("message", "Failed to update the form data!");
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
	
	@RequestMapping("/deleteCarbonWater")
	@ResponseBody()	
	public ModelAndView deleteWaterForm(HttpServletRequest request, RedirectAttributes redirectAttributes, HttpSession session, Model model) {
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
        String year = request.getParameter("year");
        String period = request.getParameter("period");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DbConnect.openConnection();
            String sql = "DELETE FROM water WHERE year = ? and period = ? and email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, year);
            stmt.setString(2, period);
            stmt.setString(3, email);

            int rowAffected = stmt.executeUpdate();
            
            if(rowAffected == 0) {
            	redirectAttributes.addFlashAttribute("message", "Form not found. Please try again.");
            }
            else {
            	redirectAttributes.addFlashAttribute("message", "Water Form for <span style=\"text-transform:uppercase\">" + period + "</span>, " + year + " was deleted successfully.");
            	model.addAttribute("message", "Water Form for <span style=\"text-transform:uppercase\">" + period + "</span>, " + year + " was deleted successfully.");
            	model.addAttribute("category", "water");
            }
            
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "SQL Error: " + ex.getMessage());
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "JDBC Driver not found: " + ex.getMessage());
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "Invalid input format.");
        }

        return modelAndView;
    }
	
	@RequestMapping("/displayElectricForm")
	@ResponseBody()
	public ModelAndView getByEmailElectric(HttpSession session) {
		ModelAndView modelandview = new ModelAndView("userViews/dispElectricFormHistory");
		
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection conn = DbConnect.openConnection();

        	// Retrieve user information from the session
	 		User user = (User) session.getAttribute("user");

	 		// Check if the user is in the session
	 		if (user != null) {
	 			// Add user information to the model	
	 			modelandview.addObject("email", user.getEmail());
	 		} else {
	 			// If user is not in the session, handle accordingly (redirect to login, show an
	 			// error, etc.)
	 			modelandview.addObject("errorMessage", "User not found in the session. Please log in.");
	 		}
	 		String email = user.getEmail();
        	
    		
	        String sql = "select * from electric where email = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, email);
	        ResultSet rs = ps.executeQuery();
	        List<Form> forms = new ArrayList<>();
	        while (rs.next()) {
				Form form = new Form();
			    form.setElectricYear(rs.getString("year"));
			    form.setElectricPeriod(rs.getString("period"));
			    form.setElectricAmount(rs.getDouble("amount"));
			    form.setElectricFile(rs.getBlob("file"));	
			    form.setElectricStatus(rs.getString("status"));
			    // Add more fields as necessary
			    
			    forms.add(form);
			}
	        modelandview.addObject("forms", forms);
	        conn.close();
	    } catch (SQLException ex) {
	        ex.printStackTrace();
	        modelandview.addObject("message", "SQL Error: " + ex.getMessage());
	    } catch (ClassNotFoundException ex) {
	        ex.printStackTrace();
	        modelandview.addObject("message", "JDBC Driver not found: " + ex.getMessage());
	    }

	    return modelandview;
	}
	
	@RequestMapping("/updateCarbonElectric")
	@ResponseBody()	
	public ModelAndView updateElectric() {
        ModelAndView modelAndView = new ModelAndView("userViews/updateCarbonElectric"); // Name of the JSP file for the response
        modelAndView.addObject("currentCategory", "electric");
        return modelAndView;
    }
	
	@RequestMapping("/updateElectricForm")
    public ModelAndView updateElectricForm(
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
            String sql = "UPDATE electric set amount = ?, file = ? WHERE year = ? and period = ? and email = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setFloat(1, amount);
                statement.setBytes(2, fileBytes);
                statement.setString(3, year);  // Assuming you have a column to store the file as blob
                statement.setString(4, period);
                statement.setString(5, email);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                	modelAndView.addObject("message", "The form for Electricity Consumption was updated successfully!");
                } else {
                    modelAndView.addObject("message", "Failed to update the form data!");
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
	
	@RequestMapping("/deleteCarbonElectric")
	@ResponseBody()	
	public ModelAndView deleteElectricForm(HttpServletRequest request, RedirectAttributes redirectAttributes, HttpSession session, Model model) {
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
        String year = request.getParameter("year");
        String period = request.getParameter("period");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DbConnect.openConnection();
            String sql = "DELETE FROM electric WHERE year = ? and period = ? and email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, year);
            stmt.setString(2, period);
            stmt.setString(3, email);

            int rowAffected = stmt.executeUpdate();
            
            if(rowAffected == 0) {
            	redirectAttributes.addFlashAttribute("message", "Form not found. Please try again.");
            }
            else {
            	redirectAttributes.addFlashAttribute("message", "Electric Form for <span style=\"text-transform:uppercase\">" + period + "</span>, " + year + " was deleted successfully.");
            	model.addAttribute("message", "Electric Form for <span style=\"text-transform:uppercase\">" + period + "</span>, " + year + " was deleted successfully.");
            	model.addAttribute("category", "electric");
            }
            
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "SQL Error: " + ex.getMessage());
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "JDBC Driver not found: " + ex.getMessage());
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "Invalid input format.");
        }

        return modelAndView;
    }
	
	@RequestMapping("/displayWasteForm")
	@ResponseBody()
	public ModelAndView getByEmailWaste(HttpSession session) {
		ModelAndView modelandview = new ModelAndView("userViews/dispWasteFormHistory");
		
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection conn = DbConnect.openConnection();

        	// Retrieve user information from the session
	 		User user = (User) session.getAttribute("user");

	 		// Check if the user is in the session
	 		if (user != null) {
	 			// Add user information to the model	
	 			modelandview.addObject("email", user.getEmail());
	 		} else {
	 			// If user is not in the session, handle accordingly (redirect to login, show an
	 			// error, etc.)
	 			modelandview.addObject("errorMessage", "User not found in the session. Please log in.");
	 		}
	 		String email = user.getEmail();
        	
    		
	        String sql = "select * from waste where email = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, email);
	        ResultSet rs = ps.executeQuery();
	        List<Form> forms = new ArrayList<>();
	        while (rs.next()) {
				Form form = new Form();
			    form.setWasteYear(rs.getString("year"));
			    form.setWastePeriod(rs.getString("period"));
			    form.setWasteAmount(rs.getDouble("amount"));
			    form.setWasteFile(rs.getBlob("file"));
			    form.setWasteStatus(rs.getString("status"));
			    // Add more fields as necessary
			    
			    forms.add(form);
			}
	        modelandview.addObject("forms", forms);
	        conn.close();
	    } catch (SQLException ex) {
	        ex.printStackTrace();
	        modelandview.addObject("message", "SQL Error: " + ex.getMessage());
	    } catch (ClassNotFoundException ex) {
	        ex.printStackTrace();
	        modelandview.addObject("message", "JDBC Driver not found: " + ex.getMessage());
	    }

	    return modelandview;
	}
	
	@RequestMapping("/updateCarbonWaste")
	@ResponseBody()	
	public ModelAndView updateWaste() {
        ModelAndView modelAndView = new ModelAndView("userViews/updateCarbonWaste"); // Name of the JSP file for the response
        modelAndView.addObject("currentCategory", "waste");
        return modelAndView;
    }
	
	@RequestMapping("/updateWasteForm")
    public ModelAndView updateWasteForm(
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
            String sql = "UPDATE waste set amount = ?, file = ? WHERE year = ? and period = ? and email = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setFloat(1, amount);
                statement.setBytes(2, fileBytes);
                statement.setString(3, year);  // Assuming you have a column to store the file as blob
                statement.setString(4, period);
                statement.setString(5, email);

                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                	modelAndView.addObject("message", "The form for Recycle Weight Consumption was updated successfully!");
                } else {
                    modelAndView.addObject("message", "Failed to update the form data!");
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
	
	@RequestMapping("/deleteCarbonWaste")
	@ResponseBody()	
	public ModelAndView deleteWasteForm(HttpServletRequest request, RedirectAttributes redirectAttributes, HttpSession session, Model model) {
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
        String year = request.getParameter("year");
        String period = request.getParameter("period");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DbConnect.openConnection();
            String sql = "DELETE FROM waste WHERE year = ? and period = ? and email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, year);
            stmt.setString(2, period);
            stmt.setString(3, email);

            int rowAffected = stmt.executeUpdate();
            
            if(rowAffected == 0) {
            	redirectAttributes.addFlashAttribute("message", "Recycle Weight Form not found. Please try again.");
            }
            else {
            	redirectAttributes.addFlashAttribute("message", "Recycle Weight Form for <span style=\"text-transform:uppercase\">" + period + "</span>, " + year + " was deleted successfully.");
            	model.addAttribute("message", "Recycle Weight Form for <span style=\"text-transform:uppercase\">" + period + "</span>, " + year + " was deleted successfully.");
            	model.addAttribute("category", "waste");
            }
            
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "SQL Error: " + ex.getMessage());
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "JDBC Driver not found: " + ex.getMessage());
        } catch (NumberFormatException ex) {
            ex.printStackTrace();
            modelAndView.addObject("message", "Invalid input format.");
        }

        return modelAndView;
    }
	
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
            String sql = "INSERT INTO electric (amount, period, file, email, year, status) VALUES (?, ?, ?, ?, ?, 'pending')";
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
            String sql = "INSERT INTO waste (amount, period, file, email, year, status) VALUES (?, ?, ?, ?, ?, 'pending')";
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
