<!DOCTYPE html>
<html>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <head>
    <link rel="stylesheet" href="SidebarAdmin.css" />
  </head>
  <body>
    <div class="sidebar">
      <div class="user-info">
        <img
          src="thumbnail.jpeg"
          alt="User"
          style="width: 75px; height: 75px"
        />
        <div>
          <p>Admin ID<br />Aira Sofia</p>
        </div>
      </div>
      <hr
        style="border: none; height: 1px; background-color: rgb(222, 222, 222)"
      />
      <h5 style="margin-left: 10px">MAIN</h5>
      <a href="AdminDashboard.html" onclick="makeActive(event)">Dashboard</a>
      <a href="#manage-account" onclick="makeActive(event)">Manage Account</a>
      <a href="ValidateWinner.html" onclick="makeActive(event)"
        >Validate Winner</a
      >
      <a href="#summary" onclick="makeActive(event)">User Summary</a>
      <hr
        style="border: none; height: 1px; background-color: rgb(222, 222, 222)"
      />
      <!-- <h5 style="margin-left: 10px;">SETTINGS</h5> -->
      <!-- <div class="settings-dropdown">
    <a href="#settings" onclick="makeActive(event)">Settings</a>
    <div class="dropdown-content">
      <a href="#" onclick="makeActive(event)">Link 1</a>
      <a href="#" onclick="makeActive(event)">Link 2</a>
      <a href="#" onclick="makeActive(event)">Link 3</a>
    </div>
  </div> -->
      <a href="#help" onclick="makeActive(event)">Help</a><br />
      <a
        href="#logout"
        onclick="makeActive(event)"
        style="
          color: red;
          text-align: center;
          border: 1px solid black;
          border-radius: 1cm;
        "
        >Logout Account</a
      >
    </div>
  </body>
</html>
