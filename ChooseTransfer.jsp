<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Pick Your Transfer</title>
		<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Pacifico" />
		<link rel="stylesheet" type="text/css" href="stylesheet.css" />
		<script>
		window.onload = function(){
			<% String email = (String) request.getSession().getAttribute("Email");%>
			var emailstatus = "<%= email %>";
			if(emailstatus == "guest"){
				for(var i = 0 ; i < 7; i++){
					document.getElementById("change").onclick = "";
					document.getElementById("change").style = "filter:grayscale(100%);";
					document.getElementById("change").id = "blah";
					document.getElementById("changeimg").tabindex = null;
					document.getElementById("changeimg").id = "blah";
				}
				
			}
		}
		var style = "";
		var inputFile = "";
		function selectedStyle(name, screenname){
			console.log(name);
		    style = name;
		    document.getElementById("selectedstyle").innerHTML = "<p style='margin:0px; margin-left:30px;'>Selected Style: " + screenname + "<p>";
		}
		function Submit(){
			if(style == "" || inputFile == ""){
				alert("You must upload an image and pick a style before running style transfer!");
			} else {
				var a = document.createElement('a');
				a.href = document.getElementById('test').src;
				a.download = inputFile;
				document.body.appendChild(a);
				a.click();
				runStyleTransfer();
				document.body.removeChild(a);
				alert("The style transfer process has begun. You will recieve email notifications when ready!");
			}
		}
		function onUploadClick(){
			var input = document.getElementById("pic");
			var fReader = new FileReader();
			fReader.readAsDataURL(input.files[0]);
			fReader.onloadend = function(event){
			    var img = document.getElementById("test");
			    img.src = event.target.result;
			    console.log(input.value);
			    inputFile = input.value.substring(12);
			    console.log(inputFile);
			    var imgbox = document.getElementById("uploadbox");
			    img.width = 500;
			    img.height = 500;
			}
		}
		
		function runStyleTransfer() {
			//var request_str = "PythonServlet?";
			var request_str = "input=" + inputFile;
			request_str += "&style=" + style;
			output_name = Math.random() * 1000; 
			output_name = <%=request.getSession().getAttribute("UserName") %> + output_name; 
			request_str += "&output=" + output_name + ".png";
			console.log("about to run");
			var xhttp = new XMLHttpRequest();
			xhttp.open("POST", "PythonServlet", true);
			xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xhttp.send(request_str);
		}
	    
		</script>
	</head>
	<body>
		<div class="topnav">
		  <a href="./about.jsp">About</a>
		  <a href="./profile.jsp">My Pictures</a>
		  <a href="./Feed.jsp">Global Feed</a>
		  <a href="./ChooseTransfer.jsp">Create a Style Transferred Image</a>
		  <a id="signout" href="./Login.jsp">Sign Out</a>
		</div>
		<h1 id="transferpage" style="font-family:Pacifico;">Pick Your Transfer</h1>
		<div id="boxes" style="width:100%;">
			<div id="uploadbox">
				<img id="test" src="" alt="NO Image Selected">
				<div id="uploadform">
					<form name="uploadform" method="post" enctype="multipart/form-data">
					    Select image to upload:
					    <input type="file" id="pic" accept="image/*" onchange="onUploadClick();">
					</form>
				</div>
			</div>
			<div id="stylebox" style="width: 49.5%; float:left;">
				<div id ="styleset">
					<a onclick="selectedStyle('./styles/adam.jpg', 'Adam');"><img height=100px width=100px src="./styles/adam.jpg"/></a>
					<a onclick="selectedStyle('./styles/americangothic.jpg', 'American Gothic');"><img height=100px width=100px src="./styles/americangothic.jpg"/></a>
					<a onclick="selectedStyle('./styles/bobross.jpg', 'Bob Ross');"><img height=100px width=100px src="./styles/bobross.jpg"/></a>
					<a onclick="selectedStyle('./styles/gottlob.jpg', 'Gottlob');"><img height=100px width=100px src="./styles/gottlob.jpg" /></a>
					<a onclick="selectedStyle('./styles/greatwave.jpg', 'Great Wave');"><img height=100px width=100px src="./styles/greatwave.jpg" /></a>
					<a id= "change" onclick="selectedStyle('./styles/impressionism.jpg', 'Impressionism');"><img id= "changeimg" height=100px width=100px src="./styles/impressionism.jpg" /></a>
					<a id= "change" onclick="selectedStyle('./styles/monalisa.jpg', 'Mona Lisa');"><img id= "changeimg" height=100px width=100px src="./styles/monalisa.jpg" /></a>
					<a id= "change" onclick="selectedStyle('./styles/paris.png', 'Paris');"><img id= "changeimg" height=100px width=100px src="./styles/paris.png" /></a>
					<a id= "change" onclick="selectedStyle('./styles/picasso.jpg', 'Picasso');"><img id= "changeimg" height=100px width=100px src="./styles/picasso.jpg" /></a>
					<a id= "change" onclick="selectedStyle('./styles/scream.jpg', 'Scream');"><img id= "changeimg" height=100px width=100px src="./styles/scream.jpg" /></a>
					<a id= "change" onclick="selectedStyle('./styles/starrynight.jpg', 'Starry Night');"><img id= "changeimg" height=100px width=100px src="./styles/starrynight.jpg" /></a>
					<a id= "change" onclick="selectedStyle('./styles/sundayafternoon.jpg', 'Sunday Afternoon');"><img id= "changeimg" height=100px width=100px src="./styles/sundayafternoon.jpg" /></a>
				</div><div id="selectedstyle"><p style="margin:0px; margin-left:30px;">Selected Style: Nothing Selected<p></div>
			</div>
			
		</div>
		<button id="transferbutton" name="submit" onclick="Submit();" >Transfer</button>
	</body>
</html>