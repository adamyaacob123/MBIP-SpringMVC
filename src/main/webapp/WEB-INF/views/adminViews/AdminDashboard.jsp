<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!DOCTYPE html>
<head>
    <title>Admin Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"  integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/resources/styles/Admin/AdminDashboard.css"/>">
</head>
    <script>
        $(document).ready(function() {
            // Load UserSidebar.html into the sidebar div
            $(".sidebar").load("AdminSidebar");

            // You can add more code here to handle other dashboard functionalities
        });
    </script>

<body>
    <div class="sidebar"></div>
    
    <!-- <iframe src="AdminSidebar.html" width="250px"></iframe> -->
    <div class="dashboard-content">
        <div class="dashboard-header">
            <h1 style="text-align: center;">Admin Dashboard</h1>
        </div>
        <div class="notification-section">
            <h2>Notification Page</h2>
            <div class="notification-content">
                Winners Profile/Announcement
            </div>
        </div>
        <div class="dashboard-stats">
            <div class="card" style="width: 18rem;">
                <img src="<c:url value ="/resources/img/Validation-1.jpg"/>" class="card-img-top" alt="validate-icon">
                <div class="card-body">
                  <h5 class="card-title">Validate Winner</h5>
                  <p>Validate submitted participant's data</p>
                  <a onclick="window.location.href='<c:url value='/userList' />'" class="btn btn-primary">Click to validate winner</a>
                </div>
            </div>
            <div class="card" style="width: 18rem;">
                <img src="<c:url value ="/resources/img/public_blue_users.png"/>" class="card-img-top" alt="user-icon" style="padding: 10px;">
                <div class="card-body">
                  <h5 class="card-title">View Winner List</h5>
                  <p>View all the winner of Low Carbon Challenge</p>
                  <a onclick="window.location.href='<c:url value='/winnerList' />'" class="btn btn-primary">View</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
