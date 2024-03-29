<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
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
<body>
    <div id="sidebar"></div>
    <div class="dashboard-content">
        <div class="dashboard-header">
            <h1 style="text-align: center;">User Dashboard</h1>
        </div>
        <div class="dashboard-stats">
            <div class="card" style="width: 18rem;">
                <img src="<c:url value ="/resources/img/cropped-hands-holding-trophy-EYF07487.jpg"/>" class="card-img-top" alt="challenge-img" style="height: 150px;">
                <div class="card-body">
                  <h5 class="card-title">Low Carbon Challenge</h5>
                  <p>Leaderboard No <span class="stat-highlight">45/100</span></p>
                  <a href="#" class="btn btn-primary">View Full List of Participants</a>
                </div>
            </div>
            <div class="card" style="width: 18rem;">
                <img src="<c:url value ="/resources/img/low-carbon.jpg"/>" class="card-img-top" alt="...">
                <div class="card-body">
                  <h5 class="card-title">Carbon Level</h5>
                  <p><span class="stat-highlight">45%</span></p>
                  <!-- <a href="#" class="btn btn-primary">View Full List of Participants</a> -->
                </div>
            </div>
            <div class="card" style="width: 18rem;">
                <img src="<c:url value ="/resources/img/_fdbc8722-0611-4a06-b530-101399e9278c.jpeg"/>" class="card-img-top" alt="..." style="height: 150px;">
                <div class="card-body">
                  <h5 class="card-title">Carbon Status</h5>
                  <p><span class="stat-highlight">Good</span></p>
                  <!-- <a href="#" class="btn btn-primary">View Full List of Participants</a> -->
                </div>
            </div>
        </div>
        <div class="notification-section">
            <h2>Notification Page</h2>
            <div class="notification-content">
                Winners Profile/Announcement
            </div>
        </div>
    </div>

    
</body>
</html>