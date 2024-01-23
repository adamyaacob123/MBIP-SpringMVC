<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Dashboard</title>
<link rel="stylesheet" href="DashboardUser.css"> <!-- Link to your CSS file -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function(){
      $("#sidebar").load("SidebarUser.html"); 
    });
</script>
</head>
<body>

<!-- Sidebar Placeholder -->
<div id="sidebar"></div>
<!-- Main Content -->
<div class="dashboard-content">
    <div class="dashboard-header">
        <h1>User Dashboard</h1>
    </div>
    <div class="dashboard-stats">
        <div class="stat-item">
            <h2>Low Carbon Challenge</h2>
            <p>Leaderboard No <span class="stat-highlight">45/100</span></p>
        </div>
        <div class="stat-item">
            <h2>Carbon Level</h2>
            <p><span class="stat-highlight">45%</span></p>
        </div>
        <div class="stat-item">
            <h2>Carbon Status</h2>
            <p>Good</p>
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