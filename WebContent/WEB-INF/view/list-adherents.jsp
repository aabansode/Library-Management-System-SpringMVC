<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- support for jstl -->

<!doctype html>
<html>

<head>
<script>
	
</script>

<style>
#myInput {
	background-image: url('/css/searchicon.png');
	/* Add a search icon to input */
	background-position: 10px 12px; /* Position the search icon */
	background-repeat: no-repeat; /* Do not repeat the icon image */
	width: 100%; /* Full-width */
	font-size: 16px; /* Increase font-size */
	padding: 12px 20px 12px 40px; /* Add some padding */
	border: 1px solid #ddd; /* Add a grey border */
	margin-bottom: 12px; /* Add some space below the input */
	
	
}
body{

	/* line@height:amount of space between each line*/
	font:15px/1.5 Arial,Helvetica,sans-serif;
	/* the previous replaces the following
	font-family:Arial,Helvetica,sans-serif;
	font-size:15px;
	line@height:1.5;
	*/
	
	padding:0;
	margin:0;
	background-color:#f4f4f4;
	margin:auto;
}
</style>

<!-- 
<link type="text/css" rel="stylesheet" 
href="${pageContext.request.contextPath}/resources/bootstrap-4.3.1/css/bootstrap.min.css"/>
<script src="<c:url value="/resources/bootstrap-4.3.1/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/myjs.js" />"></script>
<script src="<c:url value="/resources/jquery-3.4.0.min.js" />"></script>
<script src="<c:url value="/resources/popper.min.js" />"></script> -->

<!-- Latest compiled and minified CSS -->
<script src="<c:url value="/resources/myjs.js" />"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>

	<nav class="navbar navbar-expand-md bg-dark navbar-dark">
		<!-- Brand -->
		<a class="navbar-brand" href="#">Library Management System</a>

		<!-- Toggler/collapsibe Button -->
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>

		<!-- Navbar links -->
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="/Library_Project/adherent/list">Members</a></li>
				<li class="nav-item"><a class="nav-link" href="/Library_Project/exemplaire/list">Books</a></li>
			</ul>
		</div>
	</nav>
	<br><br>
	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-10">
				<h1 class="text-center text-dark">LIST OF MEMBERS</h1>
			</div>
		</div>
	</div>

	<br>
	&nbsp;&nbsp;<input type="button" value="Add Member"
		onclick="window.location.href='showform';" class="btn btn-primary"/>
	<br>
	<br>
	<input type="text" id="myInput" onkeyup="myFunction()"
		placeholder="Search for names.." class="form-control">


	<br>
	<br>
	<table id="myTable" class="table table-bordered table-hover">
		<tr>
			<th>Nom</th>
			<th>Prenom</th>
			<th>Adresse</th>
			<th>N.CIN</th>
			<th>Tel</th>
			<th>Date</th>
			<th>Mail</th>
			<th>Action</th>
		</tr>

		<c:forEach var="tempAdherent" items="${adherents}">

			<!-- construct an update link with adherent id -->
			<c:url var="updateLink" value="/adherent/showformupdate">
				<c:param name="ncin" value="${tempAdherent.ncin}" />
			</c:url>

			<!-- construct a delete link with adherent id -->

			<c:url var="deleteLink" value="/adherent/delete">
				<c:param name="ncin" value="${tempAdherent.ncin}" />
			</c:url>

			<tr>
				<td>${tempAdherent.nom}</td>
				<td>${tempAdherent.lastName}</td>
				<td>${tempAdherent.adress}</td>
				<td>${tempAdherent.ncin}</td>
				<td>${tempAdherent.tel}</td>
				<td>${tempAdherent.dateAdh}</td>
				<td>${tempAdherent.mail}</td>
				<td><a href="${updateLink}"><button class="btn btn-success">UPDATE</button>&nbsp;&nbsp;</a>
					<a href="${deleteLink}"
					onclick="if(!(confirm('Are you sure you want to delete this member?'))) return false"><button class="btn btn-danger" >DELETE</button></a>
					</td>
			</tr>

		</c:forEach>

	</table>
	
	<footer>
	Copyright © Wassim Hajji 
	</footer>
</body>
</html>