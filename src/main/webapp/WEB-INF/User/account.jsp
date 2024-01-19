<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>MBIP CarbonCut</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="icon" href="<c:url value="/resources/assets/MBIP-logo.png" />" type="image/x-icon" />
<link rel="stylesheet" href="edit_account.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />

<link href="<c:url value="/resources/styles/User/account.css" />"
	rel="stylesheet">
</head>
<body
	style="background-image: url('<c:url value="/resources/assets/bg-login.png" />');">
	<div class="custom-container">
		<div class="sidebar bg-white"></div>
		<div class="main-content">
			<div class="account bg-white">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">Account Setting</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#">Notification</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#">Language</a>
					</li>
				</ul>

				<div class="p-2 px-3">
					<div class="pt-3 pl-0">
						<span style="font-weight: 200; font-size: 15px">Your
							profile picture</span>
					</div>
					<div style="height: 0px; overflow: hidden">
						<input accept="image/*" type="file" id="fileInput"
							name="fileInput" />
					</div>

					<div class="d-flex mt-3">
						<button class="upload-image bg-white" onclick="chooseFile()">
							<svg xmlns="http://www.w3.org/2000/svg" fill="none"
								viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
								class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round"
									d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                </svg>
							<span class="upload-text">Upload your </span> <span
								class="upload-text">photo</span>
						</button>
						<div class="preview ml-3">
							<img id="blah" src="#" alt="" />
						</div>
					</div>
					<script>
              function chooseFile() {
                document.getElementById("fileInput").click();
              }

              fileInput.onchange = (evt) => {
                const [file] = fileInput.files;
                if (file) {
                  blah.src = URL.createObjectURL(file);
                }
              };
            </script>
					<form class="mt-3">
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="fullname" class="form-label">Full Name</label> <br />
								<span>muhammad adam bin yaacob</span>
							</div>
							<div class="col-md-6 mb-3">
								<label for="email" class="form-label">Email</label> <br /> <span>testing@gmail.com</span>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="username" class="form-label">Username</label> <br />
								<span>adamm</span>
							</div>
							<div class="col-md-6 mb-3">
								<label for="phoneNum" class="form-label">Phone Number</label> <br />
								<span>0186627394</span>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="username" class="form-label">Address</label> <br />
								<span>UTM, Skudai</span>
							</div>
							<div class="col-md-6 mb-3">
								<label for="phoneNum" class="form-label">Household
									Type</label> <br /> <span>flat</span>
							</div>
						</div>
						<div class="row mb-4">
							<div class="col-md-6 mb-3">
								<label for="username" class="form-label">No. of People</label> <br />
								<span>1</span>
							</div>
						</div>
						<!-- <div class="row">
                <div class="col-md-12 mb-4">
                  <label for="Bio" class="form-label">Bio</label>
                  <textarea class="form-control" id="Bio" rows="3"></textarea>
                </div>
              </div> -->
						<button class="mb-2 btn rounded-3 btn-primary" type="submit">
							Edit Profile</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>
