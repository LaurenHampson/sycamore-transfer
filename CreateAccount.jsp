<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
	String error = (String) request.getAttribute("error");
	if(error == null){
		error = "";	
	} else if(error == "email_username_taken"){
		error = "There already exists an account with this username and email. Please enter different ones.";
	} else if(error == "email_taken"){
		error = "There already exists an account with this email. Please enter a different one.";
	} else if(error == "username_taken"){
		error = "There already exists an account with this username. Please enter a different one.";
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
		<strong><font color="red" size="15px"><%= error %></font></strong>
		<form name="myform" method="POST" action="SignUpServlet">
	      <input type="text" name="username" placeholder="Username"required/><br>
	      <input type="email" name="email" placeholder = "Email"required/><br>
	      <input type="password" name="password" placeholder = "Password" required minlength = "8" ><br>
	     
	      <input type="submit" name="submit" value="Create Account">  
	    </form>
		
		<br ></br></div>
		
	</body>
</html>
