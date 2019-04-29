<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- support for jstl & spring forms -->
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
	<c:choose>
	    <c:when test="${enter==1}">
	       
			<form:form modelAttribute="exemplaire" action="saveorupdate">
				
				<table class="table table-bordered">
					
					<tr>
					<div class="form-group">
						<td>Copy</td>
						<td><form:input path="codexp" cssClass="form-control form-control-sm"/></td>
					</div>
					</tr>	
					
					<tr>
					<div class="form-group">
						<td>Cataog</td>
						<td><form:input path="codeg" cssClass="form-control form-control-sm"/></td>
					</div>
					</tr>
					
					<tr>
					<div class="form-group">
						<td>Status</td>
						<td><form:input path="etat" cssClass="form-control form-control-sm"/></td>
					</div>
					</tr>
					
					<tr>
					<div class="form-group">
						<td>Availability</td>
						<td><form:input path="disp" cssClass="form-control form-control-sm"/></td>
					</div>
					</tr>
					
					<tr>
					<td><label></label></td>
					<!-- <td><input type="submit" value="Save" class="save" /></td>-->
					<td><button type="submit" class="btn btn-primary">Submit</button></td>
				
					</tr>
			
				</table>
			
			</form:form>

	        <br />
	    </c:when>    
	    <c:otherwise>
	        <form:form modelAttribute="exemplaire" action="saveorupdate">
				
				<table class="table table-bordered">
					
					<tr>
					<div class="form-group">
						<td>Copy</td>
						<td><form:input path="codexp" cssClass="form-control form-control-sm" readonly="true"/></td>
					</div>
					</tr>	
					
					<tr>
					<div class="form-group">
						<td>Cataog</td>
						<td><form:input path="codeg" cssClass="form-control form-control-sm" readonly="true"/></td>
					</div>
					</tr>
					
					<tr>
					<div class="form-group">
						<td>Status</td>
						<td><form:input path="etat" cssClass="form-control form-control-sm"/></td>
					</div>
					</tr>
					
					<tr>
					<div class="form-group">
						<td>Availability</td>
						<td><form:input path="disp" cssClass="form-control form-control-sm"/></td>
					</div>
					</tr>
					
					<tr>
					<td><label></label></td>
					<!-- <td><input type="submit" value="Save" class="save" /></td>-->
					<td><button type="submit" class="btn btn-primary">Submit</button></td>
				
					</tr>
			
				</table>
			
			</form:form> 
	        <br />
	    </c:otherwise>
	</c:choose>
</body>
</html>