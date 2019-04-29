<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- JSTL support -->

<!doctype html>
<html>
<head>

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
				<h1 class="text-center text-dark">LIST OF COPIES</h1>
			</div>
		</div>
	</div>

	<br>
	&nbsp;&nbsp;<input type="button" value="Add Copy"
		onclick="window.location.href='showform';" class="btn btn-primary"/>
	<br>
	<br>
	<input type="text" id="myInput1" onkeyup="myFunction1()"
		placeholder="Search for copies" class="form-control">

	<br>

	<table id="myTable1" class="table table-bordered table-hover">
	<tr>
	<th>Copy</th>
	<th>Catalog </th>
	<th>Status</th>
	<th>Availability</th>
	<th>Action</th>
	</tr>
	
	<c:forEach var="tempexemplaire" items="${exemplaires}">
	
	<!-- construct an update link with exemplaire id -->
		<c:url var="updateLink" value="/exemplaire/showformupdate">
			<c:param name="codexp" value="${tempexemplaire.codexp}" />
		</c:url>
		
		<c:url var="deleteLink" value="/exemplaire/delete">
			<c:param name="codexp" value="${tempexemplaire.codexp}" />
		</c:url>

	
		<tr>
			<td>${tempexemplaire.codexp}</td>
			<td>${tempexemplaire.codeg}</td>
			<td>${tempexemplaire.etat}</td>
			<td>${tempexemplaire.disp}</td>
			<td><a href="${updateLink}"><button class="btn btn-success center-block">UPDATE</button>&nbsp;&nbsp;</a>
					<a href="${deleteLink}"
					onclick="if(!(confirm('Are you sure you want to delete this copy?'))) return false"><button class="btn btn-danger center-block" >DELETE</button></a>
		</td>
		</tr>
		
	</c:forEach>
	</table>
</body>
</html>