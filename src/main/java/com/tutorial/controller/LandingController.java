package com.tutorial.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.tutorial.model.User;

import dbUtil.DbConnect;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
//@MultipartConfig
public class LandingController {

	@RequestMapping("/welcome/{facultyName}/{userName}")
	protected ModelAndView helloWorld(@PathVariable("facultyName") String faculty,
			@PathVariable("userName") String name) {
		ModelAndView modelandview = new ModelAndView("HelloPage");
		modelandview.addObject("welcomeMessage", "Hi" + name + " Your Faculty is: " + faculty);
		return modelandview;
	}

	@RequestMapping("/selamat")
	protected ModelAndView selamatDatang() {
		ModelAndView modelandview = new ModelAndView("HelloPage");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}

	@RequestMapping("/")
	protected ModelAndView Landing() {
		ModelAndView modelandview = new ModelAndView("userViews/landing");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}

	@RequestMapping("/login")
	protected ModelAndView Login() {
		ModelAndView modelandview = new ModelAndView("userViews/login");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}
	
	@RequestMapping("/logout")
	protected ModelAndView Logout(HttpSession session) {
		ModelAndView modelandview = new ModelAndView("userViews/landing");
		modelandview.addObject("byebyeMessage", "Selamat Jalan with annotation! ");
		session.invalidate();
		return modelandview;
	}

	@RequestMapping("/register")
	protected ModelAndView Register() {
		ModelAndView modelandview = new ModelAndView("userViews/register");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}
	
	@RequestMapping("/User")
	protected ModelAndView UserDashboard() {
		ModelAndView modelandview = new ModelAndView("userViews/UserDashboard");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}
	@RequestMapping("/Admin")
	protected ModelAndView AdminDashboard() {
		ModelAndView modelandview = new ModelAndView("adminViews/AdminDashboard");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}
	
	@RequestMapping("/UserSidebar")
	protected ModelAndView UserSidebar(HttpSession session) {
		ModelAndView modelandview = new ModelAndView("userViews/UserSidebar");
		User user = (User) session.getAttribute("user");
		if (user != null) {
			// Add user information to the model
			modelandview.addObject("userId", user.getId());
			modelandview.addObject("userLevel", user.getUserLevel());
			modelandview.addObject("username", user.getUsername());
			modelandview.addObject("name", user.getName());
			modelandview.addObject("email", user.getEmail());
			modelandview.addObject("address", user.getAddress());
			modelandview.addObject("phoneNum", user.getPhoneNum());
			modelandview.addObject("household", user.getHousehold());
			modelandview.addObject("peopleNo", user.getPeopleNo());

			byte[] profileImageBytes = user.getProfile_image();
			if (profileImageBytes != null) {
				String base64Image = Base64.getEncoder().encodeToString(profileImageBytes);
				modelandview.addObject("base64Image", base64Image);
			}
		} else {
			// If user is not in the session, handle accordingly (redirect to login, show an
			// error, etc.)
			modelandview.addObject("errorMessage", "User not found in the session. Please log in.");
		}
		return modelandview;
	}
	
	@RequestMapping("/AdminSidebar")
	protected ModelAndView AdminSidebar(HttpSession session) {
		ModelAndView modelandview = new ModelAndView("adminViews/AdminSidebar");
		User admin = (User) session.getAttribute("user");
		if (admin != null) {
			// Add user information to the model
			modelandview.addObject("userId", admin.getId());
			modelandview.addObject("userLevel", admin.getUserLevel());
			modelandview.addObject("username", admin.getUsername());
			modelandview.addObject("name", admin.getName());
			modelandview.addObject("email", admin.getEmail());
			modelandview.addObject("address", admin.getAddress());
			modelandview.addObject("phoneNum", admin.getPhoneNum());
			modelandview.addObject("household", admin.getHousehold());
			modelandview.addObject("peopleNo", admin.getPeopleNo());

			byte[] profileImageBytes = admin.getProfile_image();
			if (profileImageBytes != null) {
				String base64Image = Base64.getEncoder().encodeToString(profileImageBytes);
				modelandview.addObject("base64Image", base64Image);
			}
		} else {
			// If user is not in the session, handle accordingly (redirect to login, show an
			// error, etc.)
			modelandview.addObject("errorMessage", "Admin not found in the session. Please log in.");
		}
		return modelandview;
	}
	
