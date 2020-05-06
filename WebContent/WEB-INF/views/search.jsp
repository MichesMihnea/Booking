<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.srccodes.utils.MyUtils"%>
<%@page import="com.srccodes.utils.DBUtils"%>
<%@page import="com.srccodes.beans.User"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.concurrent.TimeUnit" %>
<!DOCTYPE html>



<!-- This is the property list page. It shows properties that fulfill the search form constraints,
	coming from the home page. This is done with Java code in order to fetch the data from the database,
	and JavaScript in order to display the ads. -->



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
      <div class="slider-item" style="background-image: url('images/bg_4.jpg');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container">
          <div class="row slider-text align-items-center">
            <div class="col-md-7 col-sm-12 ftco-animate">
              <p class="breadcrumbs"><span class="mr-2"><a href="index.html">Home</a></span> <span>Services</span></p>
              <h1 class="mb-3">Hotels</h1>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- END slider -->
    
    <section class="ftco-section bg-light">
    <form method="POST" action="${pageContext.request.contextPath}/newProperty" enctype="multipart/form-data">
      <div class="container">
        <div class="row justify-content-center mb-4 pb-5">
          <div class="row justify-content-center mb-5">
						<h3>Showing hotels in </h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${location}</h4>
						</div>
        </div>
        
						</div>
		<div class="container">
		<div class="row justify-content-center mb-4 pb-5">
        <h3> for dates </h3>
					
					<div class="row ml-3 mt-1">
							<h4 style="color: red;">${checkin}</h4>
						</div>
						</div>
		<div class="container">
		<div class="row justify-content-center mb-4 pb-5">
						<h3> to </h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${checkout}</h4>
						</div>
						</div>
						</div>
						</div>
		<div class="container">
		<div class="row justify-content-center mb-4 pb-5">
						<h3> For guests:  </h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${guests}</h4>
						</div>
						</div>
						</div>
        <div class="container">
                   
                   <div class="row justify-content-center mb-3">
                   		<p style="color: red;">${errorString}</p>
                   </div>
                   <div class="row no-gutters" id="hotels">

          </div>
                      
        </div>
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
String sql="SELECT name, virtual_property_id, price, valid, stars, score, address, available FROM mydb.virtual_property where address like ?";

String location = (String) request.getAttribute("location");
String finalLocation = "%" + location + "%";
session.setAttribute("mylocation", finalLocation);

connection= MyUtils.getStoredConnection(request);
preparedStatement= connection.prepareStatement(sql);

preparedStatement.setString(1, finalLocation);
resultSet= preparedStatement.executeQuery();

