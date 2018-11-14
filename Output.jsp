<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="stylesheet.css" />
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
	    height: 80%;
	    text-align: center;
	    width: 80%;
	  
	    align:center;
	    top: 20%;
	    padding: 10%;
	    
		
	}
	
	#main2
	{
		text-align: center;
		color: balck;
		font-family: Helvetica;
		font-size:55px;
	}

	button
	{
		align:center;
		width: 15%;
		text-align: center;
		color: balck;
		font-family: Helvetica;
		font-size:19.5px;
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
	
#feedpage2{
	display: block;
    margin-left: auto;
    margin-right: auto;
    margin-bottom: 30px;
    width: 700px;
	font-size: 70px;
	text-align: center;
	color: #E26B2E;
}

</style>

		<meta charset="UTF-8">
		<title>Style Has Been Transferred!</title>
		<link rel="stylesheet" type="text/css" href="stylesheet.css" />
		<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Pacifico" />
	</head>
	<!-- this is the link that I am using for getting the picture https://www.w3schools.com/js/tryit.asp?filename=tryjs_dom_image-->
	<script>
	
	function getUrlVars() {
	    var vars = {};
	    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
	        vars[key] = value;
	    });
	    return vars;
	}
	</script>
	<script>
	function getUrlParam(parameter, defaultvalue){
	    var urlparameter = defaultvalue;
	    if(window.location.href.indexOf(parameter) > -1){
	        urlparameter = getUrlVars()[parameter];
	        }
	    return urlparameter;
	}
	</script>
	<script>
	
		window.onload = function()
		{
			var imgLink = getUrlParam('imgLink','Empty');
			console.log(imgLink);
			document.getElementById("image").src =  imgLink;	
			document.getElementById("image2").href = imgLink;
		
		}
	</script>
	<script>
	function toPrint(source) {
		return "<html><head><script>function step1(){\n" +
				"setTimeout('step2()', 10);}\n" +
				"function step2(){window.print();window.close()}\n" +
				"</scri" + "pt></head><body onload='step1()'>\n" +
				"<img src='" + source + "' /></body></html>";
	}
	function printImage() {
		var imgLink = getUrlParam('imgLink','Empty');
		var source = imgLink;
		alert(source);
		Pagelink = "about:blank";
		var pwa = window.open(Pagelink, "_new");
		pwa.document.open();
		pwa.document.write(toPrint(source));
		pwa.document.close();
	}
	</script>
	
	<script src="https://smtpjs.com/v2/smtp.js"></script>
	<script>
		function emailImage() {
			
			var email = <%= request.getSession().getAttribute("Email") %>;
			console.log("email");
						
			window.open('mailto:'+ email+ '?subject=StyleTransfer&body=' + 	document.getElementById("image").src );
			
		
			
		}
	</script>
	
	<script>
		function downloadImage() {
		    var x = document.getElementById("bt2");
		}
	</script>
	<body>
		<div class="topnav">
		  <a href="./about.jsp">About</a>
		  <a href="./profile.jsp">My Pictures</a>
		  <a href="./Feed.jsp">Global Feed</a>
		  <a href="./ChooseTransfer.jsp">Create a Style Transferred Image</a>
		  <a id="signout" href="./Login.jsp">Sign Out</a>
		</div>
		<div class="column side">
		</div>
		<div class="column middle">
			<h1 id="feedpage2" style="font-family:Pacifico;">Style Transferred!</h1>
			
			<div id = "main2"> <img id = "image" src = "" >
			<br></br>
				<span><button type = "button" id = "bt1" onclick = "printImage(); return false;">Print</button>
			
				<a id = "image2" href="" download = "myimage.jpg"><button type = "button" id = "bt2" >Download</button></a>
			
				<a id = "email" href = "mailto:email@example.com" ><button type = "button" id = "bt3" onclick = "emailImage(); return false;" >Email</button></a>
				
			</span>			
		</div>
			</div>
		</div>
		<div class="column side">
		</div>
	</body>
