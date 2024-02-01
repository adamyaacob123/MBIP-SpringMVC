package com.tutorial.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tutorial.model.User;

import dbUtil.DbConnect;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReportController {
	@RequestMapping("/displayReport")
    public String displayReport(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login"; 
        }
        return "redirect:/getReport?id=" + userId;
    }
	
	
	@RequestMapping("/Report")
	public ModelAndView getReport(
			HttpServletRequest request,
			@RequestParam("id") int userId,
			@RequestParam("year") String year) {
		 
		User user = null;
		List<Float> waterAmounts = new ArrayList<>();
        List<Float> electricAmounts = new ArrayList<>();
        List<Float> recycleAmounts = new ArrayList<>();
        List<String> availableMonthsWater = new ArrayList<>();
        List<String> availableMonthsElectric = new ArrayList<>();
        List<String> availableMonthsRecycle = new ArrayList<>();

        try (Connection conn = DbConnect.openConnection()) {
        	 String sqlUserDetails = "SELECT * FROM user WHERE id = ?";
             PreparedStatement stmtUserDetails = conn.prepareStatement(sqlUserDetails);
             stmtUserDetails.setInt(1, userId);

             ResultSet rsUserDetails = stmtUserDetails.executeQuery();

             if (rsUserDetails.next()) {
            	 user = new User();
                 user.setId(rsUserDetails.getInt("id"));
                 user.setEmail(rsUserDetails.getString("email"));
                 
             }
             
             String sqlWaterData = "SELECT amount, period FROM water WHERE email = ? AND year = ? ORDER BY " + getMonthOrderCaseStatement();
             PreparedStatement stmtWaterData = conn.prepareStatement(sqlWaterData);
             stmtWaterData.setString(1, user.getEmail());
             stmtWaterData.setString(2, year); 
             ResultSet rsWaterData = stmtWaterData.executeQuery();
             while (rsWaterData.next()) {
                 availableMonthsWater.add(rsWaterData.getString("period"));
                 waterAmounts.add(rsWaterData.getFloat("amount"));
             }

             String sqlElectricData = "SELECT amount, period FROM electric WHERE email = ? AND year = ? ORDER BY " + getMonthOrderCaseStatement();
             PreparedStatement stmtElectricData = conn.prepareStatement(sqlElectricData);
             stmtElectricData.setString(1, user.getEmail());
             stmtElectricData.setString(2, year);
             ResultSet rsElectricData = stmtElectricData.executeQuery();
             while (rsElectricData.next()) {
                 availableMonthsElectric.add(rsElectricData.getString("period"));
                 electricAmounts.add(rsElectricData.getFloat("amount"));
             }
             
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
        
        float totalWater = 0f;
        float totalElectricity = 0f;
        float totalRecycle = 0f;

        for (Float amount : waterAmounts) {
            totalWater += amount;
        }
        for (Float amount : electricAmounts) {
            totalElectricity += amount;
        }
        for (Float amount : recycleAmounts) {
            totalRecycle += amount;
        }
        
        float waterCarbonFactor = 0.419f; 
        float electricityCarbonFactor = 0.584f; 
        float recycleCarbonFactor = 2.860f; 

        float totalWaterFootprint = totalWater * waterCarbonFactor;
        float totalElectricityFootprint = totalElectricity * electricityCarbonFactor;
        float totalRecycleFootprint = totalRecycle * recycleCarbonFactor;
        
        float totalCarbonFootprint = totalWaterFootprint + totalElectricityFootprint + totalRecycleFootprint;

		ModelAndView modelAndView = new ModelAndView("userViews/report");
        
        modelAndView.addObject("user", user);
        modelAndView.addObject("selectedYear", year);
        
        modelAndView.addObject("waterAmounts", waterAmounts);
        modelAndView.addObject("electricAmounts", electricAmounts);
        modelAndView.addObject("recycleAmounts", recycleAmounts);
        modelAndView.addObject("monthsWater", availableMonthsWater);
        modelAndView.addObject("monthsElectric", availableMonthsElectric);
        modelAndView.addObject("monthsRecycle", availableMonthsRecycle);
        
        modelAndView.addObject("totalWater", totalWater);
        modelAndView.addObject("totalElectricity", totalElectricity);
        modelAndView.addObject("totalRecycle", totalRecycle);
        modelAndView.addObject("totalWaterFootprint", totalWaterFootprint);
        modelAndView.addObject("totalElectricityFootprint", totalElectricityFootprint);
        modelAndView.addObject("totalRecycleFootprint", totalRecycleFootprint);
        modelAndView.addObject("totalCarbonFootprint", totalCarbonFootprint);
        
        return modelAndView;
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
