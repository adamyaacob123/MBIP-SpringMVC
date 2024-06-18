<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
      <link rel="icon" href="<c:url value="/resources/assets/MBIP-logo.png" />" type="image/x-icon" />
    <link rel="stylesheet" href="<c:url value="/resources/styles/User/report.css" />">
   
    <script>
        $(document).ready(function(){
            $("#user-sidebar").load("UserSidebar");
        });
    </script>
</head>
<body>
	 
    <div class="report-content">
    	<div class="container-fluid">   
    		<div class="row">
		 		<div class="col-md-2 px-0" id="user-sidebar"></div>
           			<div class="col-md-10">
            		<h1 style="text-align: center;"><b>Report</b></h1>
    <!--<c:out value=" ${wasteFootprint}"/>testing -->
			           	<div class="d-flex justify-content-end mb-2">
			                  <select class="form-select w-auto" id="yearSelection" name="yearSelection">
			                    <option selected>Choose Year</option>  
			                    <option value="2022" ${selectedYear=='2022' ? 'selected' : '' }>2022</option>                                     
			                    <option value="2023" ${selectedYear=='2023' ? 'selected' : '' }>2023</option>
			                    <option value="2024" ${selectedYear=='2024' ? 'selected' : '' }>2024</option>
			                  </select>
						</div>
	    	
       					<div class="row justify-content-center" >
            
             				<div class="col-12">
                				<div class="card mb-4">
                  					<div class="card-body text-center">
                    				<h5 class="card-title ">Summary</h5>
				                    <p class="card-text">
				                    <p class="text-muted fst-italic">Year ${selectedYear}</p>
            							<div class="row">
										    <div class="col-lg-6">
										        <div class="card">
										            <div class="card-body text-center">
										                 <div class="chart-container">
										                 	<canvas id="carbonOverviewChart"></canvas>
										                 </div>
										            </div>
										        </div>
										    </div>
											<div class="col-lg-6">
											    <div class="card custom-info-card">
											        <div class="card-body">
											            <h3 class="custom-info-title">Carbon Footprint Overview</h3>
											            <hr class="custom-info-divider">
											            <div class="custom-info-item">
											                <span class="custom-info-label">Water:</span>
											                <span class="custom-info-value">
											                    <c:out value="${totalWaterFootprint}" />
											                </span>
											                <span class="custom-info-unit">kgCO₂</span>
											            </div>
											            <div class="custom-info-item">
											                <span class="custom-info-label">Electricity:</span>
											                <span class="custom-info-value">
											                    <c:out value="${totalElectricityFootprint}" />
											                </span>
											                <span class="custom-info-unit">kgCO₂</span>
											            </div>
											            <div class="custom-info-item">
											                <span class="custom-info-label">Recycle:</span>
											                <span class="custom-info-value">
											                    <c:out value="${totalRecycleFootprint}" />
											                </span>
											                <span class="custom-info-unit">kgCO₂</span>
											            </div>
											            <div class="custom-info-total">
											                <span class="custom-info-label">Total Carbon Footprint:</span>
											                <span class="custom-info-value">
											                    <c:out value="${totalCarbonFootprint}" />
											                </span>
											                <span class="custom-info-unit">kgCO₂</span>
											            </div>
											            
											        </div>
											    </div>
											</div>
										</div>
					                  </div>
					              </div>
					              </div>
					              
					              <div class="card mb-4">
   						 <div class="card-body py-4">
                    		<h5 class="card-title text-center">Detail Report</h5><br>
							<div class="row">
					            <div class="col-md-6 mb-4">
					                <div class="report-table" id="consumptionContent">
					                    <div class="report-header py-3">
					                        <h5>Water Consumption</h5>
					                        <div class="chart-container" id="water">
					                            <canvas id="waterConsumptionChart"></canvas>               
					                        </div>
					                    </div>
					                </div>
					            </div>
					        
					
					            <div class="col-md-6 mb-4">
					                <div class="report-table" id="consumptionContent">
					                    <div class="report-header py-3">
					                        <h5>Electricity Consumption</h5>
					                        <div class="chart-container" id="electricity">
					                            <canvas id="electricityConsumptionChart"></canvas>                        
					                        </div>
					                    </div>
					                </div>
					            	</div>
					             </div>
					
							<div class="row justify-content-center">
					           <div class="col-md-6 mb-4">
					                <div class="report-table" id="consumptionContent">
					                    <div class="report-header py-3">
					                        <h5>Recycle Activity</h5>
					                        <div class="chart-container" id="recycle">
					                            <canvas id="recycleActivityChart"></canvas>
					                        </div>
					                    </div>
					                    </div>
					                </div>
					            </div>
					           
					           </div>
					            </div>
					            
					            
					            
							</div>
						</div>
			    	</div>
				</div>
			</div>
    
        <script>
        function displayReport() {
            $.ajax({
                url: '<c:url value="/displayReport"/>',
                method: 'GET',
                success: function(response) {
                    console.log('Report displayed successfully');
                    window.location.href = '<c:url value="/Report"/>?id=${userId}';
                },
                error: function(xhr, status, error) {
                    console.error('Error displaying report:', error);
                }
            });
        }

		$(document).ready(function () {
	          var selectedYear = "${selectedYear}";
	          if (selectedYear) {
	            $("#yearSelection").val(selectedYear);
	          }
	        });

	        $("#yearSelection").change(function () {
	        	
	          var selectedYear = $(this).val();
	          var userId = "${user.id}";

	          window.location.href =
	            "Report?id=" + userId + "&year=" + selectedYear;
	        });

	        var waterAmountsJSON = "${waterAmounts}"
	          .replace("[", "")
	          .replace("]", "")
	          .split(", ");
	        var monthsWaterJSON = "${monthsWater}"
	          .replace("[", "")
	          .replace("]", "")
	          .split(", ");

	        var electricAmountsJSON = "${electricAmounts}"
		        .replace('[', '')
		        .replace(']', '')
		        .split(', ');
	        
	        var monthsElectricJSON = "${monthsElectric}"
	          .replace("[", "")
	          .replace("]", "")
	          .split(", ");

	        var recycleAmountsJSON = "${recycleAmounts}".replace('[', '').replace(']', '').split(', ');
	        var monthsRecycleJSON = "${monthsRecycle}"
	          .replace("[", "")
	          .replace("]", "")
	          .split(", ");

	        var waterAmounts = waterAmountsJSON.map(Number);
	        var monthsWater = monthsWaterJSON.map(String);

	        var electricAmounts = electricAmountsJSON.map(Number);
	        var monthsElectric = monthsElectricJSON.map(String);

	        var recycleAmounts = recycleAmountsJSON.map(Number);
	        var monthsRecycle = monthsRecycleJSON.map(String);
	
	        const carbonCtx = document
	          .getElementById("carbonOverviewChart")
	          .getContext("2d");
	        const carbonOverviewChart = new Chart(carbonCtx, {
	          type: "pie",
	          data: {
	            labels: ["Water", "Electricity", "Recycle Waste"],
	            datasets: [
	              {
	                data: ["${totalWaterFootprint}", "${totalElectricityFootprint}", "${totalRecycleFootprint}"],
	                backgroundColor: [
	                  "rgba(54, 162, 235, 0.5)",
	                  "rgba(255, 206, 86, 0.5)",
	                  "rgba(255, 99, 132, 0.5)",
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
            
	        const waterCtx = document.getElementById('waterConsumptionChart').getContext('2d');
            const waterConsumptionChart = new Chart(waterCtx, {
                    type: 'bar',                    
                    data: {
                        labels: monthsWater,
                        datasets: [{
                            label: "Water", 
                            backgroundColor: '#CAE4FC',
                            borderColor: '#6c757d',
                            data: waterAmounts,
                            
                        }]
                    },
    
                    options: {}
                });
            
            const electricityCtx = document.getElementById('electricityConsumptionChart').getContext('2d');
            const chart = new Chart(electricityCtx, {
                    type: 'bar',                    
                    data: {
                        labels: monthsElectric,
                        datasets: [{
                            label: "Electric",
                            backgroundColor: '#EEDDA2',
                            borderColor: '#6c757d',
                            data: electricAmounts
                        }]
                    },
    
                    options: {}
                });
            
            
            const recycleCtx = document.getElementById('recycleActivityChart').getContext('2d');
        	const recycleActivityChart = new Chart(recycleCtx, {
                type: 'bar',

                data: {
                    labels: monthsRecycle,
                    datasets: [{
                    	label: "Waste",
                        backgroundColor: '#F0B999',
                        borderColor: '#6c757d',
                        data: recycleAmounts
                    }]
                },

                options: {}
            });
		</script>
</body>
</html>
