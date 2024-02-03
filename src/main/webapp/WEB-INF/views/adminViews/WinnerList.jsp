<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <title>Winner List</title>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
      <link rel="icon" href="<c:url value=" /resources/assets/MBIP-logo.png" />" type="image/x-icon" />

      <style>
        body {
          background-color: #cae4fc;
        }

        /* Boostrap override style */
        .table-exception {
          border-collapse: separate;
          border-spacing: 0 20px;
        }

        td:first-child,
        th:first-child {
          border-radius: 10px 0 0 10px;
        }

        td:last-child,
        th:last-child {
          border-radius: 0 10px 10px 0;
        }

        /* thead th {
        background-color: #f5f5f5;
      } */

        /* Podium styles */
        .card {
          margin: 10px;
          box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .card-body {
          position: relative;
          padding: 20px;
          border-radius: 10px;
          color: white;
          font-size: 1.2rem;
          /* Default background for cards */
          background-color: #f8f9fa;
        }

        /* First Place */
        .first-place .card-body {
          background-color: #ffd700;
          /* Gold color */
        }

        /* Second Place */
        .second-place .card-body {
          background-color: #c0c0c0;
          /* Silver color */
        }

        /* Third Place */
        .third-place .card-body {
          background-color: #cd7f32;
          /* Bronze color */
        }

        .card-title {
          font-size: 1.5em;
          margin-bottom: 0.5rem;
        }

        .card-text {
          font-size: 1em;
        }

        /* Specific styles for placing the winners */
        .col-4:nth-child(1) .card {
          /* 2nd Place */
          margin-top: 20px;
        }

        .col-4:nth-child(2) .card {
          /* 1st Place */
          margin-top: 0;
        }

        .col-4:nth-child(3) .card {
          /* 3rd Place */
          margin-top: 40px;
        }
      </style>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script>
        $(document).ready(function () {
          // Load UserSidebar.html into the sidebar div
          $("#sidebar").load("AdminSidebar");

          // You can add more code here to handle other dashboard functionalities
        });
      </script>
    </head>

    <body>
      <div class="d-flex">
        <div id="sidebar"></div>
        <div class="px-5 py-3" style="flex-grow: 1; margin-left: 250px">
          <button type="button" class="btn btn-primary m-3" onclick="history.back();">
            <i class="fa fa-arrow-left"></i> Back
          </button>
          <h1 class="text-center m-2">Winner List</h1>

          <!-- Table section -->
          <div class="container">
            <div class="row mt-5">
              <div class="col-sm">
                <div class="row">
                  <div class="fs-4 col-auto fw-bold">Winners of:</div>
                  <div class="col-auto">
                    <select class="form-select" id="yearSelection">
                      <option selected>Choose year</option>
                      <option value="2023" ${selectedYear=='2023' ? 'selected' : '' }>2023</option>
                      <option value="2024" ${selectedYear=='2024' ? 'selected' : '' }>2024</option>
                      <option value="2025" ${selectedYear=='2025' ? 'selected' : '' }>2025</option>
                      <!-- Add more years as needed -->
                    </select>
                  </div>
                  <div class="col-auto">
                    <select class="form-select" id="monthSelection">
                      <option selected>Choose month</option>
                      <option value="Jan" ${selectedMonth=='Jan' ? 'selected' : '' }>Jan</option>
                      <option value="Feb" ${selectedMonth=='Feb' ? 'selected' : '' }>Feb</option>
                      <option value="Mar" ${selectedMonth=='Mar' ? 'selected' : '' }>Mar</option>
                      <option value="Apr" ${selectedMonth=='Apr' ? 'selected' : '' }>Apr</option>
                      <option value="May" ${selectedMonth=='May' ? 'selected' : '' }>May</option>
                      <option value="Jun" ${selectedMonth=='Jun' ? 'selected' : '' }>Jun</option>
                      <option value="Jul" ${selectedMonth=='Jul' ? 'selected' : '' }>Jul</option>
                      <option value="Aug" ${selectedMonth=='Aug' ? 'selected' : '' }>Aug</option>
                      <option value="Sep" ${selectedMonth=='Sep' ? 'selected' : '' }>Sep</option>
                      <option value="Oct" ${selectedMonth=='Oct' ? 'selected' : '' }>Oct</option>
                      <option value="Nov" ${selectedMonth=='Nov' ? 'selected' : '' }>Nov</option>
                      <option value="Dec" ${selectedMonth=='Dec' ? 'selected' : '' }>Dec</option>
                    </select>
                  </div>
                  <!-- <div class="col-auto">
                    <select class="form-select" id="categorySelection">
                      <option selected>Choose category</option>
                      <option value="All" ${selectedCategory=='All' ? 'selected' : '' }>All</option>
                      <option value="Water" ${selectedCategory=='Water' ? 'selected' : '' }>Water</option>
                      <option value="Electricity" ${selectedCategory=='Electricity' ? 'selected' : '' }>Electricity
                      </option>
                      <option value="Recycle" ${selectedCategory=='Recycle' ? 'selected' : '' }>Recycle</option>
                    </select>
                  </div> -->
                </div>
              </div>
              <div class="col-sm text-muted text-end">
                Only qualified participants with all 3 categories approved are displayed in the podium
              </div>
            </div>
            <!-- Podium Section -->
            <div class="container text-center mt-5">
              <div class="card">
                <div class="card-body">
                  <h2 class="mb-4 text-black">Hall of Fame</h2>
                  <div class="row justify-content-center">
                    <!-- Second Place -->
                    <div class="col-4 second-place">
                      <div class="card">
                        <div class="card-body">
                          <h5 class="card-title">
                            <c:choose>
                              <c:when test="${not empty podiumWinners and podiumWinners.size() >= 2}">
                                ${podiumWinners[1].name}
                              </c:when>
                              <c:otherwise>
                                No Data
                              </c:otherwise>
                            </c:choose>
                          </h5>
                          <p class="card-text">
                            <c:choose>
                              <c:when test="${not empty podiumWinners and podiumWinners.size() >= 2}">
                                2nd Place - ${podiumWinners[1].monthlyFootprint} kg CO₂
                              </c:when>
                              <c:otherwise>
                                2nd Place - No Data
                              </c:otherwise>
                            </c:choose>
                          </p>
                        </div>
                      </div>
                    </div>
                    <!-- First Place -->
                    <div class="col-4 first-place">
                      <div class="card">
                        <div class="card-body">
                          <h5 class="card-title">
                            <c:choose>
                              <c:when test="${not empty podiumWinners and podiumWinners.size() >= 1}">
                                ${podiumWinners[0].name}
                              </c:when>
                              <c:otherwise>
                                No Data
                              </c:otherwise>
                            </c:choose>
                          </h5>
                          <p class="card-text">
                            <c:choose>
                              <c:when test="${not empty podiumWinners and podiumWinners.size() >= 1}">
                                1st Place - ${podiumWinners[0].monthlyFootprint} kg CO₂
                              </c:when>
                              <c:otherwise>
                                1st Place - No Data
                              </c:otherwise>
                            </c:choose>
                          </p>
                        </div>
                      </div>
                    </div>
                    <!-- Third Place -->
                    <div class="col-4 third-place">
                      <div class="card">
                        <div class="card-body">
                          <h5 class="card-title">
                            <c:choose>
                              <c:when test="${not empty podiumWinners and podiumWinners.size() >= 3}">
                                ${podiumWinners[2].name}
                              </c:when>
                              <c:otherwise>
                                No Data
                              </c:otherwise>
                            </c:choose>
                          </h5>
                          <p class="card-text">
                            <c:choose>
                              <c:when test="${not empty podiumWinners and podiumWinners.size() >= 3}">
                                3rd Place - ${podiumWinners[2].monthlyFootprint} kg CO₂
                              </c:when>
                              <c:otherwise>
                                3rd Place - No Data
                              </c:otherwise>
                            </c:choose>
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="row mt-5">
              <div class="col-sm">
                <div class="row">
                  <div class="col">
                    <h3>Qualified Participants</h3>
                    <ul class="list-group list-group-horizontal">
                      <li class="list-group-item">Indicators:</li>
                      <li class="list-group-item fw-bold text-secondary">Pending</li>
                      <li class="list-group-item fw-bold text-success">Approved</li>
                      <li class="list-group-item fw-bold text-danger">Rejected</li>
                      <li class="list-group-item fw-bold text-muted">No Data</li>
                    </ul>
                  </div>
                  <div class="col text-muted text-end">
                    <span class="d-block">Qualified participants are those who have submitted all 3 categories</span>
                    <span class="d-block">Sorted by Footprint in ascending order</span>
                  </div>
                </div>
                <table class="table table-hover table-responsive text-center align-middle table-exception">
                  <thead class="table-dark">
                    <tr>
                      <th scope="col">Ranking</th>
                      <th scope="col">Profile</th>
                      <th scope="col">Name</th>
                      <th scope="col">Email</th>
                      <th scope="col">Water</th>
                      <th scope="col">Electricity</th>
                      <th scope="col">Recycle</th>
                      <!-- <th scope="col">Total</th> -->
                      <th scope="col">Footprint</th>
                      <th scope="col">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach items="${qualifiedWinners}" var="winner" varStatus="status">
                      <tr>
                        <th scope="row">${status.index + 1}</th>
                        <td>
                          <c:choose>
                            <c:when test="${not empty winner.profileImageBase64}">
                              <img src="data:image/jpeg;base64,${winner.profileImageBase64}" alt="User Image" width="50"
                                height="50" style="border-radius: 50%; object-fit: cover;" />
                            </c:when>
                            <c:otherwise>
                              <img src="<c:url value='/resources/assets/blank-profile.png'/>" alt="Default Image"
                                width="50" height="50" />
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td>${winner.name}</td>
                        <td>${winner.email}</td>
                        <td class="fw-bold ${winner.waterStatus == 'approved' ? 'text-success' : 
                        winner.waterStatus == 'rejected' ? 'text-danger' : 
                        winner.waterStatus == 'pending' ? 'text-secondary' : 'text-muted'}">${winner.waterConsumption}
                        </td>
                        <td class="fw-bold ${winner.electricityStatus == 'approved' ? 'text-success' : 
                        winner.electricityStatus == 'rejected' ? 'text-danger' : 
                        winner.electricityStatus == 'pending' ? 'text-secondary' : 'text-muted'}">
                          ${winner.electricityConsumption}</td>
                        <td class="fw-bold ${winner.recycleStatus == 'approved' ? 'text-success' : 
                        winner.recycleStatus == 'rejected' ? 'text-danger' : 
                        winner.recycleStatus == 'pending' ? 'text-secondary' : 'text-muted'}">
                          ${winner.recycleConsumption}</td>
                        <!-- <td>${winner.totalMonthlyConsumption}</td> -->
                        <td>${winner.monthlyFootprint}</td>
                        <td>
                          <div class="btn-group" role="group">
                            <a href="userDetails?userId=${winner.id}" class="btn btn-sm btn-outline-primary">View</a>
                            <a href="validateParticipant?userId=${winner.id}"
                              class="btn btn-sm btn-outline-primary">Validate</a>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
            <div class="row mt-5">
              <div class="col-sm">
                <div class="row">
                  <h3 class="col">Unqualified Participants</h3>
                  <div class="col text-muted text-end">
                    <span class="d-block">Unqualified participants are those who have NOT submit all 3 categories</span>
                    <span class="d-block">Sorted by Footprint in ascending order and participants with 0 are
                      moved to the back</span>
                  </div>
                </div>
                <table class="table table-hover table-responsive text-center align-middle table-exception">
                  <thead class="table-dark">
                    <tr>
                      <th scope="col">No.</th>
                      <th scope="col">Profile</th>
                      <th scope="col">Name</th>
                      <th scope="col">Email</th>
                      <th scope="col">Water</th>
                      <th scope="col">Electricity</th>
                      <th scope="col">Recycle</th>
                      <!-- <th scope="col">Total</th> -->
                      <th scope="col">Footprint</th>
                      <th scope="col">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach items="${unqualifiedWinners}" var="winner" varStatus="status">
                      <tr>
                        <th scope="row">${status.index + 1}</th>
                        <td>
                          <c:choose>
                            <c:when test="${not empty winner.profileImageBase64}">
                              <img src="data:image/jpeg;base64,${winner.profileImageBase64}" alt="User Image" width="50"
                                height="50" style="border-radius: 50%; object-fit: cover;" />
                            </c:when>
                            <c:otherwise>
                              <img src="<c:url value='/resources/assets/blank-profile.png'/>" alt="Default Image"
                                width="50" height="50" />
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td>${winner.name}</td>
                        <td>${winner.email}</td>
                        <td class="fw-bold ${winner.waterStatus == 'approved' ? 'text-success' : 
                        winner.waterStatus == 'rejected' ? 'text-danger' : 
                        winner.waterStatus == 'pending' ? 'text-secondary' : 'text-muted'}">${winner.waterConsumption}
                        </td>
                        <td class="fw-bold ${winner.electricityStatus == 'approved' ? 'text-success' : 
                        winner.electricityStatus == 'rejected' ? 'text-danger' : 
                        winner.electricityStatus == 'pending' ? 'text-secondary' : 'text-muted'}">
                          ${winner.electricityConsumption}</td>
                        <td class="fw-bold ${winner.recycleStatus == 'approved' ? 'text-success' : 
                        winner.recycleStatus == 'rejected' ? 'text-danger' : 
                        winner.recycleStatus == 'pending' ? 'text-secondary' : 'text-muted'}">
                          ${winner.recycleConsumption}</td>
                        <!-- <td>${winner.totalMonthlyConsumption}</td> -->
                        <td>${winner.monthlyFootprint}</td>
                        <td>
                          <div class="btn-group" role="group">
                            <a href="userDetails?userId=${winner.id}" class="btn btn-sm btn-outline-primary">View</a>
                            <a href="validateParticipant?userId=${winner.id}"
                              class="btn btn-sm btn-outline-primary">Validate</a>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
      <script>
        $(document).ready(function () {
          // Set the dropdown to the selected year after the page loads
          // var selectedCategory = "${selectedCategory}";
          var selectedYear = "${selectedYear}";
          var selectedMonth = "${selectedMonth}";
          if (selectedYear) {
            $("#yearSelection").val(selectedYear);
          }
          // if (selectedCategory) {
          //   $("#categorySelection").val(selectedCategory);
          // }
          if (selectedMonth) {
            $("#monthSelection").val(selectedMonth);
          }

        });

        // // Call this function when the category dropdown changes
        // $("#categorySelection").change(function () {
        //   var selectedCategory = $(this).val();
        //   var selectedYear = $("#yearSelection").val();
        //   var selectedMonth = $("#monthSelection").val();

        //   // Redirect to the winnerlist URL with the selected category and year
        //   window.location.href =
        //     "winnerList?category=" + selectedCategory + "&year=" + selectedYear + "&month=" + selectedMonth;
        // });

        // Call this function when the year dropdown changes
        $("#yearSelection").change(function () {
          // var selectedCategory = $("#categorySelection").val();
          var selectedYear = $(this).val();
          var selectedMonth = $("#monthSelection").val();

          // Redirect to the winnerlist URL with the selected category and year
          window.location.href =
            "winnerList?&year=" + selectedYear + "&month=" + selectedMonth;
        });

        // Call this function when the month dropdown changes
        $("#monthSelection").change(function () {
          // var selectedCategory = $("#categorySelection").val();
          var selectedYear = $("#yearSelection").val();
          var selectedMonth = $(this).val();

          // Redirect to the winnerlist URL with the selected category and year
          window.location.href =
            "winnerList?&year=" + selectedYear + "&month=" + selectedMonth;
        });
      </script>
    </body>

    </html>