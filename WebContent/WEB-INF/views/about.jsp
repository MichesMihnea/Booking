<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.srccodes.utils.DBUtils"%>
<%@page import="com.srccodes.utils.MyUtils"%>
<!DOCTYPE html>


<!-- This is the "About" page
	It shows some statistics about the application
	These have to be calculated by using data from the database
	So we use java code in order to retrieve the data each time the page is created
-->



<html lang="en">
  <head>
    <title>Voyage</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Muli:300,400,600,700" rel="stylesheet">

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
    <style>
       /* Set the size of the div element that contains the map */
      #map {
        height: 400px;  /* The height is 400 pixels */
        width: 50%;  /* The width is the width of the web page */
       }
    </style>
  </head>
  <body>
    
    <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
      <div class="container">
        <a class="navbar-brand" href="index.html">Voyage</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="oi oi-menu"></span> Menu
        </button>

        <div class="collapse navbar-collapse" id="ftco-nav">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item active"><a href="${pageContext.request.contextPath}/index" class="nav-link">Home</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/myAccount" class="nav-link">My Account</a></li>
           
            <li class="nav-item"><a href="${pageContext.request.contextPath}/about" class="nav-link">About</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/contact" class="nav-link">Contact</a></li>
          </ul>
        </div>
      </div>
    </nav>
    <!-- END nav -->
    
    <section class="home-slider owl-carousel">
      <div class="slider-item" style="background-image: url('images/bg_3.jpg');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container">
          <div class="row slider-text align-items-center">
            <div class="col-md-7 col-sm-12 ftco-animate">
              <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>About</span></p>
              <h1 class="mb-3">About us</h1>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- END slider -->

    <section class="ftco-section-2">
      <div class="container-fluid d-flex">
        <div class="section-2-blocks-wrapper row no-gutters">
          <div class="img col-sm-12 col-lg-6" style="background-image: url('images/tour-1.jpg');">
            <a href="https://vimeo.com/45830194" class="button popup-vimeo"><span class="ion-ios-play"></span></a>
          </div>
          <div class="text col-lg-6 ftco-animate">
            <div class="text-inner align-self-start">
              
              <h3>Welcome to Voyage.com!</h3>
              <p>Planning a trip or looking for ideas? Our database of hotels and properties is at your disposal, together with many reviews from trusted clients.</p>

              <p>Or maybe you are looking to get your place more popular? Feel free to post an ad on our site!</p>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <section class="ftco-section bg-light">
    <div class="container">
    <div class="row justify-content-center mb-5">
    <h2>Statistics for Voyage.com: </h2>
    </div>
    <div class="row justify-content-center mb-5">
						<h3>Total number of properties: </h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${properties}</h4>
						</div>
					</div>
	<div class="row justify-content-center mb-5">
						<h3>Total number of bookings to date: </h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${bookings}</h4>
						</div>
					</div>
	<div class="row justify-content-center mb-5">
						<h3>Average price per night: </h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${avgprice}</h4>
						</div>
					</div>
	<div class="row justify-content-center mb-5">
						<h3>Registered owners: </h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${owners}</h4>
						</div>
					</div>
	<div class="row justify-content-center mb-5">
						<h3>Property reviews: </h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${reviews}</h4>
						</div>
					</div>
					<div class="row justify-content-center">
					   
        
        </div>
					    </div>
    </section>

     <script>
// Initialize and add the map

    </script>
    
    <%
    float coord[][] = new float[10000][2];
    Connection connection = null;
    connection= MyUtils.getStoredConnection(request);
    String sql = "select count(*) as total from virtual_property";
	String sql2 = "select count(*) as total2 from booking";
	String sql3 = "select avg(price) as total3 from virtual_property";
	String sql4 = "select count(*) as total4 from owner";
	String sql5 = "select count(*) as total5 from review_property";
	String sql6 = "select lat, lng from virtual_property";
	
	PreparedStatement pstm = connection.prepareStatement(sql);
	PreparedStatement pstm2 = connection.prepareStatement(sql2);
	PreparedStatement pstm3 = connection.prepareStatement(sql3);
	PreparedStatement pstm4 = connection.prepareStatement(sql4);
	PreparedStatement pstm5 = connection.prepareStatement(sql5);
	PreparedStatement pstm6 = connection.prepareStatement(sql6);
	
	ResultSet rs = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	ResultSet rs4 = null;
	ResultSet rs5 = null;
	ResultSet rs6 = null;
	
	rs = pstm.executeQuery();
	
	while(rs.next()){
		int properties = rs.getInt("total");
		session.setAttribute("properties", properties);
	}
	
	rs2 = pstm2.executeQuery();
	
	while(rs2.next()){
		int properties = rs2.getInt("total2");
		session.setAttribute("bookings", properties);
	}
	
	rs3 = pstm3.executeQuery();
	
	while(rs3.next()){
		float properties = rs3.getFloat("total3");
		session.setAttribute("avgprice", properties);
	}
	
	rs4 = pstm4.executeQuery();
	
	while(rs4.next()){
		int properties = rs4.getInt("total4");
		session.setAttribute("owners", properties);
	}
	
	rs5 = pstm5.executeQuery();
	
	while(rs5.next()){
		int properties = rs5.getInt("total5");
		session.setAttribute("reviews", properties);
	}
	
	rs6 = pstm6.executeQuery();
	int i = 0;
	
	while(rs6.next()){
		coord[i][0] = rs6.getFloat(1);
		coord[i][1] = rs6.getFloat(2);
		session.setAttribute("coord" + i + "at0", coord[i][0]);
		session.setAttribute("coord" + i + "at1", coord[i][1]);
		i ++;
	}
	
	if( session.getAttribute("reload") == null){
		session.setAttribute("reload", 1);
		%>
		<script>
		location.reload(true);
		</script>
		<%
	}
    
    %>

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
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


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
  <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBbMvY_LqkOpW6c3YPH4sn70IAp1Zw8gtQ&callback=myMap">
    </script>

  <script src="js/google-map.js"></script>
  <script src="js/main.js"></script>
    
  </body>
</html>