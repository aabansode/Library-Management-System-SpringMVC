<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!doctype html>
<html>
<head>
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
	<form:form modelAttribute="adherent" action="save" cssClass="form-group">

		<table class="table table-bordered">

			<tr>
			<div class="form-group">
				<td>Nom</td>
				<td><form:input path="nom" cssClass="form-control form-control-sm"/></td>
			</div>
			</tr>

			<tr>
			<div class="form-group">
				<td>Prenom</td>
				<td><form:input path="lastName" cssClass="form-control form-control-sm" /></td>
			</div>
			</tr>
			<tr>
				<td>Adresse</td>
				<td><form:input path="adress" cssClass="form-control form-control-sm"/></td>
			</tr>
			<tr>
				<td>N CIN </td>
				<td><form:input path="ncin" cssClass="form-control form-control-sm"/></td>
			</tr>
			<tr>
				<td>Tel</td>
				<td><form:input path="tel" cssClass="form-control form-control-sm"/></td>
			</tr>
			<tr>
				<td>Mail</td>
				<td><form:input path="mail" cssClass="form-control form-control-sm"/></td>
			</tr>

			<tr>
				<td>Date</td>
				<td><form:input path="dateAdh" type="Date" cssClass="form-control form-control-sm"/></td>
			</tr>

			<tr>
				<td><label></label></td>
				<!-- <td><input type="submit" value="Save" class="save" /></td>-->
				<td><button type="submit" class="btn btn-primary">Submit</button></td>
				
			</tr>

		</table>

	</form:form>
</body>
</html>