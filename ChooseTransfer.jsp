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
		function selectedStyle(name){
			console.log(name);
		    
		}
		function Submit(){
			var a = document.createElement('a');
			a.href = document.getElementById('test').src;
			a.download = "test/output.png";
			document.body.appendChild(a);
			a.click();
			document.body.removeChild(a);
		    
		}
		function onUploadClick(){
			var input = document.getElementById("pic");
			var fReader = new FileReader();
			fReader.readAsDataURL(input.files[0]);
			fReader.onloadend = function(event){
			    var img = document.getElementById("test");
			    img.src = event.target.result;
			    var imgbox = document.getElementById("uploadbox");
			    img.width = 500;
			    img.height = 500;
			}
		}
		
		function myFunction(x) {
			console.log("bitxh");
		    x.style = "100px";
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
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
				</div>
			</div>
		</div>
		<br />
		<br />
		<br />
		<button id="transferbutton" name="submit" onclick="Submit();" >Transfer</button>
	</body>
</html>