<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Input Oil Consumption</title>
    <link rel="icon" href="<c:url value="/resources/assets/MBIP-logo.png" />" type="image/x-icon" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
    rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
    crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="/resources/styles/User/Carbon.css" />">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script> <!--to include user sidebar-->
    <script>
        $(document).ready(function(){
            $("#user-sidebar").load("UserSidebar");
        });
        
        var selectedCategory = sessionStorage.getItem("selectedCategory");
        if (selectedCategory) {
            $("#inputType").val(selectedCategory);
        }
    </script>
</head>
<body style="background-color: #F0B999;">
    
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 px-0" id="user-sidebar"></div><!--sidebar (take 2 column)-->
            <div class="col-md-10  py-4"> <!--for 2 other part (categories, form) -->
                <h1 style="text-align: center;"><b>Carbon Data</b></h1>
                <div class="row justify-content-center ">
                  
                    <!-- div into 2 part -->
                    <!--1st part for choose categories, guide (take 4 column)-->
                    <div class="col-md-4 custom-bg">
                        <h3 class="text-center mb-4"><b>Categories</b></h3>
                        <div class="mb-3">
                            <select class="form-select" id="inputType" onchange="redirectToPage()">
                                
                                <option value="water" ${currentCategory == 'water' ? 'selected' : ''}>Water Consumption</option>
                                <option value="electricity" ${currentCategory == 'electricity' ? 'selected' : ''}>Electricity Consumption</option>
                                <option value="waste" ${currentCategory == 'waste' ? 'selected' : ''}>Recycle Weight</option>
                            </select>
                        </div>
                        
                        <script>
                            function redirectToPage() {
                                var select = document.getElementById("inputType");
                                var selectedValue = select.options[select.selectedIndex].value;
                             	// Store the selected value in sessionStorage
                                sessionStorage.setItem("selectedCategory", selectedValue);
                                switch (selectedValue) {
                                    case "water":
                                        window.location.href = "<c:url value="/CarbonWater"/>";
                                        break;
                                    case "electricity":
                                        window.location.href = "<c:url value="/CarbonElectric"/>";
                                        break;
                                    case "waste":
                                        window.location.href = "<c:url value="/CarbonOil"/>";
                                        break;
                                    // default:
                                    //     break;
                                }
                            }
                        </script>

                        <div class="mb-3">
                            <label for="guide"><b>Form Guide</label></b>
                            <ol>
                                <li>Select residence and enter all relevant data.</li>
                                <li>Input precise amount based on the data type (kg).</li>
                                <li>Provide any supporting documents related to recycle activity (e.g., recycling receipts, record).</li>
                            </ol>
                            
                            <img src="<c:url value="resources/img/earth.png" />" style="width: 325px; height: 150px;">
                        </div>
                        
                    </div>

                     <!--2nd part for input carbon (take 6 column)-->
                    <div class="col-md-6">
                    	<form action="<c:url value="saveWasteForm"/>" method="post" enctype="multipart/form-data">
                        <div class="container">
                            <h3 class="mb-4"><b>Oil Consumption</b></h3>

                            <div class="mb-3">
                                <label for="factor">Carbon Emission Factor</label>
                                    <div class="input-group">
                                            <input type="text" class="form-control" value="2.86" readonly>
                                            <span class="input-group-text">kgCO / kg</span>
                                </div>
                                </div>
                    
                                <div class="mb-3">
                                    <label for="amount">Amount</label>
                                        <div class="input-group">
                                                <input type="text" class="form-control" placeholder="Input Amount" id="amount" name="amount">
                                                <span class="input-group-text">kg</span>
                                        </div>
                                </div>
                    
                                <div class="mb-3">
                                <div class="row mb-3">
                                    <!--calendar api?-->
                                   <label for="period">Period Interval</label>
                                   <div class ="col">
                                   <select class="form-select" id="period" name="period">
                                    <option value="" disabled selected>Month</option>
                                    <option value="Jan">JAN</option>
                                    <option value="Feb">FEB</option>
                                    <option value="Mar">MAR</option>
                                    <option value="Apr">APR</option>
                                    <option value="May">MAY</option>
                                    <option value="Jun">JUN</option>
                                    <option value="Jul">JUL</option>
                                    <option value="Aug">AUG</option>
                                    <option value="Sep">SEP</option>
                                    <option value="Oct">OCT</option>
                                    <option value="Nov">NOV</option>
                                    <option value="Dec">DEC</option>
                               </select></div>
                               <div class ="col">
                               <select class="form-select" id="year" name="year">
                                    <option value="" disabled selected>Year</option>
                                    <option value="2023">2023</option>
                                    <option value="2024">2024</option>
                                    <option value="2025">2025</option>
                                    <option value="2026">2026</option>
                                    <option value="2027">2027</option>
                               	   </select>
                               </div>
                   			</div>
                   
                               <!-- <div class="mb-3">
                                   <label for="year">Year</label>
                                   <select class="form-select" id="year">
                                       <option value="" disabled selected>Year</option>
                                       <option value="2019">2019</option>
                                       <option value="2020">2020</option>
                                       <option value="2021">2021</option>
                                       <option value="2022">2022</option>
                                       <option value="2023">2023</option>
                                       <option value="2024">2024</option>
                                   </select>
                               </div> -->
                                
                                <div class="mb-3">
                                    <label for="file">Recycle Bills</label>
                                    <input type="file" class="form-control" id="file" name="file" accept=".jpg, .jpeg, .png, .pdf">
                                    <label class="form-text">*PDF/JPEG/PNG</label>
                                </div>
                            
                                <div class="mb-3 d-flex justify-content-center">
                                    <button type="submit" class="btn btn-secondary">Save</button>
                                </div>
                        </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
    crossorigin="anonymous"></script>
</body>
</html>