package com.tutorial.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tutorial.model.MonthData;
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

                // Fetching the profile image as Blob and converting it to Base64 string
                Blob blob = rs.getBlob("profile_image");
                String base64Image = null;
                if (blob != null) {
                    byte[] blobBytes = blob.getBytes(1, (int) blob.length());
                    base64Image = Base64.getEncoder().encodeToString(blobBytes);
                }
                user.setProfileImageBase64(base64Image);

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
    public ModelAndView showUserDetails(@RequestParam("userId") int userId,
            @RequestParam(value = "year", required = false) String year) {
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
                // Fetching the profile image as Blob and converting it to Base64 string
                Blob blob = rsUserDetails.getBlob("profile_image");
                String base64Image = null;
                if (blob != null) {
                    byte[] blobBytes = blob.getBytes(1, (int) blob.length());
                    base64Image = Base64.getEncoder().encodeToString(blobBytes);
                }
                user.setProfileImageBase64(base64Image);

            }
            // Retrieve water consumption data
            String sqlWaterData = "SELECT amount, period FROM water WHERE email = ? AND year = ? ORDER BY "
                    + getMonthOrderCaseStatement();
            PreparedStatement stmtWaterData = conn.prepareStatement(sqlWaterData);
            stmtWaterData.setString(1, user.getEmail());
            stmtWaterData.setString(2, year); // Set the year parameter in the query

            ResultSet rsWaterData = stmtWaterData.executeQuery();
            while (rsWaterData.next()) {
                availableMonthsWater.add(rsWaterData.getString("period"));
                waterAmounts.add(rsWaterData.getFloat("amount"));
            }

            // Retrieve electricity consumption data
            String sqlElectricData = "SELECT amount, period FROM electric WHERE email = ? AND year = ? ORDER BY "
                    + getMonthOrderCaseStatement();
            PreparedStatement stmtElectricData = conn.prepareStatement(sqlElectricData);
            stmtElectricData.setString(1, user.getEmail());
            stmtElectricData.setString(2, year);
            ResultSet rsElectricData = stmtElectricData.executeQuery();
            while (rsElectricData.next()) {
                availableMonthsElectric.add(rsElectricData.getString("period"));
                electricAmounts.add(rsElectricData.getFloat("amount"));
            }

            // Retrieve recycle data
            String sqlRecycleData = "SELECT amount, period FROM waste WHERE email = ? AND year = ? ORDER BY "
                    + getMonthOrderCaseStatement();
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

        // Calculate totals
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

        // Calculate the carbon footprints
        float waterCarbonFactor = 0.419f; // Example carbon factor for water
        float electricityCarbonFactor = 0.584f; // Example carbon factor for electricity
        float recycleCarbonFactor = 2.860f; // Example carbon factor for recycle

        float totalWaterFootprint = totalWater * waterCarbonFactor;
        float totalElectricityFootprint = totalElectricity * electricityCarbonFactor;
        float totalRecycleFootprint = totalRecycle * recycleCarbonFactor;

        // Calculate the total carbon footprint
        float totalCarbonFootprint = totalWaterFootprint + totalElectricityFootprint + totalRecycleFootprint;

        modelAndView.addObject("user", user);
        modelAndView.addObject("selectedYear", year);

        // Graphs
        modelAndView.addObject("waterAmounts", waterAmounts);
        modelAndView.addObject("electricAmounts", electricAmounts);
        modelAndView.addObject("recycleAmounts", recycleAmounts);
        modelAndView.addObject("monthsWater", availableMonthsWater);
        modelAndView.addObject("monthsElectric", availableMonthsElectric);
        modelAndView.addObject("monthsRecycle", availableMonthsRecycle);

        // Calculation
        modelAndView.addObject("totalWater", totalWater);
        modelAndView.addObject("totalElectricity", totalElectricity);
        modelAndView.addObject("totalRecycle", totalRecycle);
        modelAndView.addObject("totalWaterFootprint", totalWaterFootprint);
        modelAndView.addObject("totalElectricityFootprint", totalElectricityFootprint);
        modelAndView.addObject("totalRecycleFootprint", totalRecycleFootprint);
        modelAndView.addObject("totalCarbonFootprint", totalCarbonFootprint);

        return modelAndView;
    }

    @RequestMapping("/validateParticipant")
    public ModelAndView validateParticipant(@RequestParam("userId") int userId,
            @RequestParam(value = "year", required = false) String year) {
        ModelAndView modelAndView = new ModelAndView("adminViews/ValidateParticipant");

        User user = null;
        List<MonthData> waterDataPerMonth = new ArrayList<>();
        List<MonthData> electricDataPerMonth = new ArrayList<>();
        List<MonthData> recycleDataPerMonth = new ArrayList<>();

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
                // Fetching the profile image as Blob and converting it to Base64 string
                Blob blob = rs.getBlob("profile_image");
                String base64Image = null;
                if (blob != null) {
                    byte[] blobBytes = blob.getBytes(1, (int) blob.length());
                    base64Image = Base64.getEncoder().encodeToString(blobBytes);
                }
                user.setProfileImageBase64(base64Image);
            }

            // Retrieve water consumption data for each month
            String sqlWaterData = "SELECT * FROM water WHERE email = ? AND year = ? ORDER BY "
                    + getMonthOrderCaseStatement();
            PreparedStatement stmtWaterData = conn.prepareStatement(sqlWaterData);
            stmtWaterData.setString(1, user.getEmail());
            stmtWaterData.setString(2, year);

            ResultSet rsWaterData = stmtWaterData.executeQuery();
            while (rsWaterData.next()) {
                String month = rsWaterData.getString("period");
                float amount = rsWaterData.getFloat("amount");
                String status = rsWaterData.getString("status");

                Blob imageBlob = rsWaterData.getBlob("file");
                String base64Image = convertBlobToBase64(imageBlob);

                MonthData waterMonthData = new MonthData(month, amount, base64Image, status);
                waterDataPerMonth.add(waterMonthData);
            }

            // Retrieve electricity consumption data for each month
            String sqlElectricData = "SELECT * FROM electric WHERE email = ? AND year = ? ORDER BY "
                    + getMonthOrderCaseStatement();
            PreparedStatement stmtElectricData = conn.prepareStatement(sqlElectricData);
            stmtElectricData.setString(1, user.getEmail());
            stmtElectricData.setString(2, year);

            ResultSet rsElectricData = stmtElectricData.executeQuery();
            while (rsElectricData.next()) {
                String month = rsElectricData.getString("period");
                float amount = rsElectricData.getFloat("amount");
                String status = rsElectricData.getString("status");

                Blob imageBlob = rsElectricData.getBlob("file");
                String base64Image = convertBlobToBase64(imageBlob);

                MonthData electricityMonthData = new MonthData(month, amount, base64Image, status);
                electricDataPerMonth.add(electricityMonthData);
            }

            // Retrieve recycle data for each month
            String sqlRecycleData = "SELECT * FROM waste WHERE email = ? AND year = ? ORDER BY "
                    + getMonthOrderCaseStatement();
            PreparedStatement stmtRecycleData = conn.prepareStatement(sqlRecycleData);
            stmtRecycleData.setString(1, user.getEmail());
            stmtRecycleData.setString(2, year);

            ResultSet rsRecycleData = stmtRecycleData.executeQuery();
            while (rsRecycleData.next()) {
                String month = rsRecycleData.getString("period");
                float amount = rsRecycleData.getFloat("amount");
                String status = rsRecycleData.getString("status");

                Blob imageBlob = rsRecycleData.getBlob("file");
                String base64Image = convertBlobToBase64(imageBlob);

                MonthData recycleMonthData = new MonthData(month, amount, base64Image, status);
                recycleDataPerMonth.add(recycleMonthData);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        modelAndView.addObject("user", user);
        modelAndView.addObject("selectedYear", year);
        modelAndView.addObject("waterDataPerMonth", waterDataPerMonth);
        modelAndView.addObject("electricityDataPerMonth", electricDataPerMonth); // take note naming
        modelAndView.addObject("recycleDataPerMonth", recycleDataPerMonth);

        return modelAndView;
    }

    @RequestMapping(value = "/updateWaterStatus", method = RequestMethod.POST)
    public ModelAndView updateWaterStatus(
            @RequestParam("email") String email,
            @RequestParam("year") String year,
            @RequestParam("userId") int userId,
            @RequestParam Map<String, String> allRequestParams,
            RedirectAttributes redirectAttributes) {

        try (Connection conn = DbConnect.openConnection()) {
            conn.setAutoCommit(false); // Disable auto-commit if you want to handle transactions manually
            for (Map.Entry<String, String> entry : allRequestParams.entrySet()) {
                if (entry.getKey().startsWith("status")) {
                    String month = entry.getKey().substring(7, 10); // Assuming the key would be status[Jan],
                                                                    // status[Feb], etc.
                    String status = entry.getValue();

                    String sqlUpdate = "UPDATE water SET status = ? WHERE email = ? AND period = ? AND year = ?";
                    try (PreparedStatement stmtUpdate = conn.prepareStatement(sqlUpdate)) {
                        stmtUpdate.setString(1, status);
                        stmtUpdate.setString(2, email);
                        stmtUpdate.setString(3, month);
                        stmtUpdate.setString(4, year);

                        int rowsAffected = stmtUpdate.executeUpdate();
                        System.out.println("Rows affected for month " + month + ": " + rowsAffected); // Logging
                    }
                }
            }
            conn.commit(); // Commit the transaction
        } catch (SQLException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "Database error: " + e.getMessage());
            return new ModelAndView("redirect:/validateParticipant?userId=" + userId + "&year=" + year);
        }

        redirectAttributes.addFlashAttribute("message", "Water status updated successfully!");
        return new ModelAndView("redirect:/validateParticipant?userId=" + userId + "&year=" + year);
    }

    @RequestMapping(value = "/updateElectricityStatus", method = RequestMethod.POST)
    public ModelAndView updateElectricStatus(
            @RequestParam("email") String email,
            @RequestParam("year") String year,
            @RequestParam("userId") int userId,
            @RequestParam Map<String, String> allRequestParams,
            RedirectAttributes redirectAttributes) {

        try (Connection conn = DbConnect.openConnection()) {
            conn.setAutoCommit(false); // Disable auto-commit if you want to handle transactions manually
            for (Map.Entry<String, String> entry : allRequestParams.entrySet()) {
                if (entry.getKey().startsWith("status")) {
                    String month = entry.getKey().substring(7, 10); // Assuming the key would be status[Jan],
                                                                    // status[Feb], etc.
                    String status = entry.getValue();

                    String sqlUpdate = "UPDATE electric SET status = ? WHERE email = ? AND period = ? AND year = ?";
                    try (PreparedStatement stmtUpdate = conn.prepareStatement(sqlUpdate)) {
                        stmtUpdate.setString(1, status);
                        stmtUpdate.setString(2, email);
                        stmtUpdate.setString(3, month);
                        stmtUpdate.setString(4, year);

                        int rowsAffected = stmtUpdate.executeUpdate();
                        System.out.println("Rows affected for month " + month + ": " + rowsAffected); // Logging
                    }
                }
            }
            conn.commit(); // Commit the transaction
        } catch (SQLException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "Database error: " + e.getMessage());
            return new ModelAndView("redirect:/validateParticipant?userId=" + userId + "&year=" + year);
        }

        redirectAttributes.addFlashAttribute("message", "Electricity status updated successfully!");
        return new ModelAndView("redirect:/validateParticipant?userId=" + userId + "&year=" + year);
    }

    @RequestMapping(value = "/updateRecycleStatus", method = RequestMethod.POST)
    public ModelAndView updateRecycleStatus(
            @RequestParam("email") String email,
            @RequestParam("year") String year,
            @RequestParam("userId") int userId,
            @RequestParam Map<String, String> allRequestParams,
            RedirectAttributes redirectAttributes) {

        try (Connection conn = DbConnect.openConnection()) {
            conn.setAutoCommit(false); // Disable auto-commit if you want to handle transactions manually
            for (Map.Entry<String, String> entry : allRequestParams.entrySet()) {
                if (entry.getKey().startsWith("status")) {
                    String month = entry.getKey().substring(7, 10); // Assuming the key would be status[Jan],
                                                                    // status[Feb], etc.
                    String status = entry.getValue();

                    String sqlUpdate = "UPDATE waste SET status = ? WHERE email = ? AND period = ? AND year = ?";
                    try (PreparedStatement stmtUpdate = conn.prepareStatement(sqlUpdate)) {
                        stmtUpdate.setString(1, status);
                        stmtUpdate.setString(2, email);
                        stmtUpdate.setString(3, month);
                        stmtUpdate.setString(4, year);

                        int rowsAffected = stmtUpdate.executeUpdate();
                        System.out.println("Rows affected for month " + month + ": " + rowsAffected); // Logging
                    }
                }
            }
            conn.commit(); // Commit the transaction
        } catch (SQLException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "Database error: " + e.getMessage());
            return new ModelAndView("redirect:/validateParticipant?userId=" + userId + "&year=" + year);
        }

        redirectAttributes.addFlashAttribute("message", "Recycle status updated successfully!");
        return new ModelAndView("redirect:/validateParticipant?userId=" + userId + "&year=" + year);
    }

    @RequestMapping("/winnerList")
    public ModelAndView showWinnerList(@RequestParam(value = "year", required = false) String year,
            @RequestParam(value = "month", required = false) String month) {
        ModelAndView modelAndView = new ModelAndView("adminViews/WinnerList");
        List<User> qualifiedWinners = new ArrayList<>();
        List<User> unqualifiedWinners = new ArrayList<>();

        try (Connection conn = DbConnect.openConnection()) {
            String sql = "SELECT * FROM user WHERE user_level = 'participant'";

            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User winner = new User();
                winner.setId(rs.getInt("id"));
                winner.setName(rs.getString("name"));
                winner.setEmail(rs.getString("email"));
                winner.setPhoneNum(rs.getInt("phoneNum"));
                winner.setUserLevel(rs.getString("user_level"));
                winner.setAddress(rs.getString("address"));
                winner.setHousehold(rs.getString("household"));
                winner.setPeopleNo(rs.getInt("peopleNo"));

                // Initialize flags for each category submission
                boolean hasWater = false;
                boolean hasElectricity = false;
                boolean hasRecycle = false;

                // Fetching the profile image as Blob and converting it to Base64 string
                Blob blob = rs.getBlob("profile_image");
                String base64Image = null;
                if (blob != null) {
                    byte[] blobBytes = blob.getBytes(1, (int) blob.length());
                    base64Image = Base64.getEncoder().encodeToString(blobBytes);
                }
                winner.setProfileImageBase64(base64Image);

                // Initialize consumption and footprint totals
                float waterForMonth = 0;
                float electricityForMonth = 0;
                float recycleForMonth = 0;
                // float totalMonthlyConsumption = 0;
                float monthlyFootprint = 0;

                /// Query to get water consumption for the specific month
                if (month != null && year != null) {
                    String waterSql = "SELECT amount FROM water WHERE email = ? AND year = ? AND period = ?";
                    try (PreparedStatement waterStmt = conn.prepareStatement(waterSql)) {
                        waterStmt.setString(1, winner.getEmail());
                        waterStmt.setString(2, year);
                        waterStmt.setString(3, month);
                        ResultSet waterRs = waterStmt.executeQuery();

                        if (waterRs.next()) {
                            waterForMonth = waterRs.getFloat("amount");
                            // totalMonthlyConsumption += waterForMonth;
                            monthlyFootprint += waterForMonth * 0.419f; // Example carbon factor for water
                            hasWater = true;
                        }
                    }

                    String electricSql = "SELECT amount FROM electric WHERE email = ? AND year = ? AND period = ?";
                    try (PreparedStatement electricStmt = conn.prepareStatement(electricSql)) {
                        electricStmt.setString(1, winner.getEmail());
                        electricStmt.setString(2, year);
                        electricStmt.setString(3, month);
                        ResultSet electricRs = electricStmt.executeQuery();

                        if (electricRs.next()) {
                            electricityForMonth = electricRs.getFloat("amount");
                            // totalMonthlyConsumption += electricityForMonth;
                            monthlyFootprint += electricityForMonth * 0.584f; // Example carbon factor for electricity
                            hasElectricity = true;
                        }
                    }

                    String recycleSql = "SELECT amount FROM waste WHERE email = ? AND year = ? AND period = ?";
                    try (PreparedStatement recycleStmt = conn.prepareStatement(recycleSql)) {
                        recycleStmt.setString(1, winner.getEmail());
                        recycleStmt.setString(2, year);
                        recycleStmt.setString(3, month);
                        ResultSet recycleRs = recycleStmt.executeQuery();

                        if (recycleRs.next()) {
                            recycleForMonth = recycleRs.getFloat("amount");
                            // totalMonthlyConsumption += recycleForMonth;
                            monthlyFootprint += recycleForMonth * 2.860f; // Example carbon factor for recycle
                            hasRecycle = true;
                        }
                    }
                    
                    // Set the monthly values to the winner object
                    winner.setWaterConsumption(waterForMonth);
                    winner.setElectricityConsumption(electricityForMonth);
                    winner.setRecycleConsumption(recycleForMonth);
                    // winner.setTotalMonthlyConsumption(totalMonthlyConsumption);
                    winner.setMonthlyFootprint(monthlyFootprint);
                    
                    // Check if all categories are submitted for the month
                    if (hasWater && hasElectricity && hasRecycle) {
                        qualifiedWinners.add(winner);
                    } else {
                        unqualifiedWinners.add(winner);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Sort the winners list by the totalFootprint property in ascending order
        qualifiedWinners.sort(Comparator.comparing(User::getMonthlyFootprint));

        modelAndView.addObject("qualifiedWinners", qualifiedWinners);
        modelAndView.addObject("unqualifiedWinners", unqualifiedWinners);
        // modelAndView.addObject("selectedCategory", category);
        modelAndView.addObject("selectedYear", year);
        modelAndView.addObject("selectedMonth", month);
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

    private String convertBlobToBase64(Blob blob) throws SQLException, IOException {
        if (blob != null) {
            InputStream inputStream = blob.getBinaryStream();
            byte[] bytes = inputStream.readAllBytes();
            return Base64.getEncoder().encodeToString(bytes);
        }
        return null;
    }
}
