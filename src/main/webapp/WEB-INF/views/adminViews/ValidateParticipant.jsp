<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            <h2>Participant Data</h2>
            <div class="container">
              <div class="col-lg-8">
                <div class="card text-center">
                  <div class="card-header">
                    <img src="blank-profile.png" alt="Profile Image" height="100" width="100" />
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
                  <button class="nav-link" id="recycle-tab" data-bs-toggle="tab" data-bs-target="#recycle" type="button"
                    role="tab" aria-controls="recycle" aria-selected="false">
                    Recycle
                  </button>
                </li>
              </ul>

              <!-- Tab panes -->
              <div class="tab-content mt-3">
                <div class="tab-pane active" id="water" role="tabpanel" aria-labelledby="water-tab">
                  <div class="row">
                    <div class="col-lg-8">
                      <!-- Carousel for Water -->
                      <div id="carouselExampleCaptions" class="carousel slide">
                        <div class="carousel-indicators">
                          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0"
                            class="active" aria-current="true" aria-label="Slide 1"></button>
                          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                            aria-label="Slide 2"></button>
                          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                            aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner">
                          <div class="carousel-item active">
                            <img src="../earth.png" class="d-block w-100" alt="..." />
                            <div class="carousel-caption d-none d-md-block">
                              <h5>First slide label</h5>
                              <p>
                                Some representative placeholder content for the
                                first slide.
                              </p>
                            </div>
                          </div>
                          <div class="carousel-item">
                            <img src="..." class="d-block w-100" alt="..." />
                            <div class="carousel-caption d-none d-md-block">
                              <h5>Second slide label</h5>
                              <p>
                                Some representative placeholder content for the
                                second slide.
                              </p>
                            </div>
                          </div>
                          <div class="carousel-item">
                            <img src="..." class="d-block w-100" alt="..." />
                            <div class="carousel-caption d-none d-md-block">
                              <h5>Third slide label</h5>
                              <p>
                                Some representative placeholder content for the
                                third slide.
                              </p>
                            </div>
                          </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions"
                          data-bs-slide="prev">
                          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                          <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions"
                          data-bs-slide="next">
                          <span class="carousel-control-next-icon" aria-hidden="true"></span>
                          <span class="visually-hidden">Next</span>
                        </button>
                      </div>
                    </div>
                    <!-- Checklist -->
                    <div class="col-lg-4">
                      <form action="/path-to-your-submit-handler" method="post">
                        <!-- Loop this part for each month -->
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                          <h4>JAN</h4>
                          <div class="btn-group" role="group">
                            <input type="radio" class="btn-check" name="januaryOption" id="janPending"
                              autocomplete="off" />
                            <label class="btn btn-outline-secondary" for="janPending">Pending</label>
                            <input type="radio" class="btn-check" name="januaryOption" id="janApprove"
                              autocomplete="off" />
                            <label class="btn btn-outline-success" for="janApprove">Approve</label>
                            <input type="radio" class="btn-check" name="januaryOption" id="janReject"
                              autocomplete="off" />
                            <label class="btn btn-outline-danger" for="janReject">Reject</label>
                          </div>
                        </div>
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                          <h4>FEB</h4>
                          <div class="btn-group" role="group">
                            <input type="radio" class="btn-check" name="februaryOption" id="febApprove"
                              autocomplete="off" />
                            <label class="btn btn-outline-success" for="febApprove">Approve</label>

                            <input type="radio" class="btn-check" name="februaryOption" id="febReject"
                              autocomplete="off" />
                            <label class="btn btn-outline-danger" for="febReject">Reject</label>
                          </div>
                        </div>

                        <!-- Repeat for each month -->
                        <!-- ... -->
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                          <h4>NOV</h4>
                          <div class="btn-group" role="group">
                            <input type="radio" class="btn-check" name="novemberOption" id="novApprove"
                              autocomplete="off" />
                            <label class="btn btn-outline-success" for="novApprove">Approve</label>

                            <input type="radio" class="btn-check" name="novemberOption" id="novReject"
                              autocomplete="off" />
                            <label class="btn btn-outline-danger" for="novReject">Reject</label>
                          </div>
                        </div>
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                          <h4>DEC</h4>
                          <div class="btn-group" role="group">
                            <input type="radio" class="btn-check" name="decemberOption" id="decApprove"
                              autocomplete="off" />
                            <label class="btn btn-outline-success" for="decApprove">Approve</label>

                            <input type="radio" class="btn-check" name="decemberOption" id="decReject"
                              autocomplete="off" />
                            <label class="btn btn-outline-danger" for="decReject">Reject</label>
                          </div>
                        </div>

                        <!-- Submit Button -->
                        <div class="mt-4 text-end">
                          <button type="submit" class="btn btn-primary">
                            Submit
                          </button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
                <div class="tab-pane" id="electricity" role="tabpanel" aria-labelledby="electricity-tab">
                  <!-- Carousel for Electricity -->
                  <!-- Add your carousel code here -->
                </div>
                <div class="tab-pane" id="recycle" role="tabpanel" aria-labelledby="recycle-tab">
                  <!-- Carousel for Recycle -->
                  <!-- Add your carousel code here -->
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
  </body>

  </html>