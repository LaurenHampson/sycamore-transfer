<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Style Transfer</title>
		<link rel="stylesheet" type="text/css" href="stylesheet.css" />
		<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Pacifico" />
	</head>
	<body id="about">
		<div class="topnav">
		  <a href="./about.jsp">About</a>
		  <a href="./profile.jsp">My Pictures</a>
		  <a href="./Feed.jsp">Global Feed</a>
		  <a href="./ChooseTransfer.jsp">Create a Style Transferred Image</a>
		  <a id="signout" href="./Login.jsp">Sign Out</a>
		</div>
		<div class="column middle">
			<div class="card">
				<h1 id="aboutpage" style="font-family:Pacifico; color: #E26B2E;">About Style Transfer</h1>
				<p>Style transfer is the technique of recomposing images in the style of other images. These were mostly created using <a href="https://github.com/jcjohnson/neural-style">Justin Johnson’s code</a> based on the <a href="https://arxiv.org/abs/1508.06576">paper by Gatys, Ecker, and Bethge</a> demonstrating a method for restyling images using convolutional neural networks. Instructions <a href="https://gist.github.com/genekogan/d61c8010d470e1dbe15d">here</a>, and more details <a href="https://gitxiv.com/posts/jG46ukGod8R7Rdtud/a-neural-algorithm-of-artistic-style">here</a>. A gallery with all of these and more style transfers can be <a href="https://www.flickr.com/photos/genekogan/albums/72157658785675071">viewed here</a>.</p>
				<p>Pablo Picasso <a href="https://www.youtube.com/watch?v=CkRS3wDg1xU">painting on glass in 1937</a>, restyled by works from his Blue, African, and Cubist periods respectively.</p>
				<video width=90% autoplay muted loop>
				<source src="./picasso-periods.mp4" type="video/mp4">
				</video>
			</div>
			<div class="card">
				<h1 id="aboutpage" style="font-family:Pacifico; color: #E26B2E;">About Machine Learning</h1>
				<p>Because of new computing technologies, machine learning today is not like machine learning of the past. It was born from pattern recognition and the theory that computers can learn without being programmed to perform specific tasks; researchers interested in artificial intelligence wanted to see if computers could learn from data. The iterative aspect of machine learning is important because as models are exposed to new data, they are able to independently adapt. They learn from previous computations to produce reliable, repeatable decisions and results. It’s a science that’s not new – but one that has gained fresh momentum.</p>
			</div>
		</div>
		<div class="column side">
			<div class="card">
				<h1 id="aboutpage" style="font-family:Pacifico; color: #E26B2E;">The Team</h1>
				<div id="teammember" style="width:45%; display:inline-block;">
					<img src = "./titleimage1.jpg" style="width: 100px; height: 100px; border-radius:50%">
					<p>Andrew Charters<p>
				</div>
				<div id="teammemberinfo" style="width:45%; display:inline-block;">
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet pretium urna. Vivamus venenatis velit nec neque ultricies, <p>
				</div>
				<div id="teammember" style="width:45%; display:inline-block;">
					<img src = "./titleimage1.jpg" style="width: 100px; height: 100px; border-radius:50%">
					<p>Ishan Shah<p>
				</div>
				<div id="teammemberinfo" style="width:45%; display:inline-block;">
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet pretium urna. Vivamus venenatis velit nec neque ultricies, <p>
				</div>
				<div id="teammember" style="width:45%; display:inline-block;">
					<img src = "./titleimage1.jpg" style="width: 100px; height: 100px; border-radius:50%">
					<p>Kousheyo Kundu<p>
				</div>
				<div id="teammemberinfo" style="width:45%; display:inline-block;">
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet pretium urna. Vivamus venenatis velit nec neque ultricies, <p>
				</div>
				<div id="teammember" style="width:45%; display:inline-block;">
					<img src = "./titleimage1.jpg" style="width: 100px; height: 100px; border-radius:50%">
					<p>Lauren Hampson<p>
				</div>
				<div id="teammemberinfo" style="width:45%; display:inline-block;">
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet pretium urna. Vivamus venenatis velit nec neque ultricies, <p>
				</div>
				<div id="teammember" style="width:45%; display:inline-block;">
					<img src = "./titleimage1.jpg" style="width: 100px; height: 100px; border-radius:50%">
					<p>Tommy Acin<p>
				</div>
				<div id="teammemberinfo" style="width:45%; display:inline-block;">
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet pretium urna. Vivamus venenatis velit nec neque ultricies, <p>
				</div>
				<div id="teammember" style="width:45%; display:inline-block;">
					<img src = "./titleimage1.jpg" style="width: 100px; height: 100px; border-radius:50%">
					<p>Zane Durante<p>
				</div>
				<div id="teammemberinfo" style="width:45%; display:inline-block;">
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet pretium urna. Vivamus venenatis velit nec neque ultricies, <p>
				</div>
			</div>
		</div>
		<div class="footer">
		
		</div>
	</body>
</html>