<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Confirm Password</title>
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- icheck bootstrap -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/adminlte.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
<!-- Google Font: Source Sans Pro -->
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700"
	rel="stylesheet">
</head>
<body class="hold-transition login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="#"><b>Blog</b></a>
		</div>
		<!-- /.login-logo -->
		<div class="card">
			<div class="card-body login-card-body">
				<p class="login-box-msg">Change your password.</p>

				<form:form action="user-change-password-action"
					modelAttribute="changePassword" role="form">
					<div class="input-group mb-3">
						<form:input type="password" class="form-control"
							placeholder="Enter old password" path="oldPassword" />
						<br>
						<form:errors path="oldPassword" cssClass="text-danger" />
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-lock-open"></span>
							</div>
						</div>
					</div>
					<div class="input-group mb-3">
						<form:input type="password" class="form-control"
							placeholder="Enter new password" path="newPassword" />
						<br>
						<form:errors path="newPassword" cssClass="text-danger" />
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-lock"></span>
							</div>
						</div>
					</div>
					<div class="input-group mb-3">
						<form:input type="password" class="form-control"
							placeholder="Confirm new password" path="confirmPassword" />
						<form:errors path="confirmPassword" cssClass="text-danger" />
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-lock"></span>
							</div>
						</div>
					</div>
						<div class="col-12">
							<button type="submit" class="btn btn-primary btn-block">Confirm
								Password Change</button>
						</div>
					<br>
					<div>
							<div class="col-12">
								<a href="user-list"><button type="submit"
										class="btn btn-primary btn-block">Cancel</button></a>
							</div>
						</div>
				</form:form>
			</div>
			<!-- /.col -->
		</div>
		<div class="card-footer text-center">Blog</div>
		<!-- /.login-card-body -->
	</div>
	<!-- /.login-box -->

	<!-- jQuery -->
	<script
		src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script
		src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->
	<script
		src="${pageContext.request.contextPath}/dist/js/adminlte.min.js"></script>

</body>
</html>