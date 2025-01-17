<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.srccodes.utils.MyUtils"%>
<%@page import="com.srccodes.utils.DBUtils"%>
<%@page import="com.srccodes.beans.User"%>
<!DOCTYPE html>



<!-- This is the Edit Property page that the owner can access in order to edit details of a property
	It does display all the photos of the property, that can be individually deleted. Also submits a form
	containing the new details of the property. -->
	
	
	
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
  <style>
img {
  border: 1px solid #ddd; /* Gray border */
  border-radius: 4px;  /* Rounded border */
  padding: 5px; /* Some padding */
  width: 150px; /* Set a small width */
}

/* Add a hover effect (blue shadow) */
img:hover {
  box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
}
</style>
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
    <form method="POST" action="${pageContext.request.contextPath}/editProperty" enctype="multipart/form-data">
      <div class="container">
        <div class="row justify-content-center mb-4 pb-5">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h2>${editPropertyName}</h2>
          </div>
        </div>
        <div class="row justify-content-center mb-3 mt-5" id="back">
              
		</div>
		
		<script>
		var jsAtt2 = '${propertyId}';
			document.getElementById("back").innerHTML += "<a href= ${pageContext.request.contextPath}/property?name=" + jsAtt2 +  "> Forget it </a>";
		</script>
        
        <div class="container">
                   
                   <div class="row justify-content-center mb-3">
                   		<p style="color: red;">${errorString}</p>
                   </div>
					<div class="row justify-content-center mb-3">
                      <div class="textfield-search one-third col-sm-4 "><input type="text" class="form-control" placeholder="Name" name="newName" value= "${editPropertyName}"></div>
					</div>
					
					<div class="row justify-content-center mb-3">
               			<div class="textfield-search one-third col-sm-4"><input type="text" class="form-control" placeholder="Address" name="newAddress" value= "${editPropertyAddress}"></div>
               		</div>
               		<div class="row justify-content-center mb-3">
               			<div class="textfield-search one-third col-sm-4"><input type="text" class="form-control" placeholder="Price per night" name="newPrice" value= "${editPropertyPrice}"></div>
               		</div>
                    <div class="row justify-content-center mb-5 pb-1">
                        <input type="submit" class="search-submit btn btn-primary" value="Save!">
                      </div>
                       <div class="row justify-content-center mb-5 pb-1">
                       <ul style="list-style: none;" id="mygallery">
                       
						</ul>
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
String sql="select link, photo_id from photo where property_id = ?";
//CuisineBin cuisineBin= new CuisineBin();

connection= MyUtils.getStoredConnection(request);
preparedStatement= connection.prepareStatement(sql);
int propertyId = DBUtils.getPropertyId(connection, (String) request.getAttribute("editPropertyName"));
session.setAttribute("propertyId", propertyId);
preparedStatement.setInt(1, propertyId);
resultSet= preparedStatement.executeQuery();

while(resultSet.next()){
String link= resultSet.getString(1);
session.setAttribute("photoLink", link);
int photoId = resultSet.getInt(2);
session.setAttribute("photoId", photoId);%>
 <script>
var jsAtt = '${photoLink}';
var jsAtt2 = '${photoId}';
var jsAtt3 = '${propertyId}';
document.getElementById("mygallery").innerHTML += "<li><a target=\"_blank\" ><img src=\"uploads/" + jsAtt +
"\" alt=\"Forest\"> </a><div class=\"row justify-content-center mb-5 pb-1\">" + 
" <a href=\"${pageContext.request.contextPath}/deletePhoto?photoId=" + jsAtt2 + "&propertyName=" + jsAtt3 + 
		"\">Delete</a> </div></li>";
</script>
<%} %>
        </div>
        
      </div>
      </form>
    </section>
	<%Connection conn= null;
	conn= MyUtils.getStoredConnection(request);
	int propertyId2 = DBUtils.getPropertyId(conn, (String) request.getAttribute("editPropertyName"));
	session.setAttribute("propertyId", propertyId2); %>
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