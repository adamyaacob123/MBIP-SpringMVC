<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<c:url value="/resources/styles/Admin/AdminSidebar.css" />">
</head>
<body>
    <div class="header">
        <div class="side-nav">
            <div class="user">
                <img class="user-img" src="data:image/png;base64,${base64Image}" alt="" style="width:50px; height:50px; " />
                <div class="username">
                    <h2 style="font-size: 20px; font-weight: bold;">${username}</h2>
                    <p style="font-size: 13px;">${email}</p>
                </div>
            </div>
            <ul class="sidebar-menu">
                <!-- <h4>MAIN</h4> -->
                <li class="menu-item" onclick="window.location.href='<c:url value='/Admin' />'"><img src="<c:url value="/resources/img/house.svg"/>" alt="dashboard"><p>Dashboard</p></li>        
                <li class="menu-item" onclick="window.location.href='<c:url value='/userList' />'"><img src="<c:url value="/resources/img/pie-chart.svg"/>" alt="status"><p>User Summary</p></li>
                <li class="menu-item" onclick="window.location.href='<c:url value='/winnerList' />'"><img src="<c:url value="/resources/img/trophy.svg"/>" alt="status"><p>Winner List</p></li>
                <li class="menu-item" onclick="window.location.href='<c:url value='/adminAccount'/>'"><img src="<c:url value="/resources/img/card-text.svg"/>" alt="form"><p>Account</p></li>   
                <!-- <h4>SETTINGS</h4> -->
                
            </ul>
            <ul>
                <li class="menu-item" onclick="window.location.href='<c:url value='/logout'/>'"><img src="<c:url value="/resources/img/box-arrow-left.svg"/>" alt="logout"><p>Logout</p></li>
            </ul>     
        </div>
    </div>
</body>
</html>
