<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Form Submission Result</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="icon" href="<c:url value="/resources/assets/MBIP-logo.png" />" type="image/x-icon" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/resources/styles/User/UserDashboard.css"/>" rel="stylesheet">
</head>
    <script>
        $(document).ready(function() {
            // Load UserSidebar.jsp into the sidebar div
            $("#sidebar").load("UserSidebar");

            // You can add more code here to handle other dashboard functionalities
        });
    </script>
<body style="background-image: url('<c:url value="/resources/assets/bg-login.png" />');">
    <div id="sidebar"></div>
    <div class="dashboard-content" style="background-color:rgb(127, 255, 77); height:100vh;">
        <div class="dashboard-header" style="background-color:rgb(191, 255, 165);">
            <h1 style="text-align: center;">Form Submission Result</h1>
        </div>
        
        <div class="notification-section" style="background-color:rgb(191, 255, 165);">
            <h3 style="text-align:center">${message}</h3>
        </div>
        <div style="text-align:center; font-weight:bold; font-size:20px;">
		    <a href="<c:url value="/User"/>"><button class="btn btn-primary">Go to the homepage</button></a>
	    </div>
    </div>

    
</body>
</html>