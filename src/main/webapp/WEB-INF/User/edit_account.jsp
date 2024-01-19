<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>MBIP CarbonCut</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="icon"
	href="<c:url value="/resources/assets/MBIP-logo.png" />"
	type="image/x-icon" />
<link rel="stylesheet" href="account.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />

<link href="<c:url value="/resources/styles/User/edit_account.css" />"
	rel="stylesheet">
</head>
<body
	style="background-image: url('<c:url value="/resources/assets/bg-login.png" />');">
<body>
	<div class="custom-container">
		<div class="sidebar bg-white"></div>
		<div class="main-content">
			<div class="account bg-white">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">Account Setting</a></li>
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

					<form class="mt-3">
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
						<div class="d-flex gap-3">
							<div class="mb-3 flex-grow-1">
								<label for="fullname" class="form-label">Full Name</label> <input
									type="text" class="form-control" id="fullname" required />
							</div>
							<div class="mb-3 flex-grow-1">
								<label for="username" class="form-label">Username</label> <input
									type="text" class="form-control" id="username" required />
							</div>
						</div>
						<div class="d-flex gap-3">
							<div class="mb-3 flex-grow-1">
								<label for="icNum" class="form-label">Address</label> <input
									type="text" class="form-control" id="icNum" required />
							</div>
							<div class="mb-3 flex-grow-1">
								<label for="phoneNum" class="form-label">Phone Number</label> <input
									type="text" class="form-control" id="phoneNum" required />
							</div>
						</div>
						<div class="d-flex gap-3">
							<div class="mb-3 flex-grow-1">
								<label for="email" class="form-label">Email</label> <input
									type="email" class="form-control" id="email" required />
							</div>
							<div class="mb-3 flex-grow-1 position-relative">
								<label for="password" class="form-label">Password</label> <input
									type="password" class="form-control" id="password" required />
								<span id="eye-icon"
									class="position-absolute end-0 top-35 translate-middle-y"
									style="cursor: pointer"> <svg
										xmlns="http://www.w3.org/2000/svg" fill="none"
										viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
										class="wi-6 hi-6 close-eye">
                      <path stroke-linecap="round"
											stroke-linejoin="round"
											d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228l-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88" />
                    </svg> <svg xmlns="http://www.w3.org/2000/svg" fill="none"
										viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
										class="wi-6 hi-6 open-eye" style="display: none">
                      <path stroke-linecap="round"
											stroke-linejoin="round"
											d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z" />
                      <path stroke-linecap="round"
											stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                    </svg>
								</span>

								<script>
                    document.addEventListener("DOMContentLoaded", function () {
                      const passwordInput = document.getElementById("password");
                      const eyeIcon = document.getElementById("eye-icon");
                      const openEyeIcon = eyeIcon.querySelector(".open-eye");
                      const closeEyeIcon = eyeIcon.querySelector(".close-eye");

                      eyeIcon.addEventListener("click", function () {
                        const type =
                          passwordInput.getAttribute("type") === "password"
                            ? "text"
                            : "password";
                        passwordInput.setAttribute("type", type);

                        // Toggle the visibility of the eye icons
                        openEyeIcon.style.display =
                          type === "password" ? "none" : "block";
                        closeEyeIcon.style.display =
                          type === "password" ? "block" : "none";
                      });
                    });
                  </script>
							</div>
						</div>
						<div class="d-flex gap-3">
							<div class="d-flex gap-3 mb-3 flex-grow-1">
								<span class="mb-2"> Household Type: </span>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="HouseType"
										id="highrise" required /> <label
										class="form-check-label" for="flexRadioDefault1">
										Highrise </label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="HouseType"
										id="landed" required /> <label
										class="form-check-label" for="landed"> Landed </label>
								</div>
							</div>

							<div
								class="d-flex mb-5 align-items-center justify-content-center">
								<span style="margin-right: 20px">No. of people: </span>
								<div>
									<select class="form-select" aria-label="Default select example">
										<option selected>1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<!-- <option value="6">6</option> -->
									</select>
								</div>
							</div>
						</div>
						<!-- <div class="mb-4">
                <label for="Bio" class="form-label">Bio</label>
                <textarea class="form-control" id="Bio" rows="3"></textarea>
              </div> -->
						<button class="mb-2 btn rounded-3 btn-primary" type="submit">
							Update Profile</button>
						<button class="mb-2 btn rounded-3" type="reset">Reset</button>
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
