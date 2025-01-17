<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>



<!-- This is the My Account page. It is probably the most complicated one.
	The buttons that appear here are different for every type of users. There are some common ones,
	such as the Log Out button, Control Panel and Notifications links, but for example the property owner
	can view his properties, or add new ones. This is all done through Java, and the page is created dynamically using 
	JavaScript code.  -->




<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.srccodes.utils.DBUtils"%>
<%@page import="com.srccodes.utils.MyUtils"%>
<html lang="en">
<head>
<title>Voyage</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Muli:300,400,600,700"
	rel="stylesheet">

<link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="css/animate.css">

<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="css/magnific-popup.css">

<link rel="stylesheet" href="css/aos.css">

<link rel="stylesheet" href="css/ionicons.min.css">

<link rel="stylesheet" href="css/bootstrap-datepicker.css">
<link rel="stylesheet" href="css/jquery.timepicker.css">


<link rel="stylesheet" href="css/flaticon.css">
<link rel="stylesheet" href="css/icomoon.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>

	<nav
		class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
		id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="index.html">Voyage</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#ftco-nav" aria-controls="ftco-nav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="oi oi-menu"></span> Menu
			</button>

			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active"><a
						href="${pageContext.request.contextPath}/index" class="nav-link">Home</a></li>
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/myAccount"
						class="nav-link">My Account</a></li>
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/about" class="nav-link">About</a></li>
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/contact" class="nav-link">Contact</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- END nav -->

	<section class="home-slider owl-carousel">
		<div class="slider-item"
			style="background-image: url('images/bg_4.jpg');"
			data-stellar-background-ratio="0.5">
			<div class="overlay"></div>
			<div class="container">
				<div class="row slider-text align-items-center">
					<div class="col-md-7 col-sm-12 ftco-animate">
						<p class="breadcrumbs">
							<span class="mr-2"><a href="index.html">Home</a></span> <span>Services</span>
						</p>
						<h1 class="mb-3">My Account</h1>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- END slider -->

	<section class="ftco-section bg-light">
		<form method="POST"
			action="${pageContext.request.contextPath}/myAccount">
			<div class="container">
				<div class="row justify-content-center mb-4 pb-5">
					<div class="col-md-7 text-center heading-section ftco-animate">
						<h2>My Account</h2>
					</div>
				</div>
				<div class="container">

					<div class="row justify-content-center mb-5">
						<h3>Hello,</h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${lastName}</h4>
						</div>
					</div>
					<div class="row justify-content-center mb-5">
						<h3>Your privileges:</h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${user.type}</h4>
						</div>
					</div>
					<div class="row justify-content-center  mb-5">
						<a id="ClientOnlyViewNotifications"
							href="${pageContext.request.contextPath}/clientNotifications"></a>

					</div>
					<div class="row justify-content-center  mb-5">
						<a id="AdminOnlyViewNotifications"
							href="${pageContext.request.contextPath}/adminNotifications"></a>

					</div>
					<div class="row justify-content-center">
						<a id="clientOnlyViewBookings"
							href="${pageContext.request.contextPath}/viewBookings"></a>

					</div>
					<div class="row justify-content-center  mb-5">
						<a id="ownerOnlyViewNotifications"
							href="${pageContext.request.contextPath}/notifications"></a>

					</div>
					<div class="row justify-content-center  mb-5">
						<a id="ownerOnlyAddProperty"
							href="${pageContext.request.contextPath}/newProperty"></a>

					</div>
					<div class="row justify-content-center">
						<a id="ownerOnlyViewProperty"
							href="${pageContext.request.contextPath}/viewProperty"></a>

					</div>
					<div class="row justify-content-center mb-5">Your username is : <p style="color: red;">${user.userName}</p></div>
					<div class="row justify-content-center mb-5">Your email address is : <p style="color: red;">${user.email}</p></div>
					<%
					String sql = "select count(*) as total from notification where owner_id = ?";
					String sql2 = "select count(*) as total from notification where client_id = ?";
					String sql3 = "select count(*) as total from notification where admin_id = 1";
					Connection connection;
					connection= MyUtils.getStoredConnection(request);
					PreparedStatement pstmt = connection.prepareStatement(sql);
					PreparedStatement pstmt2 = connection.prepareStatement(sql2);
					PreparedStatement pstmt3 = connection.prepareStatement(sql3);
					pstmt.setInt(1, DBUtils.getOwnerId(connection, MyUtils.getLoginedUser(session).getUserName()));
					pstmt2.setInt(1, DBUtils.getClientId(connection, MyUtils.getLoginedUser(session).getUserName()));
					//pstmt3.setInt(1, DBUtils.getAdminId(connection, MyUtils.getLoginedUser(session).getUserName()));
					ResultSet rs = pstmt.executeQuery();
					int count = 0;
					while(rs.next()){
						count = rs.getInt("total");
					}
					session.setAttribute("count", count);
					ResultSet rs2 = pstmt2.executeQuery();
					int count2 = 0;
					while(rs2.next()){
						count2 = rs2.getInt("total");
					}
					session.setAttribute("countClient", count2);
					ResultSet rs3 = pstmt3.executeQuery();
					int count3 = 0;
					while(rs3.next()){
						count3 = rs3.getInt("total");
					}
					session.setAttribute("countAdmin", count3);
					%>
					<script>
               		var jsAtt = '${user.type}';
               		var jsAtt2 = '${count}';
               		var jsAtt3 = '${countClient}';
               		var jsAtt4 = '${countAdmin}';
               		if(jsAtt == "owner"){
               			document.getElementById("ownerOnlyAddProperty").innerHTML = "List a new property?";
               			document.getElementById("ownerOnlyViewProperty").innerHTML = "View Properties";
               			if(jsAtt2 != 0){
               				document.getElementById("ownerOnlyViewNotifications").innerHTML = "View Notifications (" + jsAtt2 + " new)";
               			}
               		}else if(jsAtt == "client")
               			{
               			document.getElementById("clientOnlyViewBookings").innerHTML = "View Bookings";
               			if(jsAtt3 != 0)
               				document.getElementById("ClientOnlyViewNotifications").innerHTML = "View Notifications (" + jsAtt3 + " new)";
               			}
               		else{
               			if(jsAtt4 != 0){
               				document.getElementById("AdminOnlyViewNotifications").innerHTML = "View Notifications (" + jsAtt4 + " new)";
               			}
               		}
               		
					</script>
					<div class="row justify-content-center mb-5 pb-5">
						<input type="submit" class="search-submit btn btn-primary"
							value="Logout">
					</div>
				</div>
				<div class="row justify-content-center mb-1">
					<a href="${pageContext.request.contextPath}/controlPanel">Control Panel</a>
				</div>
			</div>
		</form>
	</section>

	<footer class="ftco-footer ftco-bg-dark ftco-section">
      <div class="container">
        <div class="row justify-content-center">
            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved 
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
          </div>
    </footer>



	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke="#eeeeee" />
			<circle class="path" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
	</div>


	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-migrate-3.0.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.easing.1.3.js"></script>
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/jquery.stellar.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/aos.js"></script>
	<script src="js/jquery.animateNumber.min.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
	<script src="js/jquery.timepicker.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="js/google-map.js"></script>
	<script src="js/main.js"></script>

</body>
</html>