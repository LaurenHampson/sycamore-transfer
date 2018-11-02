<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create a new StyleTransfer Account</title>

<style>
	body
	{
		background-color: #FFEBCD;			
	
	}
	
	#sycamore
	{
		text-align: center;
		color: orange;
		font-family: Impact;
		font-size: 75px;
	}
	
	#main
	{
		text-align: center;
		color: balck;
		font-family: Helvetica;
		font-size:55px;
	}

	input
	{
		align:center;
		width: 30%;
		text-align: center;
		color: balck;
		font-family: Helvetica;
		font-size:55px;
		padding: 5px 5px;
		margin: 8px 0;
		box-sizing: border-box;
	}

</style>

</head>
<body>
	<div id= "sycamore">
		Sycamore Transfer
	</div>
	<br ></br>
	<div id ="main"> Create New Account <br></br>
	<form name="myform" method="GET" action="CreateAccount.jsp" onsubmit="return validate();">
      <input type="text" name="username" placeholder="Username"required/><br>
      <input type="text" name="email" placeholder = "Email"required/><br>
      <input type="password" name="password" placeholder = "Password" required minlength = "8" ><br>
     
      <input type="submit" name="submit" value="Create Account">  
    </form>
	
	<br ></br></div>
	
</body>
</html>
