<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Winner List</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
      body {
        background-color: #cae4fc;
      }
      /* Boostrap override style */
      .table {
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

      thead th {
        background-color: #f5f5f5;
      }
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
        background-color: #ffd700; /* Gold color */
      }

      /* Second Place */
      .second-place .card-body {
        background-color: #c0c0c0; /* Silver color */
      }

      /* Third Place */
      .third-place .card-body {
        background-color: #cd7f32; /* Bronze color */
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
      $(function () {
        $("#sidebar").load("SidebarAdmin.html");
      });
    </script>
  </head>
  <body>
    <div class="d-flex">
      <div id="sidebar"></div>
      <div style="flex-grow: 1">
        <button
          type="button"
          class="btn btn-primary m-3"
          onclick="history.back();"
        >
          <i class="fa fa-arrow-left"></i> Back
        </button>
        <h1 class="text-center m-2">Winners List</h1>

        <!-- Table section -->
        <div class="container">
          <div class="row mt-5">
            <div class="col-sm">
              <div class="row">
                <div class="fs-4 col-auto fw-bold">Winner List of Month:</div>
                <div class="col-auto">
                  <select class="form-select">
                    <option>Jan</option>
                    <option>Feb</option>
                    <option>Mar</option>
                    <option>Apr</option>
                  </select>
                </div>
                <div class="col-auto">
                  <select class="form-select">
                    <option>2023</option>
                    <option>2024</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="col-sm-4 text-muted text-end">
              Displays Top 10 participants with the lowest Carbon Footprint
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
                        <h5 class="card-title">Jane Doe</h5>
                        <p class="card-text">2nd Place</p>
                      </div>
                    </div>
                  </div>
                  <!-- First Place -->
                  <div class="col-4 first-place">
                    <div class="card">
                      <div class="card-body">
                        <h5 class="card-title">John Carlio</h5>
                        <p class="card-text">1st Place</p>
                      </div>
                    </div>
                  </div>
                  <!-- Third Place -->
                  <div class="col-4 third-place">
                    <div class="card">
                      <div class="card-body">
                        <h5 class="card-title">Emma Stone</h5>
                        <p class="card-text">3rd Place</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="row mt-5">
            <div class="col-sm">
              <table class="table table-hover table-responsive text-center">
                <thead class="table-dark">
                  <tr>
                    <th scope="col">Ranking</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Phone number</th>
                    <th scope="col">Carbon Footprint</th>
                    <th scope="col">Details</th>
                  </tr>
                </thead>
                <tbody>
                  <tr class="table-warning">
                    <th scope="row">1</th>
                    <td>John Carlio</td>
                    <td>john.carlio82@example.com</td>
                    <td>+33785705467</td>
                    <td>1002</td>
                    <td>
                      <a href="WinnerDetails.html"
                        ><button class="btn btn-sm btn-primary">View</button></a
                      >
                    </td>
                  </tr>
                  <tr class="table-secondary table-active">
                    <th scope="row">2</th>
                    <td>Jane Doe</td>
                    <td>jane.doe@example.com</td>
                    <td>+33785705468</td>
                    <td>980</td>
                    <td>
                      <button class="btn btn-sm btn-primary">View</button>
                    </td>
                  </tr>
                  <tr class="table-warning table-active">
                    <th scope="row">3</th>
                    <td>Emma Stone</td>
                    <td>emma.stone@example.com</td>
                    <td>+33785705469</td>
                    <td>970</td>
                    <td>
                      <button class="btn btn-sm btn-primary">View</button>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row">4</th>
                    <td>John Carlio</td>
                    <td>john.carlio82@example.com</td>
                    <td>+33785705467</td>
                    <td>1002</td>
                    <td>
                      <button class="btn btn-sm btn-primary">View</button>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row">5</th>
                    <td>John Carlio</td>
                    <td>john.carlio82@example.com</td>
                    <td>+33785705467</td>
                    <td>1002</td>
                    <td>
                      <button class="btn btn-sm btn-primary">View</button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Winner List Page</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
      body {
        background-color: #cae4fc;
      }
      /* Boostrap override style */
      .table {
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

      thead th {
        background-color: #f5f5f5;
      }
      /* .table-primary,
      .table-primary > th,
      .table-primary > td {
        background-color: gold !important;
      }
      .table-secondary,
      .table-secondary > th,
      .table-secondary > td {
        background-color: silver !important;
      }

      .table-info,
      .table-info > th,
      .table-info > td {
        background-color: #cd7f32 !important;
      } */
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
      $(function () {
        $("#sidebar").load("SidebarAdmin.html");
      });
    </script>
  </head>
  <body>
    <div class="d-flex">
      <div id="sidebar"></div>
      <div style="flex-grow: 1">
        <button
          type="button"
          class="btn btn-primary m-3"
          onclick="history.back();"
        >
          <i class="fa fa-arrow-left"></i> Back
        </button>
        <h1 class="text-center m-2">List of Winners</h1>
        <!-- Table section -->
        <div class="container">
          <div class="row mt-5">
            <div class="col-sm">
              <div class="row">
                <div class="fs-4 col-auto fw-bold">Winner List of Month:</div>
                <div class="col-auto">
                  <select class="form-select">
                    <option>Jan</option>
                    <option>Feb</option>
                    <option>Mar</option>
                    <option>Apr</option>
                  </select>
                </div>
                <div class="col-auto">
                  <select class="form-select">
                    <option>2023</option>
                    <option>2024</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="col-sm-4 text-muted text-end">
              Updates Everyday at 12 AM and 12 PM
            </div>
          </div>
          <div class="row mt-5">
            <div class="col-sm">
              <table class="table table-hover table-responsive text-center">
                <thead class="table-dark">
                  <tr>
                    <th scope="col">Ranking</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Phone number</th>
                    <th scope="col">Carbon Score</th>
                    <th scope="col">Details</th>
                  </tr>
                </thead>
                <tbody>
                  <tr class="table-warning">
                    <th scope="row">1</th>
                    <td>John Carlio</td>
                    <td>john.carlio82@example.com</td>
                    <td>+33785705467</td>
                    <td>1002</td>
                    <td>
                      <a href="WinnerDetails.html"
                        ><button class="btn btn-sm btn-primary">View</button></a
                      >
                    </td>
                  </tr>
                  <tr class="table-secondary table-active">
                    <th scope="row">2</th>
                    <td>Jane Doe</td>
                    <td>jane.doe@example.com</td>
                    <td>+33785705468</td>
                    <td>980</td>
                    <td>
                      <button class="btn btn-sm btn-primary">View</button>
                    </td>
                  </tr>
                  <tr class="table-warning table-active">
                    <th scope="row">3</th>
                    <td>Emma Stone</td>
                    <td>emma.stone@example.com</td>
                    <td>+33785705469</td>
                    <td>970</td>
                    <td>
                      <button class="btn btn-sm btn-primary">View</button>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row">4</th>
                    <td>John Carlio</td>
                    <td>john.carlio82@example.com</td>
                    <td>+33785705467</td>
                    <td>1002</td>
                    <td>
                      <button class="btn btn-sm btn-primary">View</button>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row">5</th>
                    <td>John Carlio</td>
                    <td>john.carlio82@example.com</td>
                    <td>+33785705467</td>
                    <td>1002</td>
                    <td>
                      <button class="btn btn-sm btn-primary">View</button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="mt-5 p-4 bg-dark text-white text-center">
          <p>Footer</p>
        </div>
      </div>
    </div>
  </body>
</html>
