<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<c:url value="/resources/styles/User/UserSidebar.css" />">
</head>
<body>
    <div class="header">
        <div class="side-nav">
            <div class="user">
                <img src="<c:url value="resources/img/Screenshot 2023-12-10 205410.png" />" alt="placeholder" class="user-img"/>
                <div class="username">
                    <h2 style="font-size: 20px; font-weight: bold;">Username</h2>
                    <p style="font-size: 15px; font-weight: bold;">user@gmail.com</p>
                </div>
            </div>
            
            <ul class="sidebar-menu">
                <!-- <h4>MAIN</h4> -->
                <li class="menu-item" onclick="window.location.href='<c:url value='/getAll' />'"><img src="<c:url value="resources/img/house.svg"/>" alt="dashboard"><p>Dashboard</p></li></a>
                <li class="menu-item" onclick="window.location.href='<c:url value='/CarbonWater' />'"><img src="<c:url value="resources/img/card-text.svg"/>" alt="form"><p>Carbon Form</p></li>
                <li class="menu-item"><img src="<c:url value="resources/img/pie-chart.svg"/>" alt="status"><p>Carbon Status</p></li>
                <li class="menu-item"><img src="<c:url value="resources/img/file-earmark-bar-graph.svg"/>" alt="placeholder"><p>Report</p></li>
            
                <!-- <h4>SETTINGS</h4> -->
                <li class="menu-item"><img src="<c:url value="resources/img/info-circle.svg" />" alt="help"><p>Help</p></li>
                <li class="menu-item" onclick="window.location.href='<c:url value='/account' />'"><img src="<c:url value="resources/img/gear.svg" />" alt="settings"><p>Settings</p></li>
            
                <li class="menu-item"><img src="<c:url value="resources/img/box-arrow-left.svg"/>" alt="logout"><p>Logout</p></li>
            </ul>     
        </div>
    </div>
</body>
</html>