<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<link rel="stylesheet" href="DashboardAdmin.css"> <!-- Link to your CSS file -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(function(){
      $("#sidebar").load("SidebarAdmin.html"); 
    });
</script>
</head>
<body>
<!-- Sidebar Placeholder -->
<div id="sidebar"></div>

<!-- Main Content -->
<!-- Main Content -->
<div class="dashboard-content">
  <div class="dashboard-header">
      <h1>Admin Dashboard</h1>
  </div>
  <div class="dashboard-stats">
      <div class="stat-item">
          <h2>Users</h2>
          <p>No <span class="stat-highlight">12345</span></p>
      </div>
      <div class="stat-item">
          <h2>Session</h2>
          <p><span class="stat-highlight">12k</span></p>
      </div>
      <div class="stat-item">
          <h2>Lorem Ipsum</h2>
          <p>Good</p>
      </div>
  </div>
  <div class="winner-section">
      <h2>Winner For The Month</h2>
      <div class="winner-list">
          img
      </div>
  </div>
  <div class="dashboard-stats">
    <div class="stat-item">
        <h2>Validate Winner</h2>
        <a href="#validate-winner"><button>View</button></a>
    </div>
    <div class="stat-item">
        <h2>View User List</h2>
        <a href="#user-list"><button>View</button></a>
    </div>
</div>
</div>
</body>
</html>