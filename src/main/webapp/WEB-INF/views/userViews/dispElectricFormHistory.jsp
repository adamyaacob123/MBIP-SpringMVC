<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Electric Consumption</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="icon" href="<c:url value="/resources/assets/MBIP-logo.png" />" type="image/x-icon" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/resources/styles/User/UserDashboard.css"/>" rel="stylesheet">
</head>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // Load UserSidebar.jsp into the sidebar div
            $("#sidebar").load("UserSidebar");

            // You can add more code here to handle other dashboard functionalities
        });
        
        const monthOrder = {
        	    'jan': 1,
        	    'feb': 2,
        	    'mar': 3,
        	    'apr': 4,
        	    'may': 5,
        	    'jun': 6,
        	    'jul': 7,
        	    'aug': 8,
        	    'sep': 9,
        	    'oct': 10,
        	    'nov': 11,
        	    'dec': 12
        	};

        function sortTable(columnIndex) {
            var table, rows, switching, i, x, y, shouldSwitch, direction, switchcount = 0;
            table = document.querySelector(".table");
            switching = true;
            direction = "asc"; 
            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("tr");
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    
                    // Skip rows that are not displayed (filtered out)
                    if (rows[i].style.display === "none" || rows[i + 1].style.display === "none") {
                        continue;
                    }

                    x = rows[i].getElementsByTagName("TD")[columnIndex];
                    y = rows[i + 1].getElementsByTagName("TD")[columnIndex];
                    
                    // Handle sorting for "Period" column differently
                    if (columnIndex === 1) { // Assuming the "Period" column is at index 1
                        let xValue = monthOrder[x.textContent.toLowerCase().trim().substring(0, 3)] || x.textContent.toLowerCase();
                        let yValue = monthOrder[y.textContent.toLowerCase().trim().substring(0, 3)] || y.textContent.toLowerCase();
                        if ((direction === "asc" && xValue > yValue) || (direction === "desc" && xValue < yValue)) {
                            shouldSwitch = true;
                            break;
                        }
                    } else {
                        // Regular string comparison for other columns
                        if ((direction === "asc" && x.textContent.toLowerCase() > y.textContent.toLowerCase()) || 
                            (direction === "desc" && x.textContent.toLowerCase() < y.textContent.toLowerCase())) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount === 0 && direction === "asc") {
                        direction = "desc";
                        switching = true;
                    }
                }
            }
        }
        	
        	function filterByYear() {
        	    var input, filter, table, tr, td, i, txtValue;
        	    input = document.getElementById("yearSelect");
        	    filter = input.value;
        	    table = document.querySelector(".table");
        	    tr = table.getElementsByTagName("tr");

        	    // Loop through all table rows, and hide those that don't match the selected year
        	    for (i = 1; i < tr.length; i++) { // Start from 1 to skip the header row
        	        td = tr[i].getElementsByTagName("td")[0]; // Assuming the year is in the first column
        	        if (td) {
        	            txtValue = td.textContent || td.innerText;
        	            if (filter === "" || txtValue === filter) {
        	                tr[i].style.display = "";
        	            } else {
        	                tr[i].style.display = "none";
        	            }
        	        }       
        	    }
        	}
        	
        	$(document).ready(function() {
                // Check if there's a success message
                var successMessage = "${message}";
                if (successMessage) {
                    // Show the success modal
                    new bootstrap.Modal(document.getElementById('successModal')).show();
                }
                
                $('#deleteConfirmationModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget); // Button that triggered the modal
                    var year = button.data('year'); // Extract info from data-* attributes
                    var period = button.data('period');
                    
                    console.log("Year: ", year); // Should show the year or undefined if not set
                    console.log("Period: ", period); // Should show the period

                    // Ensure the contextPath variable is defined
                    var contextPath = "${pageContext.request.contextPath}";
                    console.log("Context Path: ", contextPath); // Should show the context path

                    // Construct the URL for deletion
                    var deleteUrl = contextPath + "/deleteCarbonElectric?year=" + year + "&period=" + period;
                    console.log("Delete URL: ", deleteUrl); // Should show the complete URL

                    // Set the href attribute of the modal's delete button
                    $('#deleteConfirmButton').attr('href', deleteUrl);
                });
            });
    </script>
