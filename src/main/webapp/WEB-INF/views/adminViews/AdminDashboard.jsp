<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <title>Admin Dashboard</title>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
      <style>
        body {
          background-color: #cae4fc;
        }

        .calculation-card-water {
          background-color: #e7f5ff;
          border-left: 5px solid #4dabf7;
          height: 100%;
          width: 100%;
        }

        .calculation-card-electricity {
          background-color: #fcf8ec;
          border-left: 5px solid #eedda2;
          height: 100%;
          width: 100%;
        }

        .calculation-card-recycle {
          background-color: #fcf1eb;
          border-left: 5px solid #f0b999;
          height: 100%;
          width: 100%;
        }
      </style>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script>
        $(document).ready(function () {
          $(".sidebar").load("AdminSidebar");
        });
      </script>
    </head>

    <body>
      <div class="d-flex">
        <div class="sidebar"></div>
        <div class="px-5 py-3" style="flex-grow: 1; margin-left: 250px">
          <div class="py-3 text-center container">
            <div class="row py-5">
              <div class="col-10 mx-auto">
                <h1 class="mb-4">Admin Dashboard</h1>
                <h3 class="fw-light">Welcome to Your Control Panel</h3>
                <p class="lead text-body-secondary">This is the heart of the dashboard where you, as an administrator,
                  can steer the course of operations. Here you can manage users, view reports, and analyze trends at a
                  glance. Your tools to maintain order and efficiency are all here, streamlined and ready at your
                  command.</p>
                <h4 class="fw-light">Admin Functions: </h4>
                <div class="list-group list-group-horizontal justify-content-center mt-3">
                  <span class="list-group-item">View All Users</span>
                  <span class="list-group-item">Participants Details</span>
                  <span class="list-group-item">Validate Participants' Bills</span>
                  <span class="list-group-item">Determine Monthly Winner</span>
                </div>
              </div>
            </div>
          </div>
          <div class="container pb-3">
            <div class="row">
              <div class="col">
                <div class="card shadow-sm">
                  <img src="<c:url value='/resources/assets/user-list.png'/>" alt="Default Image" width=""
                    height="300" />
                  <div class="card-body">
                    <h5 class="card-title">User List</h5>
                    <p class="card-text">A comprehensive view of all users displaying fellow administrators
                      and participants. View participants detailed profiles, validate environmental contributions, or
                      simply get to know your user base.</p>
                    <div class="d-flex justify-content-between align-items-center">
                      <div class="btn-group">
                        <a href="<c:url value='/userList' />" type="button"
                          class="btn btn-sm btn-outline-primary">View</a>
                      </div>
                      <small class="text-body-secondary">Engage and manage users</small>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col">
                <div class="card shadow-sm">
                  <img src="<c:url value='/resources/assets/winner-list.jpg'/>" alt="Default Image" width="" height="300" />
                  <div class="card-body">
                    <h5 class="card-title">Winner List</h5>
                    <p class="card-text">Explore the leaderboard showcasing top performers in sustainability efforts.
                      The Winner List allows you to oversee the leaderboard, detailing the eco-conscious efforts of
                      participants.</p>
                    <div class="d-flex justify-content-between align-items-center">
                      <div class="btn-group">
                        <a href="<c:url value='/winnerList' />" type="button"
                          class="btn btn-sm btn-outline-primary">View</a>
                      </div>
                      <small class="text-body-secondary">Monthly Winners</small>
                    </div>
                  </div>
                </div>
              </div>
              <!-- <div class="col">
                <div class="card shadow-sm">
                  <img src="<c:url value='/resources/assets/no-img.jpg'/>" alt="Default Image" width="100%"
                    height="225" />
                  <div class="card-body">
                    <h5 class="card-title">Winner List</h5>
                    <p class="card-text">Explore the leaderboard showcasing top performers in sustainability efforts.
                      The Winner List allows you to oversee the leaderboard, detailing the eco-conscious efforts of
                      participants.</p>
                    <div class="d-flex justify-content-between align-items-center">
                      <div class="btn-group">
                        <a href="<c:url value='/winnerList' />" type="button"
                          class="btn btn-sm btn-outline-primary">View</a>
                      </div>
                      <small class="text-body-secondary">Monthly Winners</small>
                    </div>
                  </div>
                </div>
              </div> -->
            </div>
            <!-- Calculation Result Cards -->
            <div class="row g-3 text-center mt-5">
              <h3 class="fw-light">Calculation Formula</h3>
              <div class="col-md-4">
                <div class="card calculation-card-water">
                  <div class="card-body">
                    <h5 class="card-title">Water Footprint</h5>
                    <p class="card-text">
                    <div class="input-group mb-3">
                      <span class="input-group-text">Carbon Factor</span>
                      <span class="form-control">&times;&nbsp;0.419</span>
                    </div>
                    <div class="input-group mb-3">
                      <span class="input-group-text">Example:</span>
                      <span class="form-control">100 m³ &times; 0.419 = 41.9 kgCO₂</span>
                    </div>
                    </p>
                  </div>
                </div>
              </div>
              <div class="col-md-4">
                <div class="card calculation-card-electricity">
                  <div class="card-body">
                    <h5 class="card-title">Electricity Footprint</h5>
                    <p class="card-text">
                    <div class="input-group mb-3">
                      <span class="input-group-text">Carbon Factor </span>
                      <span class="form-control">&times;&nbsp;0.584</span>
                    </div>
                    <div class="input-group mb-3">
                      <span class="input-group-text">Example:</span>
                      <span class="form-control">100 kWh &times; 0.584 = 58.4 kgCO₂</span>
                    </div>
                    </p>
                  </div>
                </div>
              </div>
              <div class="col-md-4">
                <div class="card calculation-card-recycle">
                  <div class="card-body">
                    <h5 class="card-title">Recycle Footprint</h5>
                    <p class="card-text">
                    <div class="input-group mb-3">
                      <span class="input-group-text">Carbon Factor </span>
                      <span class="form-control">&times;&nbsp;2.860</span>
                    </div>
                    <div class="input-group mb-3">
                      <span class="input-group-text">Example:</span>
                      <span class="form-control">100 kg &times; 2.860 = 286 kgCO₂</span>
                    </div>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </body>

    </html>