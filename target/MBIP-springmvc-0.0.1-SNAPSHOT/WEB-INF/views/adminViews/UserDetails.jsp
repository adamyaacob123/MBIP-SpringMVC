<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Details</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
body {
  background-color: #cae4fc;
}

#page-content-wrapper {
  flex-grow: 1;
}

/* Add your custom styles for cards and content here */
.profile-card {
  text-align: center;
}

.profile-header {
  position: relative;
  margin-top: 100px;
  padding: 10px;
  background-color: #6c5ce7; /* Match this color to your theme */
  border-radius: 10px 10px 0 0;
}

.profile-image {
  width: 120px; /* Adjust size as needed */
  height: 120px;
  border-radius: 50%;
  border: 5px solid #fff; /* White border around the image */
  position: absolute;
  top: -60px; /* Half the height to lift it above the card */
  left: calc(50% - 60px); /* Center the image */
}

.profile-name {
  margin-top: 60px; /* Push down to make space for the image */
  color: #fff;
}

.profile-email {
  color: #fff;
}

.profile-info {
  padding: 20px;
}

.profile-info p {
  margin-bottom: 10px;
  line-height: 1.5;
}

.profile-info strong {
  color: #333; /* Dark text for emphasis */
}

/* Layout adjustments */
#page-content-wrapper .row {
  --bs-gutter-x: 1.5rem; /* Adjust space between columns */
}

/* Profile card specific styles */
.card {
  padding: 1em;
  border-radius: 0.5rem;
  box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1); /* Shadow for all cards */
  background-color: #fff;
}

/* Responsive adjustments */
@media (max-width: 991px) {
  #page-content-wrapper .row {
    flex-direction: column; /* Stack the columns on smaller screens */
  }
}
    
        /* .user-details-container {
            margin-top: 20px;
        }
        .profile-img {
            width: 150px;
            height: 150px;
            background: url('/path/to/your/default/image.png') center center no-repeat;
            background-size: cover;
            border-radius: 50%;
        } */
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Load AdminSidebar.jsp into the sidebar div
            $("#sidebar").load("AdminSidebar");

            // You can add more code here to handle other dashboard functionalities
        });
    </script>
