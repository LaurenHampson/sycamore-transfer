<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>The Style Has Been TRANSFERRED!!!</title>

<style>
	body
	{
		background-color: #FFEBCD;			
		align: center;
	}
	
	table, th, td {
    	border: 2px solid black;
    	border-collapse: collapse;
    	background-color:white;
	}
	
	image
	{
		display: table-cell;
	    height: 100%;
	    text-align: center;
	    width: 100%;
	    vertical-align: middle;
	    align:center;
	    top: 20%;
	    padding: 10%;
	    
		
	}
	
	#main
	{
		text-align: center;
		color: balck;
		font-family: Helvetica;
		font-size:55px;
	}

	#button
	{
		align:center;
		width: 15%;
		text-align: center;
		color: balck;
		font-family: Helvetica;
		font-size:30px;
		padding: 1px 1px;
		margin: 8px 2;
		box-sizing: border-box;
	}
	#button2
	{
		
		width:100%;
		text-align: center;
		color: balck;
		font-family: Helvetica;
		font-size:20px;
		padding: 2% 2% 2% 2%;
		margin: 8px 2px;
		
	}

</style>

</head>
<body>

<table align="right">
  <tr>
    <th><button id = "button2">Sign Out</button></th>
   
  </tr>
  <tr>
    <th><button id = "button2">Home</button></th>
   
  </tr>
  <tr>
    <th><button id = "button2">Profile</button></th>
   
  </tr>
  <tr>
    <th><button id = "button2">Feed</button></th>
   
  </tr>
</table>

<div id = "main"> <br/><img id = "image" src = "kid.jpg" >
<br></br>
	<span><button  id = "button">Print</button>
	<button id = "button" >Download</button>
	<button id = "button" >Email</button></span>
	
	</div>
</body>
</html>
