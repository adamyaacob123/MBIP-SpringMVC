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
<body style="background-image: url('<c:url value="/resources/assets/bg-login.png" />');">
    <div id="sidebar"></div>
    <div class="dashboard-content">
        <div class="dashboard-header">
            <h1 style="text-align: center;">User Dashboard</h1>
        </div>
        <div style="margin:20px;">         
            <div class="card">
				  <div class="row no-gutters">
				    <div class="col-md-4">
				       <img src="<c:url value ="/resources/img/medal.png"/>" class="card-img-top" alt="challenge-img" style="height:150px; width:auto;margin-left: 70px;">
				    </div>
				    <div class="col-md-8">
				      <div class="card-body">
				        <h5 class="card-title">Low Carbon Challenge</h5>
				        <p>Leaderboard No <span class="stat-highlight">45/100</span></p>
				        <a href="#" class="btn btn-primary">View Full List of Participants</a>
				      </div>
				    </div>
				  </div>
			</div>          
        </div>
         <div class="dashboard-stats">
            <div class="card" style="width: 18rem;background-color: #CAE4FC;">
                <img src="<c:url value ="/resources/img/water.png"/>" class="card-img-top" alt="..." style="height: 130px;width: 125px;display: block; margin: 0 auto;" >
                <div class="card-body">
                  <h5 class="card-title" style="text-align: center;">Water Consumption Form</h5>
                  
                  <a onclick="window.location.href='<c:url value='/displayWaterForm' />'" class="btn btn-primary" style="display: block; margin: 0 auto; width: max-content;">View History</a>
                </div>
            </div>
            <div class="card" style="width: 18rem;background-color: #EEDDA2;">
                <img src="<c:url value ="/resources/img/electric.png"/>" class="card-img-top" alt="..." style="height: 130px;width: 125px;display: block; margin: 0 auto;">
                <div class="card-body">
                  <h5 class="card-title" style="text-align: center;">Electric Consumption Form</h5>
                  
                  <a onclick="window.location.href='<c:url value='/displayElectricForm' />'" class="btn btn-primary" style="display: block; margin: 0 auto; width: max-content;">View History</a>
                </div>
            </div>
            <div class="card" style="width: 18rem;background-color: #F0B999;">
                <img src="<c:url value ="/resources/img/recycle.png"/>" class="card-img-top" alt="..." style="height: 130px;width: 220px;display: block; margin: 0 auto;">
                <div class="card-body">
                  <h5 class="card-title" style="text-align: center;">Recycle Weight Form</h5>
                  
                  <a onclick="window.location.href='<c:url value='/displayWasteForm' />'" class="btn btn-primary" style="display: block; margin: 0 auto; width: max-content;">View History</a>
                </div>
            </div>
        </div>
        <!-- <div class="notification-section">
            <h2>Notification Page</h2>
            <div class="notification-content">
                Winners Profile/Announcement
            </div> -->
    </div>
    
</body>
</html>