<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
    <title>Form Submission Result</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
<body>
 	<div id="sidebar"></div>
	 <div class="dashboard-content">
	    <h1>Form Submission Result</h1>
	    <!-- This will display the message passed from the ModelAndView object -->
	    <p>${message}</p>
	    <!-- Add a link for users to go back to the form or to the homepage -->
	    <a href="<c:url value="/CarbonWater"/>">Go back to the form</a> | 
	    <a href="<c:url value="/getAll"/>">Go to the homepage</a>
    </div>
</body>
</html>
