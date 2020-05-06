<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.srccodes.utils.MyUtils"%>
<%@page import="com.srccodes.utils.DBUtils"%>
<%@page import="com.srccodes.beans.User"%>

<!DOCTYPE html>



<!-- This is the Property page, more exactly an owner's property page. It holds owner-only options, such as
	the ability to add more photos or edit the details of a property, or view the list of bookings.
	The data is fetched at page creation time using Java code from the database. -->



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
    <style> 
            .mylist3 { 
            visibility: hidden;
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
              <h1 class="mb-3">My Account</h1>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- END slider -->
    
    
    
    <section class="ftco-section bg-light">
    <form method="POST" action="${pageContext.request.contextPath}/property" enctype="multipart/form-data">
      <div class="container">
        <div class="row justify-content-center mb-4 pb-5">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h2>${propertyName}</h2>
          </div>
        </div>
        <div class="row justify-content-center mb-4 pb-5">
            <p style="color: red;">${uploadError}</p>
        </div>
        <div class="row justify-content-center mb-4 pb-5">
        	<div class="mylist2">
            <p style="color: red;">This property has not yet been approved!</p>
            </div>
        </div>
        <div class="row justify-content-center mb-4 pb-5">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h4 id="add"></h4>
          </div>
        </div>
        <div class="row justify-content-center mb-4 pb-5">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h4 id="price"></h4>
          </div>
        </div>
        
        <div class="row justify-content-center mb-3 mt-5">
             <h4>Score:</h4> <h4 id="reviewScore"></h4><h4>/10</h4>
		</div>
        


        <div class="demo-gallery">
            <ul id="lightgallery" class="list-unstyled row justify-content-center">
            
                
            </ul>
        </div>
        
		<div class="row justify-content-center">
         <div id="googleMap" style="width:50%;height:400px;"></div>
        </div>
        <p id="uploadSection">	</p>
        

        <div class="container">
                   <div class="row justify-content-center mb-3 mt-5" id="mybtn">
                   		<div class="mylist">
                   			<button onclick="myFunction(this)" class="search-submit btn btn-primary" type="button" >Add Photos</button>
                   		</div>
		</div>
		</div>
		<div class="row justify-content-center mb-3 mt-5" id="availability">
              
		</div>
		<div class="row justify-content-center mb-3 mt-5" id="view-bookings">
                   		
		</div>
		<div class="row justify-content-center mb-3 mt-5" id="aaron-family">
                   		
		</div>
		
		<div class="row justify-content-center mb-3 mt-5" id="back">
              
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
		

		

<script>
function myFunction(button) {
	var jsAtt12 = '${admin}';
	if(jsAtt12 == 0){
		
 		document.getElementById("uploadSection").innerHTML = "<div class=\"row justify-content-center mb-5 pb-1\"> <input type=\"file\" name=\"file\" multiple=\"true\"/></div>";
 		document.getElementById("uploadSection").innerHTML += "<div class=\"row justify-content-center mb-5 pb-1\"> <input type=\"submit\" class=\"search-submit btn btn-primary\" value=\"Upload\"></div>";
  		button.style.visibility = "hidden";
	}
}
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
PreparedStatement preparedStatement2= null;
ResultSet resultSet= null;
ResultSet resultSet2= null;
String sql="select link from photo where property_id = ?";
String sql2="select address, price, valid, lat, lng, available from virtual_property where virtual_property_id = ?";
//CuisineBin cuisineBin= new CuisineBin();

connection= MyUtils.getStoredConnection(request);
preparedStatement= connection.prepareStatement(sql);
preparedStatement2= connection.prepareStatement(sql2);
int propertyId = DBUtils.getPropertyId(connection, (String) request.getAttribute("propertyName"));
session.setAttribute("propertyId", propertyId);
preparedStatement.setInt(1, propertyId);
preparedStatement2.setInt(1, propertyId);
resultSet= preparedStatement.executeQuery();
resultSet2= preparedStatement2.executeQuery();
%> <% 
while(resultSet2.next()){
String address = resultSet2.getString(1);
float price = resultSet2.getFloat(2);
int valid = resultSet2.getInt(3);
float lat = resultSet2.getFloat(4);
float lng = resultSet2.getFloat(5);
session.setAttribute("lat", lat);
session.setAttribute("lng", lng);
session.setAttribute("address", address);
session.setAttribute("price", price);
session.setAttribute("valid", valid);
int available = resultSet2.getInt(6);
session.setAttribute("available", available);
}%>
<script>
var jsAtt1 = '${address}';
var jsAtt2 = '${price}';
document.getElementById("add").innerHTML += jsAtt1;
document.getElementById("price").innerHTML += jsAtt2;
</script>
<% 
while(resultSet.next()){
String link= resultSet.getString(1);
session.setAttribute("photoLink", link);%>
 <script>
var jsAtt = '${photoLink}';
document.getElementById("lightgallery").innerHTML += "<li class=\"col-xs-6 col-sm-4 col-md-3\" data-responsive=\"uploads/" + jsAtt + 
"\" data-src=\"uploads/" + jsAtt + "\" data-sub-html=\"<h4>Fading Light</h4><p>asdf</p>\" data-pinterest-text=\"Pin it1\" data-tweet-text=\"share on twitter 1\"><a href=\"\"><img class=\"img-responsive\" src=\"uploads/" +
jsAtt + "\" alt=\"Thumb-1\"></a></li> ";
</script>
<script>
            lightGallery(document.getElementById('lightgallery'));
        </script>
					<%}

String sql3 = "select score, comment, client_id, review_property_id from review_property where property_id = ?";
String sql5 = "select avg(score) as average from review_property where property_id = ?";
PreparedStatement pstm3 = connection.prepareStatement(sql3);
PreparedStatement pstm5 = connection.prepareStatement(sql5);
pstm3.setInt(1, propertyId);
pstm5.setInt(1, propertyId);
ResultSet resultSet5 = pstm5.executeQuery();

while(resultSet5.next()){
	float average = resultSet5.getFloat("average");
	session.setAttribute("reviewScore", average);
	%>
	<script>
	document.getElementById("reviewScore").innerHTML += '${reviewScore}';
	</script>
	<% 
}
ResultSet resultSet3 = pstm3.executeQuery();

while(resultSet3.next()){
	int score = resultSet3.getInt(1);
	if(score == 0)
		break;
	String comment = resultSet3.getString(2);
	int clientId = resultSet3.getInt(3);

	int reviewId = resultSet3.getInt(4);
	session.setAttribute("reviewId", reviewId);

	session.setAttribute("clientId", clientId);
	String sql4 = "select first_name, last_name from client where client_id = ?";
	PreparedStatement pstm4 = connection.prepareStatement(sql4);
	pstm4.setInt(1, clientId);
	ResultSet resultSet4 = pstm4.executeQuery();
	session.setAttribute("score", score);
	session.setAttribute("comment", comment);
	
	while(resultSet4.next()){
		String fname = resultSet4.getString(1);
		String lname = resultSet4.getString(1);
		session.setAttribute("clientName", fname + " " + lname);
	}
	%>
	
	<script>
	var jsAtt11 = '${clientName}';
	var jsAtt12 = '${comment}';
	var jsAtt13 = '${score}';
	var jsAtt14 = '${reviewScore}';
	var jsAtt15 = '${reviewId}';
	var jsAtt16 = '${propertyId}';
	var jsAtt17 = '${clientId}';
	document.getElementById("reviews").innerHTML += "<div class=\"item text-center\">" + "<div class=\"testimony-wrap p-4 pb-5\">" + 
		"<div class=\"user-img mb-4\" style=\"background-image: url(images/guest.jpg)\" style=\"border: 1px solid red;\"></div>" +
		"<div class=\"text\">" + 
		"<p class=\"name\">" + jsAtt13 + "/10</p>" +
		"<p class=\"mb-5\">" + jsAtt12 + "</p>" +
		"<p class=\"name\">" + jsAtt11 + "</p> <span class=\"position\">Guest</span>" +
		"<p class=\"name\"><a href=\"${pageContext.request.contextPath}/report?review=" + jsAtt15 + "&property=" + jsAtt16 + "&client=" + jsAtt17 +"\">Report</a></p>" +
		"</div></div></div>";
	</script>
	
	<% 
}

%>
        
     </div>
      </form>
      
    </section>
    
    		<script>
			var jsAtt11 = '${propertyId}';
			var jsAtt12 = '${admin}';
			var jsAtt13 = '${valid}';
			var jsAtt14 = '${available}';
			if(jsAtt12 == 0){
				if(jsAtt13 == 0){
					element = document.querySelector('.mylist2');
					element.style.visibility = 'visible';
				}
				element = document.querySelector('.mylist');
				element.style.visibility = 'visible';
				document.getElementById("view-bookings").innerHTML += "<a href= ${pageContext.request.contextPath}/propertyBookings?name=" + jsAtt11 + ">" + "View Bookings" + "</a>";
				document.getElementById("aaron-family").innerHTML += "<a href= ${pageContext.request.contextPath}/editProperty?name=" + jsAtt11 + ">" + "Edit details" + "</a>";
				document.getElementById("back").innerHTML += "<a href= ${pageContext.request.contextPath}/viewProperty> Back to my properties </a>";
				if(jsAtt14 == 0){
					document.getElementById("availability").innerHTML += "<a href= ${pageContext.request.contextPath}/approval?available=1&property=" + jsAtt11 +"> Turn Availability ON </a>";
				}else if(jsAtt14 == 1){
					document.getElementById("availability").innerHTML += "<a href= ${pageContext.request.contextPath}/approval?available=0&property=" + jsAtt11 +"> Turn Availability OFF </a>";

				}
			}else{
				document.getElementById("back").innerHTML += "<a href= ${pageContext.request.contextPath}/adminNotifications> Back to my notifications </a>";
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