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
		<% String email = (String) request.getSession().getAttribute("Email");%>
		var emailstatus = "<%= email %>";
		if(emailstatus == "guest"){
			updatePhotosGuest();
		} else {
			var xhttp = new XMLHttpRequest();
			var URL = "http://localhost:8080/Project/GetUserPhotos";
			xhttp.open("GET", URL, true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.addEventListener("load", updatePhotos);
			xhttp.send();
		}
	}
		
	function updatePhotos() {
		var jsonStr = this.responseText;
		var photoStream = JSON.parse(jsonStr);
		var streamArray = photoStream.streamArray;
		console.log(streamArray.length);
		for (var i in streamArray) {
			//extract data from stream object
			var photoPair = streamArray[i];
			var imageID = photoPair.imageID;
			var originalPhotoPath = photoPair.originalPhotoPath;
			var newPhotoPath = photoPair.newPhotoPath;
			var numLikes = photoPair.numLikes;
			var likedByCurrUser = photoPair.likedByCurrUser;
			var timediff = photoPair.timediff;
			//display photos to the page
			if(likedByCurrUser){
				document.getElementById("myimages").innerHTML += "<p>" + timediff + "<p><div id='myimagesets' style='display: block; margin-left: auto; margin-right: auto; width:605px'><a href='./Output.jsp?imgLink=" + originalPhotoPath + "'><img id = 'myimg1' src='" + originalPhotoPath + "' style='height: 300px; width: 300px;'></a> <a href='./Output.jsp?imgLink=" + newPhotoPath + "'><img id = 'myimg2' src='" + newPhotoPath + "' style='height: 300px; width: 300px;'></a></div><br /><div id='likebutton" + imageID + "'><input id='unlike' type='submit' value='Unlike' style='height: 30px; width: 200px; ' onclick='Unlike(" + imageID + ")'></input> <span style='font: 100% Lucida Sans, Verdana; color: #E26B2E;'>" + numLikes + " people like this</span></div>";
			} else{
				document.getElementById("myimages").innerHTML += "<p>" + timediff + "<p><div id='myimagesets' style='display: block; margin-left: auto; margin-right: auto; width:605px'><a href='./Output.jsp?imgLink=" + originalPhotoPath + "'><img id = 'myimg1' src='" + originalPhotoPath + "' style='height: 300px; width: 300px;'></a> <a href='./Output.jsp?imgLink=" + newPhotoPath + "'><img id = 'myimg2' src='" + newPhotoPath + "' style='height: 300px; width: 300px;'></a></div><br /><div id='likebutton" + imageID + "'><input id='like' type='submit' value='Like' style='height: 30px; width: 200px; ' onclick='Like(" + imageID + ")'></input> <span style='font: 100% Lucida Sans, Verdana; color: #E26B2E;'>" + numLikes + " people like this</span></div>";
			}
		}
		if(streamArray.length == 0){
			document.getElementById("myimages").innerHTML += "<center><p style='font-size=20px;'>You don't have any style-transferred images! Go to the 'Create a Style-Transferred Image' tab to make one now!<p></center>";
		}
	}
	function updatePhotosGuest() {
		<%@ page import="java.util.*" %>
		<% ArrayList<String> profile = (ArrayList<String>) request.getSession().getAttribute("GuestList");
		profile.add("./titleimage1.jpg");
		profile.add("./titleimage2.png");
			for(int i = 0; i < profile.size(); i+=2){
				%> document.getElementById("myimages").innerHTML += "<p>Guest created this sometime ago<p><div id='myimagesets' style='display: block; margin-left: auto; margin-right: auto; width:605px'><a href='./Output.jsp?imglink='<%= profile.get(i)%>'><img id = 'myimg1' src='<%= profile.get(i)%>' style='height: 300px; width: 300px;'></a> <a href='./Output.jsp?imglink='<%= profile.get(i+1)%>'><img id = 'myimg2' src='<%= profile.get(i+1)%>' style='height: 300px; width: 300px;'></a></div><br />";<%
			}
			if(profile.size() == 0){
				%> document.getElementById("myimages").innerHTML += "<center><p style='font-size=20px;'>You don't have any style-transferred images! Go to the 'Create a Style-Transferred Image' tab to make one now!<p></center>";<%
			}
		%>
		
	}
	function Like(imageID){
		var xhttp = new XMLHttpRequest();
		console.log(imageID);
		var URL = "http://localhost:8080/Project/ChangeLikeStatus?imageID=" + imageID;
		console.log(URL);
		xhttp.open("GET", URL, true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send();
		xhttp.onreadystatechange = function(){
			numLikes = this.responseText;
			document.getElementById("likebutton" + imageID).innerHTML = "<input id='unlike' type='submit' value='Unlike' style='height: 30px; width: 200px; ' onclick='Unlike(" + imageID + ")'></input> <span style='font: 100% Lucida Sans, Verdana; color: #E26B2E;'>" + numLikes + " people like this</span>";				
		}
	}
	function Unlike(imageID){
		var xhttp = new XMLHttpRequest();
		console.log(imageID);
		var URL = "http://localhost:8080/Project/ChangeLikeStatus?imageID=" + imageID;
		xhttp.open("GET", URL, true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send();
		xhttp.onreadystatechange = function(){
			numLikes = this.responseText;
			document.getElementById("likebutton" + imageID).innerHTML = "<input id='like' type='submit' value='Like' style='height: 30px; width: 200px; ' onclick='Like(" + imageID + ")'></input> <span style='font: 100% Lucida Sans, Verdana; color: #E26B2E;'>" + numLikes + " people like this</span>";				
		}
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