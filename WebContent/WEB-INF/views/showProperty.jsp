<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="com.srccodes.utils.MyUtils"%>
<%@page import="com.srccodes.utils.DBUtils"%>
<%@page import="com.srccodes.beans.User"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.concurrent.TimeUnit" %>
<!DOCTYPE html>



<!-- This is the property ad page, that the client can view. The data is fetched from the database
	by the Java code and displayed using JavaScript. There's a form submission button that creates
	a booking for this property, according to the data received from the url parameters. -->



<html lang="en">
        <link href="https://sachinchoolur.github.io/lightGallery/lightgallery/css/lightgallery.css" rel="stylesheet">

    
        <script src="https://cdn.jsdelivr.net/picturefill/2.3.1/picturefill.min.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lightgallery.js/master/dist/js/lightgallery.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-pager.js/master/dist/lg-pager.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-autoplay.js/master/dist/lg-autoplay.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-fullscreen.js/master/dist/lg-fullscreen.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-zoom.js/master/dist/lg-zoom.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-hash.js/master/dist/lg-hash.js"></script>
        <script src="https://github.com/sachinchoolur/lg-thumbnail.js/blob/master/src/lg-thumbnail.js"></script>
                <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>
        
<style>
            body{
                background-color: #152836
            }
            .demo-gallery > ul {
                margin-bottom: 0;
            }
            .demo-gallery > ul > li {
                float: left;
                margin-bottom: 15px;
                margin-right: 20px;
                width: 200px;
            }
            .demo-gallery > ul > li a {
                border: 3px solid #FFF;
                border-radius: 3px;
                display: block;
                overflow: hidden;
                position: relative;
                float: left;
            }
            .demo-gallery > ul > li a > img {
                -webkit-transition: -webkit-transform 0.15s ease 0s;
                -moz-transition: -moz-transform 0.15s ease 0s;
                -o-transition: -o-transform 0.15s ease 0s;
                transition: transform 0.15s ease 0s;
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
                height: 100%;
                width: 100%;
            }
            .demo-gallery > ul > li a:hover > img {
                -webkit-transform: scale3d(1.1, 1.1, 1.1);
                transform: scale3d(1.1, 1.1, 1.1);
            }
            .demo-gallery > ul > li a:hover .demo-gallery-poster > img {
                opacity: 1;
            }
            .demo-gallery > ul > li a .demo-gallery-poster {
                background-color: rgba(0, 0, 0, 0.1);
                bottom: 0;
                left: 0;
                position: absolute;
                right: 0;
                top: 0;
                -webkit-transition: background-color 0.15s ease 0s;
                -o-transition: background-color 0.15s ease 0s;
                transition: background-color 0.15s ease 0s;
            }
            .demo-gallery > ul > li a .demo-gallery-poster > img {
                left: 50%;
                margin-left: -10px;
                margin-top: -10px;
                opacity: 0;
                position: absolute;
                top: 50%;
                -webkit-transition: opacity 0.3s ease 0s;
                -o-transition: opacity 0.3s ease 0s;
                transition: opacity 0.3s ease 0s;
            }
            .demo-gallery > ul > li a:hover .demo-gallery-poster {
                background-color: rgba(0, 0, 0, 0.5);
            }
            .demo-gallery .justified-gallery > a > img {
                -webkit-transition: -webkit-transform 0.15s ease 0s;
                -moz-transition: -moz-transform 0.15s ease 0s;
                -o-transition: -o-transform 0.15s ease 0s;
                transition: transform 0.15s ease 0s;
                -webkit-transform: scale3d(1, 1, 1);
                transform: scale3d(1, 1, 1);
                height: 100%;
                width: 100%;
            }
            .demo-gallery .justified-gallery > a:hover > img {
                -webkit-transform: scale3d(1.1, 1.1, 1.1);
                transform: scale3d(1.1, 1.1, 1.1);
            }
            .demo-gallery .justified-gallery > a:hover .demo-gallery-poster > img {
                opacity: 1;
            }
            .demo-gallery .justified-gallery > a .demo-gallery-poster {
                background-color: rgba(0, 0, 0, 0.1);
                bottom: 0;
                left: 0;
                position: absolute;
                right: 0;
                top: 0;
                -webkit-transition: background-color 0.15s ease 0s;
                -o-transition: background-color 0.15s ease 0s;
                transition: background-color 0.15s ease 0s;
            }
            .demo-gallery .justified-gallery > a .demo-gallery-poster > img {
                left: 50%;
                margin-left: -10px;
                margin-top: -10px;
                opacity: 0;
                position: absolute;
                top: 50%;
                -webkit-transition: opacity 0.3s ease 0s;
                -o-transition: opacity 0.3s ease 0s;
                transition: opacity 0.3s ease 0s;
            }
            .demo-gallery .justified-gallery > a:hover .demo-gallery-poster {
                background-color: rgba(0, 0, 0, 0.5);
            }
            .demo-gallery .video .demo-gallery-poster img {
                height: 48px;
                margin-left: -24px;
                margin-top: -24px;
                opacity: 0.8;
                width: 48px;
            }
            .demo-gallery.dark > ul > li a {
                border: 3px solid #04070a;
            }
            .home .demo-gallery {
                padding-bottom: 80px;
            }
        </style>
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
    <form method="POST" action="${pageContext.request.contextPath}/showProperty" enctype="multipart/form-data">
      <div class="container">
        <div class="row justify-content-center mb-4 pb-5">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h2>${propertyName}</h2>
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
						<div class="row justify-content-center mb-4 pb-5">
						<h3> for guests: </h3>
						<div class="row ml-3 mt-1">
							<h4 style="color: red;">${guests}</h4>
						</div>
						</div>
						</div>
						</div>
        <div class="row justify-content-center mb-4 pb-5">
            <p style="color: red;">${uploadError}</p>
        </div>
        <div class="row justify-content-center mb-4 pb-5">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h4 id="add"></h4>
          </div>
        </div>
        
         <div class="row justify-content-center mb-3 mt-5">
              <h4>Score:</h4><h4 id="reviewScore"></h4><h4>/10</h4>
		</div>
        
        


        <div class="demo-gallery">
            <ul id="lightgallery" class="list-unstyled row justify-content-center">
            
                
            </ul>
        </div>
        
        <div class="row justify-content-center mt-5" id="price">
        	<h4>Total price for selected dates: </h4>
        	<h4 id="totalprice" style="color: red;">${totalprice}(Euro)</h4>
        </div>
        
        <div class="row justify-content-center">
         <div id="googleMap" style="width:50%;height:400px;"></div>
        </div>
        
        <div class="row justify-content-center mb-5 pb-1 mt-4">
                        <input type="submit" class="search-submit btn btn-primary" value="Book now!">
                      </div>
                      
                      <section class="ftco-section testimony-section">
      <div class="container">
        <div class="row justify-content-center mb-5 pb-5">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h2>Guest Reviews</h2>
          </div>
        </div>
        <div class="row ftco-animate">
          <div class="carousel owl-carousel ftco-owl" id="reviews">

          </div>
        </div>
      </div>
    </section>
        
	

                   
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
PreparedStatement preparedStatement2= null;
ResultSet resultSet= null;
ResultSet resultSet2= null;
String sql="select link from photo where property_id = ?";
String sql2="select address, price, lat, lng from virtual_property where virtual_property_id = ?";
//CuisineBin cuisineBin= new CuisineBin();