String pattern = "MM/dd/yyyy";
SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
Date date1 = simpleDateFormat.parse((String) request.getAttribute("checkin"));
Date date2 = simpleDateFormat.parse((String) request.getAttribute("checkout"));
long diffInMillies = Math.abs(date2.getTime() - date1.getTime());
long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
%> <%
while(resultSet.next()){
String name= resultSet.getString(1);
session.setAttribute("adName", name);
int propertyId = resultSet.getInt(2);
float price = resultSet.getFloat(3);
session.setAttribute("price", price * diff);
int valid = resultSet.getInt(4);
session.setAttribute("valid", valid);
int stars = resultSet.getInt(5);
session.setAttribute("stars", stars);
float score = resultSet.getFloat(6);
String address = resultSet.getString(7);
String available = resultSet.getString(8);
session.setAttribute("available", available);
session.setAttribute("address", address);
session.setAttribute("stars", stars);
ResultSet resultSet2= null;
String sql2="SELECT link FROM mydb.photo where property_id like ?";
String sql3="SELECT count(*) as total FROM mydb.review_property where property_id = ?";
PreparedStatement preparedStatement2= null;
PreparedStatement preparedStatement3= null;
preparedStatement2= connection.prepareStatement(sql2);
preparedStatement3= connection.prepareStatement(sql3);

preparedStatement2.setInt(1, propertyId);
preparedStatement3.setInt(1, propertyId);
resultSet2= preparedStatement2.executeQuery();
String link = null;

while(resultSet2.next()){
	link = resultSet2.getString(1);
	session.setAttribute("photoLink", link);
	break;
}

ResultSet rs3 = preparedStatement3.executeQuery();

while(rs3.next()){
	int total = rs3.getInt("total");
	session.setAttribute("reviews", total);
}
%> <script>
var jsAtt = '${adName}';
var jsAtt2 = '${address}';
var jsAtt3 = '${photoLink}';
var jsAtt4 = '${checkin}';
var jsAtt5 = '${checkout}';
var jsAtt6 = '${price}';
var jsAtt7 = '${guests}';
var jsAtt8 = '${valid}';
var jsAtt9 = '${stars}';
var jsAtt10 = '${reviews}';
var jsAtt10 = '${available}';
if(jsAtt8 == 1){
	if(jsAtt10 == 1){
	if(jsAtt9 == 1){
	document.getElementById("hotels").innerHTML += "<div class=\"col-md-6 col-lg-3 ftco-animate\">"
		+ "<a href=\"${pageContext.request.contextPath}/showProperty?name=" + jsAtt + "&checkin=" + jsAtt4 + "&checkout=" + jsAtt5 + "&guests=" + jsAtt7 + "&price=" + jsAtt6 + "\" class=\"block-5\" style=\"background-image: url('uploads/" + jsAtt3 + "');\">" +
	"<div class=\"text\">" + "<span class=\"price\">Euro:" + jsAtt6 + "</span>" + "<h3 class=\"heading\">" + jsAtt + "</h3>" +
	"<div class=\"post-meta\">" + "<span>" + jsAtt2 + "</span>" + "</div>" +
	"<p class=\"star-rate\"><span class=\"icon-star\"></span>"
	+ " <span>Reviews: " + jsAtt10 +  "</span></p>"
	 + "</div></a></div>";
	}
	if(jsAtt9 == 2){
		document.getElementById("hotels").innerHTML += "<div class=\"col-md-6 col-lg-3 ftco-animate\">"
			+ "<a href=\"${pageContext.request.contextPath}/showProperty?name=" + jsAtt + "&checkin=" + jsAtt4 + "&checkout=" + jsAtt5 + "&guests=" + jsAtt7 + "&price=" + jsAtt6 + "\" class=\"block-5\" style=\"background-image: url('uploads/" + jsAtt3 + "');\">" +
		"<div class=\"text\">" + "<span class=\"price\">Euro:" + jsAtt6 + "</span>" + "<h3 class=\"heading\">" + jsAtt + "</h3>" +
		"<div class=\"post-meta\">" + "<span>" + jsAtt2 + "</span>" + "</div>" +
		"<p class=\"star-rate\"><span class=\"icon-star\"></span><span class=\"icon-star\"></span>"
		+ " <span>Reviews: " + jsAtt10 +  "</span></p>"
		 + "</div></a></div>";
	}
	if(jsAtt9 == 3){
		document.getElementById("hotels").innerHTML += "<div class=\"col-md-6 col-lg-3 ftco-animate\">"
			+ "<a href=\"${pageContext.request.contextPath}/showProperty?name=" + jsAtt + "&checkin=" + jsAtt4 + "&checkout=" + jsAtt5 + "&guests=" + jsAtt7 + "&price=" + jsAtt6 + "\" class=\"block-5\" style=\"background-image: url('uploads/" + jsAtt3 + "');\">" +
		"<div class=\"text\">" + "<span class=\"price\">Euro:" + jsAtt6 + "</span>" + "<h3 class=\"heading\">" + jsAtt + "</h3>" +
		"<div class=\"post-meta\">" + "<span>" + jsAtt2 + "</span>" + "</div>" +
		"<p class=\"star-rate\"><span class=\"icon-star\"></span><span class=\"icon-star\"></span><span class=\"icon-star\"></span>"
		+ " <span>Reviews: " + jsAtt10 +  "</span></p>"
		 + "</div></a></div>";
	}
	if(jsAtt9 == 4){
		document.getElementById("hotels").innerHTML += "<div class=\"col-md-6 col-lg-3 ftco-animate\">"
			+ "<a href=\"${pageContext.request.contextPath}/showProperty?name=" + jsAtt + "&checkin=" + jsAtt4 + "&checkout=" + jsAtt5 + "&guests=" + jsAtt7 + "&price=" + jsAtt6 + "\" class=\"block-5\" style=\"background-image: url('uploads/" + jsAtt3 + "');\">" +
		"<div class=\"text\">" + "<span class=\"price\">Euro:" + jsAtt6 + "</span>" + "<h3 class=\"heading\">" + jsAtt + "</h3>" +
		"<div class=\"post-meta\">" + "<span>" + jsAtt2 + "</span>" + "</div>" +
		"<p class=\"star-rate\"><span class=\"icon-star\"></span><span class=\"icon-star\"></span><span class=\"icon-star\"></span><span class=\"icon-star\"></span>"
		+ " <span>Reviews: " + jsAtt10 +  "</span></p>"
		 + "</div></a></div>";
	}
	if(jsAtt9 == 5){
		document.getElementById("hotels").innerHTML += "<div class=\"col-md-6 col-lg-3 ftco-animate\">"
			+ "<a href=\"${pageContext.request.contextPath}/showProperty?name=" + jsAtt + "&checkin=" + jsAtt4 + "&checkout=" + jsAtt5 + "&guests=" + jsAtt7 + "&price=" + jsAtt6 + "\" class=\"block-5\" style=\"background-image: url('uploads/" + jsAtt3 + "');\">" +
		"<div class=\"text\">" + "<span class=\"price\">Euro:" + jsAtt6 + "</span>" + "<h3 class=\"heading\">" + jsAtt + "</h3>" +
		"<div class=\"post-meta\">" + "<span>" + jsAtt2 + "</span>" + "</div>" +
		"<p class=\"star-rate\"><span class=\"icon-star\"></span><span class=\"icon-star\"></span><span class=\"icon-star\"></span><span class=\"icon-star\"></span><span class=\"icon-star\"></span>"
		+ " <span>Reviews: " + jsAtt10 +  "</span></p>"
		 + "</div></a></div>";
	}
	}
}
</script>
					<%} %>
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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="js/google-map.js"></script>
  <script src="js/main.js"></script>
    
  </body>
</html>