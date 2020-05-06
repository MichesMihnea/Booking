<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>
<%@page import="com.srccodes.utils.MyUtils"%>
<%@page import="com.srccodes.utils.DBUtils"%>
<%@page import="com.srccodes.beans.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>


<!-- This page contains the list of a client's bookings, split into past and future bookings. Data
	is fetched from the database using Java code.  -->



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
	<style> 
            .mylist { 
            visibility: hidden;
         	}
    </style>
    <style> 
            .mylist2 { 
            visibility: hidden;
         	}
    </style>
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
		<form method="POST" action="${pageContext.request.contextPath}/login">
			<div class="container">
				<div class="row justify-content-center mb-4 pb-5">
					<div class="col-md-7 text-center heading-section ftco-animate">
						<h2>Your Bookings</h2>
					</div>
				</div>
				<div class="container">
				<div class="row justify-content-center mb-5">
					<p>Future</p>
				</div>

					<div class="row justify-content-center mb-3">
						<div class="row justify-content-center mb-1">
				<ul id="aaron-family">
				</ul>
				
				</div>
				
				
				<div class="container">
                   <div class="row justify-content-center mt-5">
                   		<button onclick="myFunction(this)" class="search-submit btn btn-primary" type="button" >Show past bookings</button>
		</div>
		</div>
		<div class="container">
				<div class="row justify-content-center">
              <p class="mylist"> Past </p>
              </div>
              <div class="row justify-content-center mt-5 ">
              <ul class="mylist2" id="pasts">
              </ul>
		</div>
				
				<div class="row justify-content-center ">
				<p id="uploadSection">	</p>
				</div>
				
					</div>
					</div>
					
		
		<div class="row justify-content-center mb-3 " id="back">
              
		</div>
		<script>
function myFunction(button) {
	element = document.querySelector('.mylist');
	element.style.visibility = 'visible';
	element2 = document.querySelector('.mylist2');
	element2.style.visibility = 'visible';
	 button.style.visibility = "hidden";
}
</script>
		<script>
			document.getElementById("back").innerHTML += "<a href= ${pageContext.request.contextPath}/myAccount> Back to my account </a>";
		</script>
					 <%-- %> --%> <!--        <table> -->
					<!--                 <tr> --> <!--                     <th>pid</th> -->
					<!--                     <th>pname</th> --> <!--                     <th>price</th> -->
					<!--                 </tr> --> <%--                 <c:forEach var="product" items="${allProList}"> --%>
					<!--                     <tr> --> <%--                         <td><c:out value="${product.pid}" /></td> -- 
%>
<%--                         <td><c:out value="${product.pname}" /></td> - 
-%>
<%--                         <td><c:out value="${product.price}" /></td> - 
-%>
<!--                     </tr> -->
<%--                 </c:forEach> --%> <!--           </table> --> <%
Connection connection= null;
PreparedStatement preparedStatement= null;
ResultSet resultSet= null;
PreparedStatement preparedStatement2= null;
ResultSet resultSet2= null;
String sql="select booking_id, check_in, check_out, property_id, reviewed_client, valid from booking where client_id = ?";
String sql2 = "select name from virtual_property where virtual_property_id = ?";
//CuisineBin cuisineBin= new CuisineBin();

connection= MyUtils.getStoredConnection(request);
preparedStatement= connection.prepareStatement(sql);
preparedStatement2= connection.prepareStatement(sql2);
User loginedUser = MyUtils.getLoginedUser(session);
if(loginedUser == null)
{
	session.setAttribute("resetPasswordErrorString", "Something went wrong!");
	RequestDispatcher dispatcher //
	= this.getServletContext().getRequestDispatcher("/WEB-INF/views/login.jsp");

	dispatcher.forward(request, response);
	return;
}
int clientId = DBUtils.getClientId(connection, loginedUser.getUserName());
preparedStatement.setInt(1, clientId);
resultSet= preparedStatement.executeQuery();
%> <%
while(resultSet.next()){
int id= resultSet.getInt(1);
java.sql.Date checkin = resultSet.getDate(2);
java.sql.Date checkout = resultSet.getDate(3);
int pid = resultSet.getInt(4);
int reviewClient = resultSet.getInt(5);
int valid = resultSet.getInt(6);
session.setAttribute("reviewClient", reviewClient);
session.setAttribute("propertyId", pid);
session.setAttribute("booking", id);
session.setAttribute("valid", valid);
preparedStatement2.setInt(1, pid);
resultSet2 = preparedStatement2.executeQuery();
while(resultSet2.next()){
	String name = resultSet2.getString("name");
	session.setAttribute("name", name);
}
session.setAttribute("checkin", checkin);
session.setAttribute("checkout", checkout);
if(checkout.before(new Date(System.currentTimeMillis())))
	session.setAttribute("past", 1);
else session.setAttribute("past", 0);

%> <script>
var jsAtt = '${booking}';
var jsAtt2 = '${checkin}';
var jsAtt3 = '${checkout}';
var jsAtt4 = '${name}';
var jsAtt5 = '${past}';
var jsAtt6 = '${reviewClient}';
var jsAtt7 = '${valid}';
var jsAtt8 = '${propertyId}';
if(jsAtt5 == 0 & jsAtt6 == 0){
document.getElementById("aaron-family").innerHTML += "<li><a href= ${pageContext.request.contextPath}/booking?id=" + jsAtt + ">" + "At " + jsAtt4 + "</a>" 
			+ " from " + jsAtt2 + " to " + jsAtt3 + "</li>";
			if(jsAtt7 == 0){
				document.getElementById("aaron-family").innerHTML += "<p style=\"color: red;\">Pending Approval</p>";
			}

}
else{
	if(jsAtt6 == 0){
	document.getElementById("pasts").innerHTML += "<li><a href= ${pageContext.request.contextPath}/booking?id=" + jsAtt + ">" + "At " + jsAtt4 + "</a>" 
	+ " from " + jsAtt2 + " to " + jsAtt3 + ".<a href= ${pageContext.request.contextPath}/newPropertyReview?name=" + jsAtt8 + "&booking=" + jsAtt + ">Leave a review? </a>" + "</li>";
	}else{
		document.getElementById("pasts").innerHTML += "<li><a href= ${pageContext.request.contextPath}/booking?id=" + jsAtt + ">" + "At " + jsAtt4 + "</a>" 
		+ " from " + jsAtt2 + " to " + jsAtt3 + "</li>";
	}
}
</script>
					<%} %>

					
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