</head>
<body>
<div class="d-flex">
      <div id="sidebar"></div>
      <div class="px-5 py-3" style="flex-grow: 1; margin-left: 250px;">
        <button
          type="button"
          class="btn btn-primary m-3"
          onclick="history.back();"
        >
          <i class="fa fa-arrow-left"></i> Back
        </button>
		<h1 class="text-center m-2">User Details</h1>
        <div class="container">
          <div class="row mt-5">
            <div class="col-lg-4">
              <div class="card">
                <div class="card-body">
                  <div class="profile-card">
                    <div class="profile-header">
                      <img
                        src="dummy1.png"
                        alt="Profile Image"
                        class="profile-image"
                      />
                      <h3 class="profile-name">${user.name}</h3>
                      <p class="profile-email">${user.email}</p>
                    </div>
                    <div class="profile-info">
                      <p class="text-center"><strong>ID:</strong> ${user.id}</p>
                      <p class="text-center"><strong>Address:</strong> ${user.address}</p>
                      <p class="text-center"><strong>Phone Number:</strong> ${user.phoneNum}</p>
                      <p class="text-center"><strong>Household:</strong> ${user.household}</p>
                      <p class="text-center"><strong>People No:</strong> ${user.peopleNo}</p>                      
                      <p class="text-center"><strong>User Level:</strong> ${user.userLevel}</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- Graphs Section -->
            <div class="col-lg-8">
              <!-- Carbon Overview Chart -->
              <div class="card mb-4">
                <div class="card-body">
                  <canvas id="carbonOverviewChart"></canvas>
                </div>
              </div>
              <!-- Tabs for different consumption charts -->
              <ul class="nav nav-tabs mb-4" id="consumptionTabs" role="tablist">
                <li class="nav-item" role="presentation">
                  <button
                    class="nav-link active"
                    id="water-tab"
                    data-bs-toggle="tab"
                    data-bs-target="#water"
                    type="button"
                    role="tab"
                    aria-controls="water"
                    aria-selected="true"
                  >
                    Water Consumption
                  </button>
                </li>
                <li class="nav-item" role="presentation">
                  <button
                    class="nav-link"
                    id="electricity-tab"
                    data-bs-toggle="tab"
                    data-bs-target="#electricity"
                    type="button"
                    role="tab"
                    aria-controls="electricity"
                    aria-selected="false"
                  >
                    Electricity Consumption
                  </button>
                </li>
                <li class="nav-item" role="presentation">
                  <button
                    class="nav-link"
                    id="recycle-tab"
                    data-bs-toggle="tab"
                    data-bs-target="#recycle"
                    type="button"
                    role="tab"
                    aria-controls="recycle"
                    aria-selected="false"
                  >
                    Recycle Activity
                  </button>
                </li>
              </ul>

              <!-- Tab Content -->
              <div class="card mb-4">
                <div class="tab-content" id="consumptionContent">
                  <div
                    class="tab-pane fade show active"
                    id="water"
                    role="tabpanel"
                    aria-labelledby="water-tab"
                  >
                    <canvas id="waterConsumptionChart"></canvas>
                  </div>
                  <div
                    class="tab-pane fade"
                    id="electricity"
                    role="tabpanel"
                    aria-labelledby="electricity-tab"
                  >
                    <canvas id="electricityConsumptionChart"></canvas>
                  </div>
                  <div
                    class="tab-pane fade"
                    id="recycle"
                    role="tabpanel"
                    aria-labelledby="recycle-tab"
                  >
                    <canvas id="recycleActivityChart"></canvas>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="d-flex justify-content-center mb-3">
        <button class="btn btn-success">Validate</button>
    </div>
    <script>
      // Chart.js code for Carbon Overview Doughnut Chart
      const carbonCtx = document
        .getElementById("carbonOverviewChart")
        .getContext("2d");
      const carbonOverviewChart = new Chart(carbonCtx, {
        type: "doughnut",
        data: {
          labels: ["Electricity", "Water", "Recycle Activity"],
          datasets: [
            {
              data: [1946, 2498, 1080],
              backgroundColor: [
                "rgba(255, 99, 132, 0.5)",
                "rgba(54, 162, 235, 0.5)",
                "rgba(255, 206, 86, 0.5)",
              ],
              borderWidth: 1,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
        },
      });

      // Function to generate a random dataset for demonstration
      function getRandomData() {
        return Array.from({ length: 12 }, () =>
          Math.floor(Math.random() * 100)
        );
      }

      const chartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              stepSize: 20, // This will ensure the step size is consistent at every 10 units
            },
          },
        },
      };

      // Setting chart height in javascript to ensure same height for all charts
      document.getElementById("water").style.height = "200px";
      document.getElementById("electricity").style.height = "200px";
      document.getElementById("recycle").style.height = "200px";

      // Chart.js code for Water Consumption Line Chart
      const waterCtx = document
        .getElementById("waterConsumptionChart")
        .getContext("2d");
      const waterConsumptionChart = new Chart(waterCtx, {
        type: "line",
        data: {
          labels: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          datasets: [
            {
              label: "Water Consumption",
              data: getRandomData(),
              backgroundColor: "rgba(54, 162, 235, 0.2)",
              borderColor: "rgba(54, 162, 235, 1)",
              borderWidth: 2,
              fill: true,
            },
          ],
        },
        options: chartOptions,
      });

      // Chart.js code for Electricity Consumption Line Chart
      const electricityCtx = document
        .getElementById("electricityConsumptionChart")
        .getContext("2d");
      const electricityConsumptionChart = new Chart(electricityCtx, {
        type: "line",
        data: {
          labels: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          datasets: [
            {
              label: "Electricity Consumption",
              data: getRandomData(),
              backgroundColor: "rgba(255, 206, 86, 0.2)",
              borderColor: "rgba(255, 206, 86, 1)",
              borderWidth: 2,
              fill: true,
            },
          ],
        },
        options: chartOptions,
      });

      // Chart.js code for Recycle Activity Line Chart
      const recycleCtx = document
        .getElementById("recycleActivityChart")
        .getContext("2d");
      const recycleActivityChart = new Chart(recycleCtx, {
        type: "line",
        data: {
          labels: [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          datasets: [
            {
              label: "Recycle Activity",
              data: getRandomData(),
              backgroundColor: "rgba(75, 192, 192, 0.2)",
              borderColor: "rgba(75, 192, 192, 1)",
              borderWidth: 2,
              fill: true,
            },
          ],
        },
        options: chartOptions,
      });
    </script>
</body>
</html>