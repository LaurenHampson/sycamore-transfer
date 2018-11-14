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
		var style = "";
		var inputFile = "";
		function selectedStyle(name){
			console.log(name);
		    style = name;
		}
		function Submit(){
			var a = document.createElement('a');
			a.href = document.getElementById('test').src;
			a.download = inputFile;
			document.body.appendChild(a);
			a.click();
			runStyleTransfer();
			document.body.removeChild(a);
		    
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
			
			// I swear if we have collisions after this I will murder something 
			random_output = (Math.random() * 100_000_000_000) / (Math.random() * 100_000);
			random_output = <%= (String) request.getSession().getAttribute("UserName") %> + random_output; 
			
			request_str += "&output=" + random_output + ".png";
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
					<a onclick="selectedStyle('./styles/adam.jpg');"><img height=100px width=100px src="./styles/adam.jpg" tabindex="1"/></a>
					<a onclick="selectedStyle('./styles/americangothic.jpg');"><img height=100px width=100px src="./styles/americangothic.jpg" tabindex="1"/></a>
					<a onclick="selectedStyle('./styles/bobross.jpg');"><img height=100px width=100px src="./styles/bobross.jpg" tabindex="1"/></a>
					<a onclick="selectedStyle('./styles/gottlob.jpg');"><img height=100px width=100px src="./styles/gottlob.jpg" tabindex="1" /></a>
					<a onclick="selectedStyle('./styles/greatwave.jpg');"><img height=100px width=100px src="./styles/greatwave.jpg" tabindex="1" /></a>
					<a onclick="selectedStyle('./styles/impressionism.jpg');"><img height=100px width=100px src="./styles/impressionism.jpg" tabindex="1" /></a>
					<a onclick="selectedStyle('./styles/monalisa.jpg');"><img height=100px width=100px src="./styles/monalisa.jpg" tabindex="1" /></a>
					<a onclick="selectedStyle('./styles/paris.png');"><img height=100px width=100px src="./styles/paris.png" tabindex="1" /></a>
					<a onclick="selectedStyle('./styles/picasso.jpg');"><img height=100px width=100px src="./styles/picasso.jpg" tabindex="1" /></a>
					<a onclick="selectedStyle('./styles/scream.jpg');"><img height=100px width=100px src="./styles/scream.jpg" tabindex="1" /></a>
					<a onclick="selectedStyle('./styles/starrynight.jpg');"><img height=100px width=100px src="./styles/starrynight.jpg" tabindex="1" /></a>
					<a onclick="selectedStyle('./styles/sundayafternoon.jpg');"><img height=100px width=100px src="./styles/sundayafternoon.jpg" tabindex="1" /></a>
				</div>
			</div>
		</div>
		<br />
		<br />
		<br />
		<button id="transferbutton" name="submit" onclick="Submit();" >Transfer</button>
	</body>
</html>