	@RequestMapping("/CarbonWater")
	protected ModelAndView CarbonWaterForm() {
		ModelAndView modelandview = new ModelAndView("userViews/CarbonWater");
		modelandview.addObject("currentCategory", "water");
		return modelandview;
	}
	
	@RequestMapping("/CarbonOil")
	protected ModelAndView CarbonOilForm() {
		ModelAndView modelandview = new ModelAndView("userViews/CarbonOil");
		modelandview.addObject("currentCategory", "waste");
		return modelandview;
	}
	
	@RequestMapping("/CarbonElectric")
	protected ModelAndView CarbonElectricForm() {
		ModelAndView modelandview = new ModelAndView("userViews/CarbonElectric");
		modelandview.addObject("currentCategory", "electricity");
		return modelandview;
	}

	@RequestMapping("/userAccount")
	protected ModelAndView userAccount(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView("userViews/account");

		// Retrieve user information from the session
		User user = (User) session.getAttribute("user");

		// Check if the user is in the session
		if (user != null) {
			// Add user information to the model
			modelAndView.addObject("userId", user.getId());
			modelAndView.addObject("userLevel", user.getUserLevel());
			modelAndView.addObject("username", user.getUsername());
			modelAndView.addObject("name", user.getName());
			modelAndView.addObject("email", user.getEmail());
			modelAndView.addObject("address", user.getAddress());
			modelAndView.addObject("phoneNum", user.getPhoneNum());
			modelAndView.addObject("household", user.getHousehold());
			modelAndView.addObject("peopleNo", user.getPeopleNo());

			byte[] profileImageBytes = user.getProfile_image();
			if (profileImageBytes != null) {
				String base64Image = Base64.getEncoder().encodeToString(profileImageBytes);
				modelAndView.addObject("base64Image", base64Image);
			}
		} else {
			// If user is not in the session, handle accordingly (redirect to login, show an
			// error, etc.)
			modelAndView.addObject("errorMessage", "User not found in the session. Please log in.");
		}

		modelAndView.addObject("welcomeMessage", "Selamat Datang with annotation!");
		return modelAndView;
	}
	
	@RequestMapping("/adminAccount")
	protected ModelAndView adminAccount(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView("adminViews/account");

		// Retrieve user information from the session
		User user = (User) session.getAttribute("user");

		// Check if the user is in the session
		if (user != null) {
			// Add user information to the model
			modelAndView.addObject("userId", user.getId());
			modelAndView.addObject("userLevel", user.getUserLevel());
			modelAndView.addObject("username", user.getUsername());
			modelAndView.addObject("name", user.getName());
			modelAndView.addObject("email", user.getEmail());
			modelAndView.addObject("address", user.getAddress());
			modelAndView.addObject("phoneNum", user.getPhoneNum());
			modelAndView.addObject("household", user.getHousehold());
			modelAndView.addObject("peopleNo", user.getPeopleNo());

			byte[] profileImageBytes = user.getProfile_image();
			if (profileImageBytes != null) {
				String base64Image = Base64.getEncoder().encodeToString(profileImageBytes);
				modelAndView.addObject("base64Image", base64Image);
			}
		} else {
			// If user is not in the session, handle accordingly (redirect to login, show an
			// error, etc.)
			modelAndView.addObject("errorMessage", "User not found in the session. Please log in.");
		}

		modelAndView.addObject("welcomeMessage", "Selamat Datang with annotation!");
		return modelAndView;
	}

