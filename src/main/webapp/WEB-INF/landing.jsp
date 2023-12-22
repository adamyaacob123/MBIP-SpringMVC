<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>MBIP CarbonCut</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="icon" href="assets/MBIP-logo.png" type="image/x-icon" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />
<link href="<c:url value="/resources/styles/landing.css" />"
	rel="stylesheet">
</head>

<body style="background-image: url('<c:url value="/resources/assets/Home\ Page\ login\ bar\ 4.png" />');">
	<div class="row">
		<div class="col">
			<div class="main-content">
				<div>
					<img src="<c:url value="/resources/assets/MBIP-logo.png" />"
						alt="Image description" class="MBIP-Logo">

					<!-- <img src="assets/MBIP-logo.png" class="MBIP-Logo" /> -->

				</div>
				<div class="title fade-in-text">
					<h1 class="">
						CarbonCut <br /> MBIP
					</h1>

					<div class="title-description">
						<span class="description">An interactive dashboard and
							carbon </span> <span class="description">analysis platform to
							monitor your carbon </span> <span class="description">footprint.
							Gain visibility into your </span> <span class="description">environmental
							impact and take steps to </span> <span class="description">reduce
							it with the platform.</span>
					</div>
				</div>
				<div></div>
			</div>
		</div>
		<div class="col">
			<div class="rigth-side">
				<nav>
					<a href="register.html">
						<button type="button" class="btn btn-outline-light">
							Register</button>
					</a> <a href="login.html">
						<button type="button" class="btn btn-outline-light">Login</button>
					</a>
				</nav>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>
