<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Global Feed</title>
		<link rel="stylesheet" type="text/css" href="stylesheet.css" />
		<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Pacifico" />
	</head>
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
			<h1 id="feedpage" style="font-family:Pacifico;">Branching Out</h1>
			<div id="myimages" style="display: block; margin-left: auto; margin-right: auto; width:605px">
				<!-- CODE FOR TOMMY TO SEND FROM DATABASE - ASK TOMMY HOW THEY WANT IMAGES SENT THEN ADD LINK FOR IMAGES TO OUTPUT.JSP-->
				<p>5 minutes ago<p>
				<div id="myimagesets" style="display: block; margin-left: auto; margin-right: auto; width:605px">
					<a href="./output.jsp?imgurl=titleimage1.jpg"><img id = "myimg1" src="titleimage1.jpg" style="height: 300px; width: 300px;"></a>
					<a href="./output.jsp?imgurl=titleimage1.jpg"><img id = "myimg2" src="titleimage2.png" style="height: 300px; width: 300px;"></a>
				</div><br />
				<p>10 minutes ago<p>
				<div id="myimagesets" style="display: block; margin-left: auto; margin-right: auto; width:605px">
					<a href="./output.jsp?imgurl=titleimage1.jpg"><img id = "myimg1" src="titleimage1.jpg" style="height: 300px; width: 300px;"></a>
					<a href="./output.jsp?imgurl=titleimage1.jpg"><img id = "myimg2" src="titleimage2.png" style="height: 300px; width: 300px;"></a>
				</div>
			</div>
		</div>
		<div class="column side">
		</div>
	</body>
</html>