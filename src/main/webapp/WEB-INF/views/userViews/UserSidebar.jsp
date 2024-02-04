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
                <img class="user-img" src="data:image/png;base64,${base64Image}" alt="" style="width:50px; height:50px; " />
                <div class="username">
                    <span style="font-size: 15px; font-weight: bold; ">${username}</span>
                    <p style="font-size: 13px;">${email}</p>
                </div>
            </div>
            
            <ul class="sidebar-menu">
                <!-- <h4>MAIN</h4> -->
                <hr>
				<p style="font-size: 12px;">MAIN</p>
                <li class="menu-item" onclick="window.location.href='<c:url value='/User' />'"><img src="<c:url value="resources/img/house.svg"/>" alt="dashboard"><p>Dashboard</p></li></a>
                <li class="menu-item" onclick="window.location.href='<c:url value='/CarbonWater' />'"><img src="<c:url value="resources/img/card-text.svg"/>" alt="form"><p>Carbon Form</p></li>
                <%-- <li class="menu-item"><img src="<c:url value="resources/img/pie-chart.svg"/>" alt="status"><p>Carbon Status</p></li> --%>
                <li class="menu-item" onclick="window.location.href='<c:url value='/Report?id=${user.id}&year=2024' />'"><img src="<c:url value="resources/img/file-earmark-bar-graph.svg"/>" alt="placeholder"><p>Report</p></li>
                <li class="menu-item" onclick="window.location.href='<c:url value='/leaderboard' />'"><img src="<c:url value="resources/img/trophy.svg"/>" alt="placeholder"><p>Leaderboard</p></li>
                <!-- <h4>SETTINGS</h4> -->
              	<hr>
              	<p style="font-size: 12px;">SETTINGS</p>
                <li class="menu-item" onclick="window.location.href='<c:url value='/userAccount'/>'"><img  src="<c:url value="resources/img/gear.svg" />" alt="settings"><p>Settings</p></li>
            
                <li class="menu-item" onclick="window.location.href='<c:url value='/logout'/>'"><img src="<c:url value="resources/img/box-arrow-left.svg"/>" alt="logout"><p>Logout</p></li>
            </ul>     
        </div>
    </div>
</body>
</html>
