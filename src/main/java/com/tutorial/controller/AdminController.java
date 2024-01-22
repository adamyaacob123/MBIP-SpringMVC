package com.tutorial.controller;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tutorial.model.User;

import dbUtil.DbConnect;

@Controller
public class AdminController {

	@RequestMapping("/userList")
	public ModelAndView showUserList(@RequestParam(value = "searchQuery", required = false) String searchQuery) {
	    ModelAndView modelAndView = new ModelAndView("adminView/UserList");
	    List<User> users = new ArrayList<>();
	    int participantCount = 0;
	    int adminCount = 0;

	    try (Connection conn = DbConnect.openConnection()) {
	        String sql = "SELECT * FROM user";
	        
	        if (searchQuery != null && !searchQuery.isEmpty()) {
	            sql += " WHERE name LIKE ?";
	        }
	        
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        
	        if (searchQuery != null && !searchQuery.isEmpty()) {
	            stmt.setString(1, "%" + searchQuery + "%");
	        }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNum(rs.getInt("phoneNum"));
                user.setUserLevel(rs.getString("user_level"));
                user.setAddress(rs.getString("address"));
                user.setHousehold(rs.getString("household"));
                user.setPeopleNo(rs.getInt("peopleNo"));
                
                // Fetching the profile_image as Blob and converting it to Base64 string
//                Blob blob = rs.getBlob("profile_image");
//                if (blob != null) {
//                    byte[] blobBytes = blob.getBytes(1, (int) blob.length());
//                    String encodedImage = Base64.getEncoder().encodeToString(blobBytes);
//                    user.setProfile_image(encodedImage);
//                }
                
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

	    for (User user : users) {
	        if ("participant".equals(user.getUserLevel())) {
	            participantCount++;
	        } else if ("admin".equals(user.getUserLevel())) {
	            adminCount++;
	        }
	    }

	    modelAndView.addObject("users", users);
	    modelAndView.addObject("participantCount", participantCount);
	    modelAndView.addObject("adminCount", adminCount);
	    
	   return modelAndView;
    }
	
	@RequestMapping("/userDetails")
    public ModelAndView showUserDetails(@RequestParam("userId") int userId) {
        ModelAndView modelAndView = new ModelAndView("adminView/UserDetails");

        User user = null;
        try (Connection conn = DbConnect.openConnection()) {
            String sql = "SELECT * FROM user WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNum(rs.getInt("phoneNum"));
                user.setUserLevel(rs.getString("user_level"));
                user.setAddress(rs.getString("address"));
                user.setHousehold(rs.getString("household"));
                user.setPeopleNo(rs.getInt("peopleNo"));
                // Fetch and set the profile image if needed
                // Blob blob = rs.getBlob("profile_image");
                // ...
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        modelAndView.addObject("user", user);

        return modelAndView;
    }
	
	@RequestMapping("winnerList")
	public ModelAndView showWinnerList() {
	    return new ModelAndView("adminView/WinnerList");
	}
}
