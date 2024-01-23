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

<<<<<<< Updated upstream
	@RequestMapping("/userList")
    public ModelAndView showUserList() {
		ModelAndView modelAndView = new ModelAndView("adminViews/UserList"); // Use your JSP file name
=======
    @RequestMapping("/userList")
    public ModelAndView showUserList(@RequestParam(value = "searchQuery", required = false) String searchQuery) {
        ModelAndView modelAndView = new ModelAndView("adminViews/UserList");
>>>>>>> Stashed changes
        List<User> users = new ArrayList<>();

        try (Connection conn = DbConnect.openConnection()) {
            String sql = "SELECT id, name, email, phoneNum, user_level FROM user";
            PreparedStatement stmt = conn.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNum(rs.getInt("phoneNum"));
                user.setUserLevel(rs.getString("user_level"));
                // Add more fields as needed
                
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

        modelAndView.addObject("users", users);
        
        return modelAndView;
    }
	
	@RequestMapping("/userDetails")
    public ModelAndView showUserDetails(@RequestParam("userId") int userId) {
        ModelAndView modelAndView = new ModelAndView("adminViews/UserDetails");

        User user = null;
        try (Connection conn = DbConnect.openConnection()) {
            String sql = "SELECT id, name, email, phoneNum, user_level FROM user WHERE id = ?";
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
	
	@RequestMapping("/winnerList")
	public ModelAndView showWinnerList() {
	    return new ModelAndView("adminViews/WinnerList");
	}
}
