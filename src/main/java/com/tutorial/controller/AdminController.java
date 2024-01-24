package com.tutorial.controller;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
        ModelAndView modelAndView = new ModelAndView("adminViews/UserList");
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
                // Blob blob = rs.getBlob("profile_image");
                // if (blob != null) {
                // byte[] blobBytes = blob.getBytes(1, (int) blob.length());
                // String encodedImage = Base64.getEncoder().encodeToString(blobBytes);
                // user.setProfile_image(encodedImage);
                // }

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
    public ModelAndView showUserDetails(@RequestParam("userId") int userId, @RequestParam(value = "year", required = false) String year) {
        ModelAndView modelAndView = new ModelAndView("adminViews/UserDetails");

        User user = null;
        List<Float> waterAmounts = new ArrayList<>();
        List<Float> electricAmounts = new ArrayList<>();
        List<Float> recycleAmounts = new ArrayList<>();
        List<String> availableMonthsWater = new ArrayList<>();
        List<String> availableMonthsElectric = new ArrayList<>();
        List<String> availableMonthsRecycle = new ArrayList<>();

        try (Connection conn = DbConnect.openConnection()) {
            // Retrieve user details
            String sqlUserDetails = "SELECT * FROM user WHERE id = ?";
            PreparedStatement stmtUserDetails = conn.prepareStatement(sqlUserDetails);
            stmtUserDetails.setInt(1, userId);

            ResultSet rsUserDetails = stmtUserDetails.executeQuery();

            if (rsUserDetails.next()) {
                user = new User();
                user.setId(rsUserDetails.getInt("id"));
                user.setName(rsUserDetails.getString("name"));
                user.setEmail(rsUserDetails.getString("email"));
                user.setPhoneNum(rsUserDetails.getInt("phoneNum"));
                user.setUserLevel(rsUserDetails.getString("user_level"));
                user.setAddress(rsUserDetails.getString("address"));
                user.setHousehold(rsUserDetails.getString("household"));
                user.setPeopleNo(rsUserDetails.getInt("peopleNo"));
                // Fetch and set the profile image if needed
                // Blob blob = rsUserDetails.getBlob("profile_image");
                // ...
            }

            // Retrieve water consumption data
            String sqlWaterData = "SELECT amount, period FROM water WHERE email = ? AND year = ? ORDER BY " + getMonthOrderCaseStatement();
            PreparedStatement stmtWaterData = conn.prepareStatement(sqlWaterData);
            stmtWaterData.setString(1, user.getEmail());
            stmtWaterData.setString(2, year); // Set the year parameter in the query

            ResultSet rsWaterData = stmtWaterData.executeQuery();
            while (rsWaterData.next()) {
                availableMonthsWater.add(rsWaterData.getString("period"));
                waterAmounts.add(rsWaterData.getFloat("amount"));
            }
            
            // Retrieve electricity consumption data
            String sqlElectricData = "SELECT amount, period FROM electric WHERE email = ? AND year = ? ORDER BY " + getMonthOrderCaseStatement();
            PreparedStatement stmtElectricData = conn.prepareStatement(sqlElectricData);
            stmtElectricData.setString(1, user.getEmail());
            stmtElectricData.setString(2, year);
            ResultSet rsElectricData = stmtElectricData.executeQuery();
            while (rsElectricData.next()) {
                availableMonthsElectric.add(rsElectricData.getString("period"));
                electricAmounts.add(rsElectricData.getFloat("amount"));
            }

            // Retrieve recycle data
            String sqlRecycleData = "SELECT amount, period FROM waste WHERE email = ? AND year = ? ORDER BY " + getMonthOrderCaseStatement();
            PreparedStatement stmtRecycleData = conn.prepareStatement(sqlRecycleData);
            stmtRecycleData.setString(1, user.getEmail());
            stmtRecycleData.setString(2, year);
            ResultSet rsRecycleData = stmtRecycleData.executeQuery();
            while (rsRecycleData.next()) {
                availableMonthsRecycle.add(rsRecycleData.getString("period"));
                recycleAmounts.add(rsRecycleData.getFloat("amount"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        modelAndView.addObject("user", user);
        modelAndView.addObject("waterAmounts", waterAmounts);
        modelAndView.addObject("electricAmounts", electricAmounts);
        modelAndView.addObject("recycleAmounts", recycleAmounts);
        modelAndView.addObject("monthsWater", availableMonthsWater);
        modelAndView.addObject("monthsElectric", availableMonthsElectric);
        modelAndView.addObject("monthsRecycle", availableMonthsRecycle);
        modelAndView.addObject("selectedYear", year);

        return modelAndView;
    }



    @RequestMapping("/validateParticipant")
    public ModelAndView validateParticipant(@RequestParam("userId") int userId) {
        ModelAndView modelAndView = new ModelAndView("adminViews/ValidateParticipant");
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
        // Add other attributes as needed for the validation process

        return modelAndView;
    }

    @RequestMapping("/winnerList")
    public ModelAndView showWinnerList() {
        return new ModelAndView("adminViews/WinnerList");
    }
    
    private String getMonthOrderCaseStatement() {
        return "CASE period " +
               "WHEN 'Jan' THEN 1 " +
               "WHEN 'Feb' THEN 2 " +
               "WHEN 'Mar' THEN 3 " +
               "WHEN 'Apr' THEN 4 " +
               "WHEN 'May' THEN 5 " +
               "WHEN 'Jun' THEN 6 " +
               "WHEN 'Jul' THEN 7 " +
               "WHEN 'Aug' THEN 8 " +
               "WHEN 'Sep' THEN 9 " +
               "WHEN 'Oct' THEN 10 " +
               "WHEN 'Nov' THEN 11 " +
               "WHEN 'Dec' THEN 12 " +
               "END";
    }
}