<style>
.bg-success {
  background-color: #00ff00 !important; /* A lighter green color */
}
</style>
<body style="background-image: url('<c:url value="/resources/assets/bg-login.png" />');">
    <div id="sidebar"></div>
    <div class="dashboard-content">
        <div class="dashboard-header">
            <h1 style="text-align: center;">Electric Form Consumption History</h1>
        </div>
        	
	    <a onclick="window.location.href='<c:url value='/User'/>'" class="btn btn-primary">Back</a><br><br>
	    <c:choose>
		    <c:when test="${empty forms}">
	    		<p>No forms available to display.</p>
			</c:when>
			<c:otherwise>
			    <div class="container bg-white pt-2 pb-2 rounded">
			    	<div class="year-selector">
					    <label for="yearSelect">Select Year: </label>
					    <select id="yearSelect" onchange="filterByYear()">
					        <option value="">All Years</option>
					        <!-- Add options dynamically or hardcode them -->					       
					        <option value="2024">2024</option>
					        <option value="2025">2025</option>
					        <option value="2026">2026</option>
					        <option value="2027">2027</option>
					        <!-- ... other years ... -->
					    </select>
					</div>					    
				    <!-- Add Bootstrap class 'table' to style the table -->
				    <table class="table table-bordered table-hover">
				        <thead class="table-primary">
				            <tr>
				                <th scope="col">Year </th>
				                <th scope="col">Period <button onclick="sortTable(1)" class="btn btn-info btn-sm"><i class="fas fa-sort"></i></button></th>
				                <th scope="col">Amount (kWh) <button onclick="sortTable(2)" class="btn btn-info btn-sm"><i class="fas fa-sort"></i></button></th>
				                <th scope="col">File </th>
				                <th scope="col">Status </th>
				                <th scope="col">Action </th>
				            </tr>
				        </thead>
				        <tbody>
				            <c:forEach items="${forms}" var="form">
				                <tr>
				                    <td><c:out value="${form.electricYear}" /></td>
				                    <td style="text-transform:uppercase"><c:out value="${form.electricPeriod}" /></td>
				                    <td><c:out value="${form.electricAmount}" /></td>
				                    <td><c:out value="${form.electricFile}" /></td>
				                    <td class="${form.electricStatus == 'pending' ? 'bg-warning' : 
							                    form.electricStatus == 'approved' ? 'bg-success' : 
							                    'bg-danger text-white'}"><c:out value="${form.electricStatus}" /></td>
				                    <td>
				                        <!-- Add Bootstrap classes for buttons -->
				                        <a href="<c:url value='/updateCarbonElectric?year=${form.electricYear}&period=${form.electricPeriod}'/>" class="btn btn-warning btn-sm">Update</a>
				                        <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteConfirmationModal" data-year="${form.electricYear}" data-period="${form.electricPeriod}">Delete</button>
				                    </td>                
				                </tr>
				            </c:forEach>
				        </tbody>
				    </table>
				</div>
		    </c:otherwise>
	    </c:choose>     
    </div>
    <!-- Delete Confirmation Modal (outside the loop, present only once) -->
	<div class="modal fade" id="deleteConfirmationModal" tabindex="-1" aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="deleteConfirmationModalLabel">Confirm Deletion</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        Are you sure you want to delete this item?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
	        <a href="<c:url value="/displayElectricForm"/>" class="btn btn-danger" id="deleteConfirmButton">Delete</a>
	      </div>
	    </div>
	  </div>
	</div>
			
    <!-- Success Message Modal -->
	<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="successModalLabel">Success</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        ${message}
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>  
</body>
</html>