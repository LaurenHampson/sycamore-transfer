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
		<h1 id="transferpage" style="font-family:Pacifico;">Pick Your Transfer</h1>
		<div id="boxes" style="width:100%;">
			<div id="uploadbox">
				<img id="test" src="" alt="NO Image Selected">
			</div>
			
			<div id="stylebox">
				<div id="stylerow" style="width:100%; ">
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
				</div>
				<br />
				<br />
				<div id="stylerow" style="width:100%; ">
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
				</div>
				<br />
				<br />
				<div id="stylerow" style="width:100%; ">
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
					<div id="styleobj" style="align:middle; width:24%; margin:0px; display:inline-block;">
				  		<a onclick="selectedStyle('./titleimage1.jpg');"><img height=100px width=100px src="./titleimage1.jpg" tabindex="1" onfocus="myFunction(this)"/></a>
					</div>
				</div>
			</div>
		</div>
		<div id="uploadform">
			<form name="uploadform" method="post" enctype="multipart/form-data">
			    Select image to upload:
			    <input type="file" id="pic" accept="image/*" onchange="onUploadClick();">
			    <br />
			    
			</form>
		</div>
		<br />
		<br />
		<br />
		<button name="submit" style="width:100px; background-color:#E26B2E; margin-left:645px; width:150px; color:white; font-size:25px; font-family:Pacifico; height:50px;" onclick="Submit();" >Transfer</button>
		
	</body>
</html>