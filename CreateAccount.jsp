<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
	String error = (String) request.getAttribute("error");
	if(error == null){
		error = "";	
	}
%>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="stylesheet.css" />
		<title>Create a New Account</title>
	</head>
	<body>
		<div id= "frontpage">
			Sycamore Transfer
		</div>
		<br ></br>
		<div id ="main"> Create New Account <br />
		<p>Password must be 8 characters or longer</p>
		<strong><font color="red"><%= error %></font></strong>
		<form name="myform" method="POST" action="SignUpServlet">
	      <input type="text" name="username" placeholder="Username"required/><br>
	      <input type="text" name="email" placeholder = "Email"required/><br>
	      <input type="password" name="password" placeholder = "Password" required minlength = "8" ><br>
	     
	      <input type="submit" name="submit" value="Create Account">  
	    </form>
		
		<br ></br></div>
		
	</body>
</html>