connection= MyUtils.getStoredConnection(request);
preparedStatement= connection.prepareStatement(sql);
preparedStatement2= connection.prepareStatement(sql2);
String checkIn = (String) request.getAttribute("checkin");
String checkOut = (String) request.getAttribute("checkout");
String guests = (String) request.getAttribute("guests");
session.setAttribute("checkin", checkIn);
session.setAttribute("checkout", checkOut);
session.setAttribute("guests", guests);





int propertyId = DBUtils.getPropertyId(connection, (String) request.getAttribute("propertyName"));
session.setAttribute("propertyId", propertyId);
String message =  "New booking request for " + guests + " guests at property " + (String) request.getAttribute("propertyName") 
+ " between " + checkIn + " and " + checkOut + "owner=" + DBUtils.getPropertyOwner(connection, propertyId);
session.setAttribute("bookingmessage", message);
preparedStatement.setInt(1, propertyId);
preparedStatement2.setInt(1, propertyId);
resultSet= preparedStatement.executeQuery();
resultSet2= preparedStatement2.executeQuery();
%> <% 
while(resultSet2.next()){
String address = resultSet2.getString(1);
float price = resultSet2.getFloat(2);
float lat = resultSet2.getFloat(3);
float lng = resultSet2.getFloat(4);

session.setAttribute("price", price);
session.setAttribute("address", address);
session.setAttribute("lat", lat);
session.setAttribute("lng", lng);}%>
<script>
var jsAtt1 = '${address}';
document.getElementById("add").innerHTML += jsAtt1;
</script>
<% 
while(resultSet.next()){
String link= resultSet.getString(1);
session.setAttribute("photoLink", link);%>
 <script>
var jsAtt = '${photoLink}';
var jsAtt21 = '${propertyName}';
document.getElementById("lightgallery").innerHTML += "<li class=\"col-xs-6 col-sm-4 col-md-3\" data-responsive=\"uploads/" + jsAtt + 
"\" data-src=\"uploads/" + jsAtt + "\" data-sub-html=\"<h4></h4><p>" + jsAtt21 + "</p>\" data-pinterest-text=\"Pin it1\" data-tweet-text=\"share on twitter 1\"><a href=\"\"><img class=\"img-responsive\" src=\"uploads/" +
jsAtt + "\" alt=\"Thumb-1\"></a></li> ";
</script>
<script>
            lightGallery(document.getElementById('lightgallery'));
        </script>
					<%}

