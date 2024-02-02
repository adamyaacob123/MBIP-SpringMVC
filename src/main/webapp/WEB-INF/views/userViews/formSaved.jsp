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
    <link rel="stylesheet" href="<c:url value="/resources/styles/User/formSaved.css"/>" rel="stylesheet">
     
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
        <div >
			<img src="<c:url value ="/resources/img/success.png"/>" class="card-img-top" alt="challenge-img" style="height:150px; width:auto;margin-bottom: 20px">
        </div>
        
        <div class="notification-section">
            <h3>${message}</h3>
            <div>
                    <%--<a href="<c:url value="/CarbonWater"/>" class="btn btn-link">Go back to the form</a> | --%>
                    <a href="<c:url value="/User"/>" class="btn btn-link">Go to the homepage</a>
            </div>
        </div>
    </div>

    
</body>
</html>