<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>User List</title>
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
        <h1 class="text-center m-2">User List</h1>
        <!-- Table section -->
        <div class="container">
          <div class="row mt-5 justify-content-center">
            <div class="col-12 col-md-6">
              <form action="userList" method="get">
                <div class="input-group">
                  <input
                    type="text"
                    class="form-control"
                    name="searchQuery"
                    placeholder="Search users by name..."
                    aria-label="Search users"
                    aria-describedby="button-search"
                  />
                  <button
                    class="btn btn-outline-secondary"
                    type="submit"
                    id="button-search"
                  >
                    <i class="fa fa-search"></i>
                  </button>
                </div>
              </form>
            </div>
          </div>
          <div class="row mt-5">
            <div class="col-12">
              <c:if test="${participantCount > 0}">
                <h2>Participants</h2>
                <table
                  class="table table-hover table-responsive text-center align-middle"
                >
                  <thead class="table-dark">
                    <tr>
                      <th scope="col">No.</th>
                      <th scope="col">Profile</th>
                      <th scope="col">User ID</th>
                      <th scope="col">Name</th>
                      <th scope="col">Email</th>
                      <th scope="col">Phone Number</th>
                      <th scope="col">User Level</th>
                      <th scope="col">Details</th>
                    </tr>
                  </thead>
                  <tbody>
                    <% int participantCounter = 0; %>
                    <c:forEach items="${users}" var="user" varStatus="status">
                      <c:if test="${user.userLevel eq 'participant'}">
                        <% participantCounter++; %>
                        <tr>
                          <td><%= participantCounter %></td>
                          <td>
                            <%--
                            <c:choose>
                              <c:when test="${not empty user.profile_image}">
                                <img
                                  src="data:image/jpeg;base64,${user.profile_image}"
                                  alt="User Image"
                                  width="50"
                                  height="50"
                                />
                              </c:when>
                              <c:otherwise>
                                <img
                                  src="blank-profile.png"
                                  alt="Default Image"
                                  width="50"
                                  height="50"
                                />
                              </c:otherwise>
                            </c:choose>
                            --%> <img src="<c:url
                              value="/resources/assets/blank-profile.png"
                            />" alt="Default Image" width="40" height="40"/>
                          </td>
                          <td>${user.id}</td>
                          <td>${user.name}</td>
                          <td>${user.email}</td>
                          <td>${user.phoneNum}</td>
                          <td>${user.userLevel}</td>

                          <td>
                            <a
                              href="userDetails?userId=${user.id}"
                              class="btn btn-sm btn-primary"
                              >View</a
                            >
                          </td>
                        </tr>
                      </c:if>
                    </c:forEach>
                  </tbody>
                </table>
              </c:if>
            </div>
            <div class="col-12">
              <c:if test="${adminCount > 0}">
                <h2>Admins</h2>
                <table
                  class="table table-hover table-responsive text-center align-middle"
                >
                  <thead class="table-dark">
                    <tr>
                      <th scope="col">No.</th>
                      <th scope="col">Profile</th>
                      <th scope="col">User ID</th>
                      <th scope="col">Name</th>
                      <th scope="col">Email</th>
                      <th scope="col">Phone Number</th>
                      <th scope="col">User Level</th>
                    </tr>
                  </thead>
                  <tbody>
                    <% int adminCounter = 0; %>
                    <c:forEach items="${users}" var="user" varStatus="status">
                      <c:if test="${user.userLevel eq 'admin'}">
                        <% adminCounter++; %>
                        <tr>
                          <td><%= adminCounter %></td>
                          <td>
                            <%--
                            <c:choose>
                              <c:when test="${not empty user.profile_image}">
                                <img
                                  src="data:image/jpeg;base64,${user.profile_image}"
                                  alt="User Image"
                                  width="50"
                                  height="50"
                                />
                              </c:when>
                              <c:otherwise>
                                <img
                                  src="blank-profile.png"
                                  alt="Default Image"
                                  width="50"
                                  height="50"
                                />
                              </c:otherwise>
                            </c:choose>
                            --%> <img src="<c:url
                              value="/resources/assets/blank-profile.png"
                            />" alt="Default Image" width="40" height="40"/>
                          </td>
                          <td>${user.id}</td>
                          <td>${user.name}</td>
                          <td>${user.email}</td>
                          <td>${user.phoneNum}</td>
                          <td>${user.userLevel}</td>
                        </tr>
                      </c:if>
                    </c:forEach>
                  </tbody>
                </table>
              </c:if>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>User List</title>
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
        <h1 class="text-center m-2">User List</h1>
        <!-- Table section -->
        <div class="container">
          <div class="row mt-5 justify-content-center">
            <div class="col-12 col-md-6">
              <div class="input-group">
                <input
                  type="text"
                  class="form-control"
                  placeholder="Search users..."
                  aria-label="Search users"
                  aria-describedby="button-search"
                />
                <button
                  class="btn btn-outline-secondary"
                  type="button"
                  id="button-search"
                >
                  <i class="fa fa-search"></i>
                </button>
              </div>
            </div>
          </div>
          <div class="row mt-5">
            <div class="col-sm">
              <h2>Participants</h2>
              <table
                class="table table-hover table-responsive text-center align-middle"
              >
                <thead class="table-dark">
                  <tr>
                    <th scope="col">No.</th>
                    <th scope="col">Profile</th>
                    <th scope="col">User ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Phone Number</th>
                    <th scope="col">User Level</th>
                    <th scope="col">Details</th>
                  </tr>
                </thead>
                <tbody>
                  <% int participantCounter = 0; %>
                  <c:forEach items="${users}" var="user" varStatus="status">
                    <c:if test="${user.userLevel eq 'participant'}">
                      <% participantCounter++; %>
                      <tr>
                        <td><%= participantCounter %></td>
                        <td>
                          <%--
                          <c:choose>
                            <c:when test="${not empty user.profile_image}">
                              <img
                                src="data:image/jpeg;base64,${user.profile_image}"
                                alt="User Image"
                                width="50"
                                height="50"
                              />
                            </c:when>
                            <c:otherwise>
                              <img
                                src="blank-profile.png"
                                alt="Default Image"
                                width="50"
                                height="50"
                              />
                            </c:otherwise>
                          </c:choose>
                          --%> <img src="<c:url
                            value="/resources/assets/blank-profile.png"
                          />" alt="Default Image" width="40" height="40"/>
                        </td>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td>${user.phoneNum}</td>
                        <td>${user.userLevel}</td>

                        <td>
                          <a
                            href="userDetails?userId=${user.id}"
                            class="btn btn-sm btn-primary"
                            >View</a
                          >
                        </td>
                      </tr>
                    </c:if>
                  </c:forEach>
                </tbody>
              </table>
            </div>
            <div class="col-sm">
              <h2>Admins</h2>
              <table
                class="table table-hover table-responsive text-center align-middle"
              >
                <thead class="table-dark">
                  <tr>
                    <th scope="col">No.</th>
                    <th scope="col">Profile</th>
                    <th scope="col">User ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Phone Number</th>
                    <th scope="col">User Level</th>
                  </tr>
                </thead>
                <tbody>
                  <% int adminCounter = 0; %>
                  <c:forEach items="${users}" var="user" varStatus="status">
                    <c:if test="${user.userLevel eq 'admin'}">
                      <% adminCounter++; %>
                      <tr>
                        <td><%= adminCounter %></td>
                        <td>
                          <%--
                          <c:choose>
                            <c:when test="${not empty user.profile_image}">
                              <img
                                src="data:image/jpeg;base64,${user.profile_image}"
                                alt="User Image"
                                width="50"
                                height="50"
                              />
                            </c:when>
                            <c:otherwise>
                              <img
                                src="blank-profile.png"
                                alt="Default Image"
                                width="50"
                                height="50"
                              />
                            </c:otherwise>
                          </c:choose>
                          --%> <img src="<c:url
                            value="/resources/assets/blank-profile.png"
                          />" alt="Default Image" width="40" height="40"/>
                        </td>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td>${user.phoneNum}</td>
                        <td>${user.userLevel}</td>
                      </tr>
                    </c:if>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