String sql3 = "select score, comment, client_id from review_property where property_id = ?";
String sql5 = "select avg(score) as average from review_property where property_id = ?";
PreparedStatement pstm5 = connection.prepareStatement(sql5);
pstm5.setInt(1, propertyId);
ResultSet resultSet5 = pstm5.executeQuery();
PreparedStatement pstm3 = connection.prepareStatement(sql3);
pstm3.setInt(1, propertyId);
ResultSet resultSet3 = pstm3.executeQuery();

while(resultSet5.next()){
	float average = resultSet5.getFloat("average");
	session.setAttribute("reviewScore", average);
	%>
	<script>
	document.getElementById("reviewScore").innerHTML += '${reviewScore}';
	</script>
	<% 
}

while(resultSet3.next()){
	int score = resultSet3.getInt(1);
	if(score == 0)
		break;
	String comment = resultSet3.getString(2);
	int clientId = resultSet3.getInt(3);

	String sql4 = "select first_name, last_name from client where client_id = ?";
	PreparedStatement pstm4 = connection.prepareStatement(sql4);
	pstm4.setInt(1, clientId);
	ResultSet resultSet4 = pstm4.executeQuery();
	session.setAttribute("score", score);
	session.setAttribute("comment", comment);
	
	while(resultSet4.next()){
		String fname = resultSet4.getString(1);
		String lname = resultSet4.getString(2);
		session.setAttribute("clientName", fname + " " + lname);
	}
	%>
	
	<script>
	var jsAtt11 = '${clientName}';
	var jsAtt12 = '${comment}';
	var jsAtt13 = '${score}';
	var jsAtt14 = '${reviewScore}';
	
	document.getElementById("reviews").innerHTML += "<div class=\"item text-center\">" + "<div class=\"testimony-wrap p-4 pb-5\">" + 
		"<div class=\"user-img mb-4\" style=\"background-image: url(images/guest.jpg)\" style=\"border: 1px solid red;\"></div>" +
		"<div class=\"text\">" + 
		"<p class=\"name\">" + jsAtt13 + "/10</p>" +
		"<p class=\"mb-5\">" + jsAtt12 + "</p>" +
		"<p class=\"name\">" + jsAtt11 + "</p> <span class=\"position\">Guest</span> </div></div></div>";
	</script>
	
	<% 
}



%>
        
      </div>
      </form>
    </section>
    
      <script>
function myMap() {
var mapProp= {
  center:new google.maps.LatLng('${lat}','${lng}'),
  zoom:5,
};
var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);
var uluru = new google.maps.LatLng('${lat}','${lng}');
var marker = new google.maps.Marker({position: uluru, map: map});
marker.setMap(map);
}
</script>

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