<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
      <title>Validate Participant</title>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
      <style>
        body {
          background-color: #cae4fc;
        }

        .card {
          margin-top: 20px;
          height: 100%;
          width: 100%;
        }

        .calculation-card-water {
          background-color: #e7f5ff;
          border-left: 5px solid #4dabf7;
        }

        .calculation-card-electricity {
          background-color: #fcf8ec;
          border-left: 5px solid #eedda2;
        }

        .calculation-card-recycle {
          background-color: #fcf1eb;
          border-left: 5px solid #f0b999;
        }

        .profile-image {
          width: 120px;
          height: 120px;
          border-radius: 50%;
          border: 5px solid #fff;
          object-fit: cover;
        }
      </style>
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      <script>
        $(document).ready(function () {
          // Load AdminSidebar.jsp into the sidebar div
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
          <h1 class="text-center m-2">Validate Participant</h1>
          <div class="container">
            <div class="row mt-5">
              <div class="container">
                <div class="col-lg-8">
                  <div class="card text-center">
                    <div class="card-header">
                      <c:choose>
                        <c:when test="${not empty user.profileImageBase64}">
                          <img class="profile-image" src="data:image/jpeg;base64,${user.profileImageBase64}"
                            alt="User Image" />
                        </c:when>
                        <c:otherwise>
                          <img class="profile-image" src="<c:url value='/resources/assets/blank-profile.png'/>"
                            alt="Default Image" />
                        </c:otherwise>
                      </c:choose>
                      <h3>${user.name}</h3>
                    </div>
                    <div class="card-body">
                      <h3 class="card-title"></h3>
                      <div class="row">
                        <div class="col-sm-6">
                          <p class="text-start">
                            <strong>ID:</strong> ${user.id}
                          </p>
                          <p class="text-start">
                            <strong>Email:</strong> ${user.email}
                          </p>
                          <p class="text-start">
                            <strong>Phone Number:</strong> ${user.phoneNum}
                          </p>
                        </div>
                        <div class="col-sm-6">
                          <p class="text-start">
                            <strong>Address:</strong> ${user.address}
                          </p>
                          <p class="text-start">
                            <strong>Household:</strong> ${user.household}
                          </p>
                          <p class="text-start">
                            <strong>People No:</strong> ${user.peopleNo}
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="row mt-5">
              <div class="container mt-2">
                <!-- Year Selection Dropdown -->
                <div class="d-flex justify-content-end mb-2">
                  <select class="form-select w-auto" id="yearSelection">
                    <option selected>Choose year...</option>
                    <option value="2023" ${selectedYear=='2023' ? 'selected' : '' }>2023</option>
                    <option value="2024" ${selectedYear=='2024' ? 'selected' : '' }>2024</option>
                    <!-- Add more years as needed -->
                  </select>
                </div>
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                  <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="water-tab" data-bs-toggle="tab" data-bs-target="#water"
                      type="button" role="tab" aria-controls="water" aria-selected="true">
                      Water
                    </button>
                  </li>
                  <li class="nav-item" role="presentation">
                    <button class="nav-link" id="electricity-tab" data-bs-toggle="tab" data-bs-target="#electricity"
                      type="button" role="tab" aria-controls="electricity" aria-selected="false">
                      Electricity
                    </button>
                  </li>
                  <li class="nav-item" role="presentation">
                    <button class="nav-link" id="recycle-tab" data-bs-toggle="tab" data-bs-target="#recycle"
                      type="button" role="tab" aria-controls="recycle" aria-selected="false">
                      Recycle
                    </button>
                  </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content mt-3">
                  <div class="tab-pane active" id="water" role="tabpanel" aria-labelledby="water-tab">
                    <div class="row">
                      <div class="col-lg-6">
                        <!-- Carousel for Water -->
                        <div id="waterCarousel" class="carousel slide">
                          <div class="carousel-indicators">
                            <c:forEach items="${waterDataPerMonth}" var="waterMonthData" varStatus="status">
                              <button type="button" data-bs-target="#waterCarousel" data-bs-slide-to="${status.index}"
                                class="${status.first ? 'active' : ''}"
                                aria-current="${status.first ? 'true' : 'false'}"
                                aria-label="Slide ${status.count}"></button>
                            </c:forEach>
                          </div>
                          <div class="carousel-inner">
                            <c:forEach items="${waterDataPerMonth}" var="waterMonthData" varStatus="status">
                              <div class="carousel-item ${status.first ? 'active' : ''}">
                                <c:choose>
                                  <c:when test="${not empty waterMonthData.base64Image}">
                                    <img src="data:image/jpeg;base64,${waterMonthData.base64Image}"
                                      class="d-block w-100" alt="${waterMonthData.month}">
                                  </c:when>
                                  <c:otherwise>
                                    <img src="<c:url value='/resources/assets/no-img.jpg'/>" class="d-block w-100"
                                      alt="Default image">
                                  </c:otherwise>
                                </c:choose>
                                <div class="carousel-caption d-none d-md-block bg-dark opacity-50">
                                  <h5>${waterMonthData.month} Consumption</h5>
                                  <p>Consumption: ${waterMonthData.amount} m³</p>
                                </div>
                              </div>
                            </c:forEach>
                          </div>
                          <button class="carousel-control-prev" type="button" data-bs-target="#waterCarousel"
                            data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                          </button>
                          <button class="carousel-control-next" type="button" data-bs-target="#waterCarousel"
                            data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                          </button>
                        </div>
                      </div>
                      <!-- Checklist for water -->
                      <div class="col-lg-6">
                        <form action="<c:url value='/updateWaterStatus'/>" method="post">
                          <input type="hidden" name="email" value="${user.email}">
                          <input type="hidden" name="year" value="${selectedYear}">
                          <input type="hidden" name="userId" value="${user.id}">

                          <c:forEach items="${waterDataPerMonth}" var="waterMonthData" varStatus="status">
                            <div class="mb-3 d-flex justify-content-between align-items-center">
                              <h4 class="px-5">${waterMonthData.month}</h4>
                              <div class="btn-group" role="group">
                                <input type="radio" class="btn-check" name="status[${waterMonthData.month}]"
                                  id="waterPending${waterMonthData.month}" value="pending"
                                  ${'pending'.equals(waterMonthData.status) ? 'checked' : '' } autocomplete="off" />
                                <label class="btn btn-outline-secondary"
                                  for="waterPending${waterMonthData.month}">Pending</label>

                                <input type="radio" class="btn-check" name="status[${waterMonthData.month}]"
                                  id="waterApproved${waterMonthData.month}" value="approved"
                                  ${'approved'.equals(waterMonthData.status) ? 'checked' : '' } autocomplete="off" />
                                <label class="btn btn-outline-success"
                                  for="waterApproved${waterMonthData.month}">Approve</label>

                                <input type="radio" class="btn-check" name="status[${waterMonthData.month}]"
                                  id="waterRejected${waterMonthData.month}" value="rejected"
                                  ${'rejected'.equals(waterMonthData.status) ? 'checked' : '' } autocomplete="off" />
                                <label class="btn btn-outline-danger"
                                  for="waterRejected${waterMonthData.month}">Reject</label>
                              </div>
                            </div>
                          </c:forEach>

                          <!-- Submit Button -->
                          <div class="mt-4 text-end">
                            <button type="submit" class="btn btn-primary">Update Status</button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>

                  <div class="tab-pane" id="electricity" role="tabpanel" aria-labelledby="electricity-tab">
                    <!-- Carousel for Electricity -->
                    <div class="row">
                      <div class="col-lg-6">
                        <div id="electricityCarousel" class="carousel slide">
                          <div class="carousel-indicators">
                            <c:forEach items="${electricityDataPerMonth}" var="electricityMonthData" varStatus="status">
                              <button type="button" data-bs-target="#electricityCarousel"
                                data-bs-slide-to="${status.index}" class="${status.first ? 'active' : ''}"
                                aria-current="${status.first ? 'true' : 'false'}"
                                aria-label="Slide ${status.count}"></button>
                            </c:forEach>
                          </div>
                          <div class="carousel-inner">
                            <c:forEach items="${electricityDataPerMonth}" var="electricityMonthData" varStatus="status">
                              <div class="carousel-item ${status.first ? 'active' : ''}">
                                <c:choose>
                                  <c:when test="${not empty electricityMonthData.base64Image}">
                                    <img src="data:image/jpeg;base64,${electricityMonthData.base64Image}"
                                      class="d-block w-100" alt="${electricityMonthData.month}">
                                  </c:when>
                                  <c:otherwise>
                                    <img src="<c:url value='/resources/assets/no-img.jpg'/>" class="d-block w-100"
                                      alt="Default image">
                                  </c:otherwise>
                                </c:choose>
                                <div class="carousel-caption d-none d-md-block bg-dark opacity-50">
                                  <h5>${electricityMonthData.month} Consumption</h5>
                                  <p>Consumption: ${electricityMonthData.amount} kWh</p>
                                </div>
                              </div>
                            </c:forEach>
                          </div>
                          <button class="carousel-control-prev" type="button" data-bs-target="#electricityCarousel"
                            data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                          </button>
                          <button class="carousel-control-next" type="button" data-bs-target="#electricityCarousel"
                            data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                          </button>
                        </div>
                      </div>
                      <!-- Checklist for electricity -->
                      <div class="col-lg-6">
                        <form action="<c:url value='/updateElectricityStatus'/>" method="post">
                          <input type="hidden" name="email" value="${user.email}">
                          <input type="hidden" name="year" value="${selectedYear}">
                          <input type="hidden" name="userId" value="${user.id}">

                          <c:forEach items="${electricityDataPerMonth}" var="electricityMonthData" varStatus="status">
                            <div class="mb-3 d-flex justify-content-between align-items-center">
                              <h4 class="px-5">${electricityMonthData.month}</h4>
                              <div class="btn-group" role="group">
                                <input type="radio" class="btn-check" name="status[${electricityMonthData.month}]"
                                  id="electricityPending${electricityMonthData.month}" value="pending"
                                  ${'pending'.equals(electricityMonthData.status) ? 'checked' : '' }
                                  autocomplete="off" />
                                <label class="btn btn-outline-secondary"
                                  for="electricityPending${electricityMonthData.month}">Pending</label>

                                <input type="radio" class="btn-check" name="status[${electricityMonthData.month}]"
                                  id="electricityApproved${electricityMonthData.month}" value="approved"
                                  ${'approved'.equals(electricityMonthData.status) ? 'checked' : '' }
                                  autocomplete="off" />
                                <label class="btn btn-outline-success"
                                  for="electricityApproved${electricityMonthData.month}">Approve</label>

                                <input type="radio" class="btn-check" name="status[${electricityMonthData.month}]"
                                  id="electricityRejected${electricityMonthData.month}" value="rejected"
                                  ${'rejected'.equals(electricityMonthData.status) ? 'checked' : '' }
                                  autocomplete="off" />
                                <label class="btn btn-outline-danger"
                                  for="electricityRejected${electricityMonthData.month}">Reject</label>

                              </div>
                            </div>
                          </c:forEach>

                          <!-- Submit Button -->
                          <div class="mt-4 text-end">
                            <button type="submit" class="btn btn-primary">Update Status</button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                  <div class="tab-pane" id="recycle" role="tabpanel" aria-labelledby="recycle-tab">
                    <!-- Carousel for Recycle -->
                    <div class="row">
                      <div class="col-lg-6">
                        <div id="recycleCarousel" class="carousel slide">
                          <div class="carousel-indicators">
                            <c:forEach items="${recycleDataPerMonth}" var="recycleMonthData" varStatus="status">
                              <button type="button" data-bs-target="#recycleCarousel" data-bs-slide-to="${status.index}"
                                class="${status.first ? 'active' : ''}"
                                aria-current="${status.first ? 'true' : 'false'}"
                                aria-label="Slide ${status.count}"></button>
                            </c:forEach>
                          </div>
                          <div class="carousel-inner">
                            <c:forEach items="${recycleDataPerMonth}" var="recycleMonthData" varStatus="status">
                              <div class="carousel-item ${status.first ? 'active' : ''}">
                                <c:choose>
                                  <c:when test="${not empty recycleMonthData.base64Image}">
                                    <img src="data:image/jpeg;base64,${recycleMonthData.base64Image}"
                                      class="d-block w-100" alt="${recycleMonthData.month}">
                                  </c:when>
                                  <c:otherwise>
                                    <img src="<c:url value='/resources/assets/no-img.jpg'/>" class="d-block w-100"
                                      alt="Default image">
                                  </c:otherwise>
                                </c:choose>
                                <div class="carousel-caption d-none d-md-block bg-dark opacity-50">
                                  <h5>${recycleMonthData.month} Consumption</h5>
                                  <p>Consumption: ${recycleMonthData.amount} kg</p>
                                </div>
                              </div>
                            </c:forEach>
                          </div>
                          <button class="carousel-control-prev" type="button" data-bs-target="#recycleCarousel"
                            data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                          </button>
                          <button class="carousel-control-next" type="button" data-bs-target="#recycleCarousel"
                            data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                          </button>
                        </div>
                      </div>
                      <!-- Checklist for recycle -->
                      <div class="col-lg-6">
                        <form action="<c:url value='/updateRecycleStatus'/>" method="post">
                          <input type="hidden" name="email" value="${user.email}">
                          <input type="hidden" name="year" value="${selectedYear}">
                          <input type="hidden" name="userId" value="${user.id}">

                          <c:forEach items="${recycleDataPerMonth}" var="recycleMonthData" varStatus="status">
                            <div class="mb-3 d-flex justify-content-between align-items-center">
                              <h4 class="px-5">${recycleMonthData.month}</h4>
                              <div class="btn-group" role="group">
                                <input type="radio" class="btn-check" name="status[${recycleMonthData.month}]"
                                  id="recyclePending${recycleMonthData.month}" value="pending"
                                  ${'pending'.equals(recycleMonthData.status) ? 'checked' : '' } autocomplete="off" />
                                <label class="btn btn-outline-secondary"
                                  for="recyclePending${recycleMonthData.month}">Pending</label>

                                <input type="radio" class="btn-check" name="status[${recycleMonthData.month}]"
                                  id="recycleApproved${recycleMonthData.month}" value="approved"
                                  ${'approved'.equals(recycleMonthData.status) ? 'checked' : '' } autocomplete="off" />
                                <label class="btn btn-outline-success"
                                  for="recycleApproved${recycleMonthData.month}">Approve</label>

                                <input type="radio" class="btn-check" name="status[${recycleMonthData.month}]"
                                  id="recycleRejected${recycleMonthData.month}" value="rejected"
                                  ${'rejected'.equals(recycleMonthData.status) ? 'checked' : '' } autocomplete="off" />
                                <label class="btn btn-outline-danger"
                                  for="recycleRejected${recycleMonthData.month}">Reject</label>
                              </div>
                            </div>
                          </c:forEach>

                          <!-- Submit Button -->
                          <div class="mt-4 text-end">
                            <button type="submit" class="btn btn-primary">Update Status</button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="row g-3 mt-5 text-center">
                  <!-- Calculation Result Cards -->
                  <div class="col-md-4">
                    <div class="card calculation-card-water">
                      <div class="card-body">
                        <h5 class="card-title">Total Water Footprint</h5>
                        <p class="card-text">41.9 kgCO₂</p>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="card calculation-card-electricity">
                      <div class="card-body">
                        <h5 class="card-title">Total Electricity Footprint</h5>
                        <p class="card-text">58.4 kgCO₂</p>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="card calculation-card-recycle">
                      <div class="card-body">
                        <h5 class="card-title">Total Recycle Footprint</h5>
                        <p class="card-text">286 kgCO₂</p>
                      </div>
                    </div>
                  </div>
                  <!-- Total Carbon Footprint -->
                  <div class="col-12">
                    <div class="card">
                      <div class="card-body text-center">
                        <h5 class="card-title">Total Carbon Footprint</h5>
                        <p class="card-text">Total: 386.3 kgCO₂</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <script>
            $(document).ready(function () {
              // Set the dropdown to the selected year after the page loads
              var selectedYear = "${selectedYear}";
              if (selectedYear) {
                $("#yearSelection").val(selectedYear);
              }

              // Add your existing JavaScript code here...
            });

            // Call this function when the dropdown changes
            $("#yearSelection").change(function () {
              var selectedYear = $(this).val();
              var userId = "${user.id}";

              // Redirect to the userDetails URL with the selected year and userId
              window.location.href =
                "validateParticipant?userId=" + userId + "&year=" + selectedYear;
            });
          </script>
    </body>

    </html>