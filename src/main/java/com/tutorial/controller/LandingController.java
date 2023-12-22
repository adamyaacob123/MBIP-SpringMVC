package com.tutorial.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
		ModelAndView modelandview = new ModelAndView("landing");
		modelandview.addObject("welcomeMessage", "Selamat Datang with annotation! ");
		return modelandview;
	}
}