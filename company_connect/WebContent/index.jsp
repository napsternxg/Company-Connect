<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.company_connect.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/displaystyle.css" type="text/css" media="all">
<link rel="stylesheet" href="css/index.css" type="text/css" media="all">
<script type="text/javascript" src="js/index.js" ></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.2.min.js" ></script>
<script type="text/javascript" src="js/validation.js"></script>
<title>Company Connect - Search Simplified</title>
</head>
<body>
	<div class="page">
	<!-- header start -->
	 <div class="wrapper">
        <div class="header">Company Connect</div>
        <div class="caption">Search Simplified</div>
      </div>
      <!-- header ends -->
      
      <!-- body begins -->
      <div class="main-body-background">
      <div class="main-body">
      	<div class="search-box" id="search-box">
      		<div class="search-box-header">Browse Network</div>
        <form id="form_1" action="dbconnect1.jsp" method="post">
        	<ul class="search-options-list" id="search-options-list">
        		<li class="search-option" id="search-option-1" index="1">
        			<select  id="search-select-1" onChange = onSelectedOption(this)>
					  <option value="Name">Name</option>
					  <option value="Location">Location</option>
					  <option value="Company">Company</option>
					  <option value="Experience">Experience</option>
					  <option value="Skills">Skills</option>
					  <option value="College">College</option>
					  <option value="Degree">Degree</option>
					  <option value="Trade">Trade</option>
					</select>
					<input type="text" class="input" id="input1" value="" name="name" onFocus=onFocusField(this) onBlur=onBlurField(this)></input>
					<button class= 'cross' onClick="return removeSearch(this)">Remove</button>
        		</li>
        	</ul>
        	<div class="button-container">
	      	  	<div class="plus-div">
					<button class="button2" id="addSearch" onClick=" return addNewSearch()">ADD FILTER</button>
				</div>
				<div class="button">
					<input type="submit" id="submit" class="button2" value="go!" onClick="return ajaxRequest();"></input>
				</div>
			</div>
        </form>
      	</div>
      	<div class= "margin"></div>
      	<div class="results-main-container">
      	
      	
      	</div>
      </div>
      </div>
      <!-- body ends -->
      
      <!--  footer starts -->
      <div class= "footer">
      <div class="footerlink">
        <p class="lf">Copyright &copy; 2012 Batch 7- All Rights Reserved</p>
        <p class="rf"></p>
        <div style="clear:both;"></div>
      </div>
      </div>
      <!--  footer ends  -->
     </div>
</body>
</html>