	@RequestMapping("/edit_account")
	protected ModelAndView Edit_Account(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView("userViews/edit_account");

		// Retrieve user information from the session
		User user = (User) session.getAttribute("user");

		// Check if the user is in the session
		if (user != null) {
			// Add user information to the model
			modelAndView.addObject("userId", user.getId());
			modelAndView.addObject("userLevel", user.getUserLevel());
			modelAndView.addObject("username", user.getUsername());
			modelAndView.addObject("password", user.getPassword());
			modelAndView.addObject("name", user.getName());
			modelAndView.addObject("email", user.getEmail());
			modelAndView.addObject("address", user.getAddress());
			modelAndView.addObject("phoneNum", user.getPhoneNum());
			modelAndView.addObject("household", user.getHousehold());
			modelAndView.addObject("peopleNo", user.getPeopleNo());

			// Convert profile image to base64
			byte[] profileImageBytes = user.getProfile_image();
			if (profileImageBytes != null) {
				String base64Image = Base64.getEncoder().encodeToString(profileImageBytes);
				modelAndView.addObject("base64Image", base64Image);
			}
		} else {
			// If user is not in the session, handle accordingly (redirect to login, show an
			// error, etc.)
			modelAndView.addObject("errorMessage", "User not found in the session. Please log in.");
		}

		modelAndView.addObject("welcomeMessage", "Selamat Datang with annotation!");
		return modelAndView;
	}

