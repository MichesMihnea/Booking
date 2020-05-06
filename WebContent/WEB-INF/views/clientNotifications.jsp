<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.srccodes.utils.MyUtils"%>
<%@page import="com.srccodes.utils.DBUtils"%>
<%@page import="com.srccodes.beans.User"%>
<!DOCTYPE html>



<!-- This is the page with the admin's notifications
They have to be retrieved from the database using Java code
The notification messages have some information encoded, it is decoded here
in order to facilitate notification operations. The client's notifications can only be deleted.  -->



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
						href="${pageContext.request.contextPath}/tours" class="nav-link">Tours</a></li>
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/hotels" class="nav-link">Hotels</a></li>
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/services"
						class="nav-link">Services</a></li>
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/blog" class="nav-link">Blog</a></li>
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
						<h2>Your Notifications</h2>
					</div>
				</div>
				<div class="container">

					<div class="row justify-content-center mb-3">
						<div class="row justify-content-center mb-1">
				<ul id="aaron-family">
				</ul>
				
				</div>
				
				
				
				
				
					</div>
					
					<div class="row justify-content-center mb-3 mt-5" id="back">
              
		</div>
		
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
String sql="select message, valid from notification where client_id = ?";
//CuisineBin cuisineBin= new CuisineBin();

connection= MyUtils.getStoredConnection(request);
preparedStatement= connection.prepareStatement(sql);
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
String message= resultSet.getString(1);
int index = 0;
int valid = resultSet.getInt(2);
for (int i = -1; (i = message.indexOf("client", i + 1)) != -1; i++) {
    index = i;
}

session.setAttribute("message", message.substring(0, index));

session.setAttribute("notificationid", DBUtils.getNotificationId(connection, message));

%> <script>
var jsAtt = '${message}';

var jsAtt4 = '${notificationid}';
document.getElementById("aaron-family").innerHTML += "<li>" + jsAtt + "</li>" + "<a href=\"${pageContext.request.contextPath}/deleteNotification?notification=" + jsAtt4 +"\"> Delete </a>";

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