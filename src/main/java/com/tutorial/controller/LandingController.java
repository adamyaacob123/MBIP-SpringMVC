package com.tutorial.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dbUtil.DbConnect;

@Controller
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

	@RequestMapping("/landing")
	protected ModelAndView Landing() {
		ModelAndView modelandview = new ModelAndView("User/landing");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}

	@RequestMapping("/login")
	protected ModelAndView Login() {
		ModelAndView modelandview = new ModelAndView("User/login");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}

	@RequestMapping("/register")
	protected ModelAndView Register() {
		ModelAndView modelandview = new ModelAndView("User/register");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}

	@RequestMapping("/account")
	protected ModelAndView Account() {
		ModelAndView modelandview = new ModelAndView("User/account");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}

	@RequestMapping("/edit_account")
	protected ModelAndView Edit_Account() {
		ModelAndView modelandview = new ModelAndView("User/edit_account");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}

	@RequestMapping("/add")
	protected ModelAndView Add(@RequestParam("password") String password, @RequestParam("username") String username,
			@RequestParam("name") String name, @RequestParam("email") String email,
			@RequestParam("address") String address, @RequestParam("phoneNum") int phoneNum,
			@RequestParam("household") String household, @RequestParam("peopleNo") int peopleNo) {

//		String username = request.getParameter("username");
//		String password = request.getParameter("password");
//		String name = request.getParameter("name");
//		String email = request.getParameter("email");
//		String address = request.getParameter("address");
//		int phoneNum = Integer.parseInt(request.getParameter("phoneNum"));
//		String household = request.getParameter("household");
//		int peopleNo = Integer.parseInt(request.getParameter("peopleNo"));
//		double profile_image = 

		int rowAffected = 0;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DbConnect.openConnection();
			System.out.println("connection successfully opened : " + conn.getMetaData());

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
		ModelAndView modelandview = new ModelAndView("User/login");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}

}