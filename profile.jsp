<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>My Pictures</title>
		<link rel="stylesheet" type="text/css" href="stylesheet.css" />
		<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Pacifico" />
	</head>
	<script>
	window.onload = function(){
		var xhttp = new XMLHttpRequest();
		var URL = "http://localhost:8080/Project/GetUserPhotos";
		xhttp.open("GET", URL, true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.addEventListener("load", updatePhotos);
		xhttp.send();
	}
		
	function updatePhotos() {
		var jsonStr = this.responseText;
		var photoStream = JSON.parse(jsonStr);
		var streamArray = photoStream.streamArray;
		for (var i in streamArray) {
			//extract data from stream object
			var photoPair = streamArray[i];
			var imageID = photoPair.imageID;
			var originalPhotoPath = photoPair.originalPhotoPath;
			var newPhotoPath = photoPair.newPhotoPath;
			var numLikes = photoPair.numLikes;
			var likedByCurrUser = photoPair.likedByCurrUser;
			//var TimeStamp = photoPair.
			//display photos to the page
			document.getElementById("myimages").innerHTML += "<p>5 minutes ago<p><div id='myimagesets' style='display: block; margin-left: auto; margin-right: auto; width:605px'><a href='./Output.jsp?imglink=" + originalPhotoPath + "'><img id = 'myimg1' src='" + originalPhotoPath + "' style='height: 300px; width: 300px;'></a> <a href='./Output.jsp?imglink=" + newPhotoPath + "'><img id = 'myimg2' src='" + newPhotoPath + "' style='height: 300px; width: 300px;'></a></div><br /><input id='like' type='submit' value='Like' style='height: 30px; width: 200px; ' onclick='Like(" + imageID + ")'></input> <span style='font: 100% Lucida Sans, Verdana; color: #E26B2E;'>" + numLikes + " people like this</span>";
		}
	}
	function Like(imageID){
		var xhttp = new XMLHttpRequest();
		var URL = "http://localhost:8080/Project/GetGlobalFeed?imageID=" + imageID;
		xhttp.open("GET", URL, true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send();
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
			<h1 id="profilepage" style="font-family:Pacifico;">My Pictures</h1>
			<div id="myimages" style="display: block; margin-left: auto; margin-right: auto; width:605px">
			</div>
		</div>
		<div class="column side">
		</div>
	</body>
</html>