	@RequestMapping("/add")
	protected ModelAndView Add(@RequestParam("password") String password, @RequestParam("username") String username,
			@RequestParam("name") String name, @RequestParam("email") String email,
			@RequestParam("address") String address, @RequestParam("phoneNum") int phoneNum,
			@RequestParam("household") String household, @RequestParam("peopleNo") int peopleNo) {

		int rowAffected = 0;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DbConnect.openConnection();
			System.out.println("connection successfully opened : " + conn.getMetaData());

			// Check if the email already exists in the database
			if (isEmailExists(conn, email)) {
				// Email already exists, show an error or handle accordingly

				ModelAndView modelAndView = new ModelAndView("userViews/register");
				modelAndView.addObject("errorEmail", "Email alrady exists!");
				return modelAndView;
			}

			// Prepare the SQL statement with placeholders
			String sql = "INSERT INTO user (user_level, username, password, name, email, address, phoneNum, household, peopleNo, profile_image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = conn.prepareStatement(sql);

			// Set parameter values
			stmt.setString(1, "participant");
			stmt.setString(2, username);
			stmt.setString(3, password);
			stmt.setString(4, name);
			stmt.setString(5, email);
			stmt.setString(6, address);
			stmt.setInt(7, phoneNum);
			stmt.setString(8, household);
			stmt.setInt(9, peopleNo);

			stmt.setNull(10, Types.BLOB);

			// Execute the query
			int rowsAffected = stmt.executeUpdate();

		} catch (SQLException ex) {
			ex.printStackTrace();
		} catch (ClassNotFoundException ex) {
			ex.printStackTrace();
		}
		ModelAndView modelandview = new ModelAndView("userViews/login");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}

	private boolean isEmailExists(Connection conn, String email) throws SQLException {
		String query = "SELECT COUNT(*) FROM user WHERE email = ?";
		try (PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, email);
			try (ResultSet resultSet = stmt.executeQuery()) {
				resultSet.next();
				int count = resultSet.getInt(1);
				return count > 0;
			}
		}
	}

	@RequestMapping("/getAll")
	public ModelAndView getAll(@RequestParam("email") String email, @RequestParam("password") String password,
			HttpSession session) {

		List<User> users = new ArrayList<>();

		try {
			Connection conn = DbConnect.openConnection();
			String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, email);
			stmt.setString(2, password);

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setUserLevel(rs.getString("user_level"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setAddress(rs.getString("address"));
				user.setPhoneNum(rs.getInt("phoneNum"));
				user.setHousehold(rs.getString("household"));
				user.setPeopleNo(rs.getInt("peopleNo"));

				// Assuming profile_image is stored as a Blob in the database
				Blob blob = rs.getBlob("profile_image");
				if (blob != null) {
					byte[] bytes = blob.getBytes(1, (int) blob.length());
					user.setProfile_image(bytes);
				}

				session.setAttribute("user", user);
				conn.close();

				if ("participant".equals(user.getUserLevel())) {
					ModelAndView modelAndView = new ModelAndView("userViews/UserDashboard");
					modelAndView.addObject("user", user);
					return modelAndView;
				} else if ("admin".equals(user.getUserLevel())) {
					ModelAndView modelAndView = new ModelAndView("adminViews/AdminDashboard");
					modelAndView.addObject("user", user);
					return modelAndView;
				}

			} else {
				ModelAndView modelAndView = new ModelAndView("redirect:/login");
				modelAndView.addObject("error", "Invalid email or password. Please try again.");
				return modelAndView;
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		}

		ModelAndView modelAndView = new ModelAndView("userViews/UserDashboard");
		modelAndView.addObject("user", users);
		return modelAndView;
	}

	@RequestMapping("/update")
	public String update(HttpServletRequest request, HttpSession session, @RequestParam("fileInput") Part filePart) {

		User user = (User) session.getAttribute("user");

		int id = user.getId();
		String newName = request.getParameter("name");
		String newUsername = request.getParameter("username");
		String newPassword = request.getParameter("password");
		String newAddress = request.getParameter("address");
		int newPhoneNum = Integer.parseInt(request.getParameter("phoneNum"));
		String newEmail = request.getParameter("email");
		String newHousehold = request.getParameter("household");
		int newPeopleNo = Integer.parseInt(request.getParameter("peopleNo"));

		// Assuming profile_image is stored as a byte array in the User class
		byte[] newProfileImage = null;

		// Logic to handle profile image update (similar to what you did for
		// profile_image during login)
		try {
			if (filePart != null && filePart.getSize() > 0) {
				byte[] fileBytes = filePart.getInputStream().readAllBytes();
				newProfileImage = fileBytes;
			} else {
				// If no new image uploaded, retain the existing image from the session

				if (user != null) {
					newProfileImage = user.getProfile_image();
				}
			}
		} catch (IOException ex) {
			ex.printStackTrace();
			return "Error in handling profile image: " + ex.getMessage();
		}

		int rowAffected = 0;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DbConnect.openConnection();

			String sql = "UPDATE user SET name = ?, username = ?, password = ?, address = ?, "
					+ "phoneNum = ?, email = ?, household = ?, peopleNo = ?, profile_image = ? WHERE id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setString(1, newName);
			stmt.setString(2, newUsername);
			stmt.setString(3, newPassword);
			stmt.setString(4, newAddress);
			stmt.setInt(5, newPhoneNum);
			stmt.setString(6, newEmail);
			stmt.setString(7, newHousehold);
			stmt.setInt(8, newPeopleNo);
			stmt.setBytes(9, newProfileImage);
			stmt.setInt(10, id);

			rowAffected = stmt.executeUpdate();

			// Update user information in the session
			if (user != null) {
				user.setName(newName);
				user.setUsername(newUsername);
				user.setPassword(newPassword);
				user.setAddress(newAddress);
				user.setPhoneNum(newPhoneNum);
				user.setEmail(newEmail);
				user.setHousehold(newHousehold);
				user.setPeopleNo(newPeopleNo);
				user.setProfile_image(newProfileImage);
			}

		} catch (SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
			return "Error in update - User: " + ex.getMessage();
		}
		return "redirect:userAccount";
	}
	
	@RequestMapping("/leaderboard")
    public ModelAndView showLeaderboard(@RequestParam(value = "year", required = false) String year,
            @RequestParam(value = "month", required = false) String month) {
        ModelAndView modelAndView = new ModelAndView("userViews/Leaderboard");
        List<User> qualifiedWinners = new ArrayList<>();
        List<User> unqualifiedWinners = new ArrayList<>();
        List<User> podiumWinners = new ArrayList<>();

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

                // Initialize status flags
                String waterStatus = "";
                String electricityStatus = "";
                String recycleStatus = "";

                /// Query to get water consumption for the specific month
                if (month != null && year != null) {
                    String waterSql = "SELECT amount, status FROM water WHERE email = ? AND year = ? AND period = ?";
                    try (PreparedStatement waterStmt = conn.prepareStatement(waterSql)) {
                        waterStmt.setString(1, winner.getEmail());
                        waterStmt.setString(2, year);
                        waterStmt.setString(3, month);
                        ResultSet waterRs = waterStmt.executeQuery();

                        if (waterRs.next()) {
                            waterForMonth = waterRs.getFloat("amount");
                            winner.setWaterStatus(waterRs.getString("status"));
                            // totalMonthlyConsumption += waterForMonth;
                            monthlyFootprint += waterForMonth * 0.419f; // Example carbon factor for water
                            hasWater = true;
                        }
                    }

                    String electricSql = "SELECT amount, status FROM electric WHERE email = ? AND year = ? AND period = ?";
                    try (PreparedStatement electricStmt = conn.prepareStatement(electricSql)) {
                        electricStmt.setString(1, winner.getEmail());
                        electricStmt.setString(2, year);
                        electricStmt.setString(3, month);
                        ResultSet electricRs = electricStmt.executeQuery();

                        if (electricRs.next()) {
                            electricityForMonth = electricRs.getFloat("amount");
                            winner.setElectricityStatus(electricRs.getString("status"));
                            // totalMonthlyConsumption += electricityForMonth;
                            monthlyFootprint += electricityForMonth * 0.584f; // Example carbon factor for electricity
                            hasElectricity = true;
                        }
                    }

                    String recycleSql = "SELECT amount, status FROM waste WHERE email = ? AND year = ? AND period = ?";
                    try (PreparedStatement recycleStmt = conn.prepareStatement(recycleSql)) {
                        recycleStmt.setString(1, winner.getEmail());
                        recycleStmt.setString(2, year);
                        recycleStmt.setString(3, month);
                        ResultSet recycleRs = recycleStmt.executeQuery();

                        if (recycleRs.next()) {
                            recycleForMonth = recycleRs.getFloat("amount");
                            winner.setRecycleStatus(recycleRs.getString("status"));
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
                        // Check if the user is qualified for the podium
                        if ("approved".equals(winner.getWaterStatus()) &&
                                "approved".equals(winner.getElectricityStatus()) &&
                                "approved".equals(winner.getRecycleStatus())) {
                            podiumWinners.add(winner);
                        }

                        // Add to qualified winners list only if all conditions are met
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

        // Sort the unqualified winners list by monthlyFootprint, moving those with 0 to the end
        unqualifiedWinners.sort((user1, user2) -> {
            if (user1.getMonthlyFootprint() == 0 && user2.getMonthlyFootprint() == 0) return 0;
            if (user1.getMonthlyFootprint() == 0) return 1;
            if (user2.getMonthlyFootprint() == 0) return -1;
            return Float.compare(user1.getMonthlyFootprint(), user2.getMonthlyFootprint());
        });
        
        // Sort and limit the podium winners to top 3
        podiumWinners = podiumWinners.stream()
                .sorted(Comparator.comparing(User::getMonthlyFootprint))
                .limit(3)
                .collect(Collectors.toList());

        modelAndView.addObject("qualifiedWinners", qualifiedWinners);
        modelAndView.addObject("unqualifiedWinners", unqualifiedWinners);
        modelAndView.addObject("podiumWinners", podiumWinners);
        // modelAndView.addObject("selectedCategory", category);
        modelAndView.addObject("selectedYear", year);
        modelAndView.addObject("selectedMonth", month);
        return modelAndView;
    }
}
