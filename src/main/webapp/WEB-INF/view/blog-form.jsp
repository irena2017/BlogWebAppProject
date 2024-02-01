<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">

<title>Blog Form</title>

<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/adminlte.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/custom.css">
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700">
</head>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!-- Navbar -->
		<nav
			class="main-header navbar navbar-expand navbar-white navbar-light">
			<!-- Left navbar links -->
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" data-widget="pushmenu"
					href="#" role="button"><i class="fas fa-bars"></i></a></li>
			</ul>
			<!-- Right navbar links -->
			<ul class="navbar-nav ml-auto">
				<!-- Messages Dropdown Menu -->
				<sec:authorize access="hasRole('admin')">
					<li class="nav-item dropdown">
					<a class="nav-link"
						data-toggle="dropdown" href="#"> <i class="far fa-comments"></i>
							<span class="badge badge-danger navbar-badge">${messagesCount}</span>
					</a>
						<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
							<c:forEach var="message" items="${messageList}">
								<a href="message-list" class="dropdown-item"> <!-- Message Start -->
									<div class="media">
									<div class="avatar">
										<img src="${message.user.image.imageUrl}" alt="User Avatar"
											class="img-fluid rounded-circle"
											style="width: 60px; height: 60px; object-fit: cover;">
											</div>
										<div class="media-body">
											<h3 class="dropdown-item-title">${message.user.name} ${message.user.surname}</h3>
											<p class="text-sm">&emsp;${message.message}</p>
											<p class="text-sm1 text-muted">
												<i class="far fa-clock mr-1"></i> ${message.timeAgo}
											</p>
										</div>
									</div> <!-- Message End -->
								</a>
							</c:forEach>
							<div class="dropdown-divider"></div>
							<a href="message-list" class="dropdown-item dropdown-footer">
								See All Messages</a>
						</div></li>
				</sec:authorize>
				<li class="nav-item dropdown"><a class="nav-link"
					data-toggle="dropdown" href="#"> <i class="far fa-user"></i>
				</a>
					<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
						<a href="#" class="dropdown-item"> <!-- Message Start -->
							<div class="media align-items-center">
								<c:if test="${not empty principal}">
									<img src="${principal.image.imageUrl}" alt="User Avatar"
										class="img-brand-50 mr-3 img-circle"
										style="width: 120px; height: 120px">
									<div class="media-body">
										<h3 class="dropdown-item-title">${principal.name}
											${principal.surname}</h3>
									</div>
								</c:if>
							</div> <!-- Message End -->
						</a>
						<div class="dropdown-divider"></div>
						<a href="user-edit-profile" class="dropdown-item"> <i
							class="fas fa-user"></i> Your Profile
						</a>
						<div class="dropdown-divider"></div>
						<div class="dropdown-item">
							<form action="${pageContext.request.contextPath}/logout"
								method="post">
								<button type="submit" class="logout-button">
									<span class="fas fa-sign-out-alt"></span> Log Out
								</button>
							</form>
						</div></li>
			</ul>
		</nav>
		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<aside class="main-sidebar sidebar-dark-primary elevation-4">
			<!-- Brand Logo -->
			<a href="index3.html" class="brand-link"> <img
				src="${pageContext.request.contextPath}/dist/img/AdminLTELogo.png"
				alt="Cubes School Logo" class="brand-image img-circle elevation-3"
				style="opacity: .8"> <span
				class="brand-text font-weight-light">Cubes School</span>
			</a>
			<!-- Sidebar -->
			<div class="sidebar">
				<!-- Sidebar Menu -->
				<nav class="mt-2">
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<li class="nav-item has-treeview"><a href="blog-list"
							class="nav-link"> <i class="nav-icon far fa-plus-square"></i>
								<p>
									Blogs<i class="right fas fa-angle-left"></i>
								</p>
						</a> <sec:authorize access="hasRole('admin')">
								<ul class="nav nav-treeview">
									<li class="nav-item"><a href="blog-list" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>Blogs List</p>
									</a></li>
									<li class="nav-item"><a href="blog-form" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>Add Blog</p>
									</a></li>
								</ul>
							</sec:authorize>
						<li class="nav-item has-treeview"><a href="category-list"
							class="nav-link"> <i class="nav-icon far fa-plus-square"></i>
								<p>
									Categories<i class="right fas fa-angle-left"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="category-list"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>Category List</p>
								</a></li>
								<sec:authorize access="hasRole('admin')">
									<li class="nav-item"><a href="category-form"
										class="nav-link"> <i class="far fa-circle nav-icon"></i>
											<p>Add Category</p>
									</a></li>
								</sec:authorize>
							</ul></li>
					</ul>
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<li class="nav-item has-treeview"><a href="tag-list"
							class="nav-link"> <i class="nav-icon far fa-plus-square"></i>
								<p>
									Tags<i class="right fas fa-angle-left"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="tag-list" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Tags List</p>
								</a></li>
								<sec:authorize access="hasRole('admin')">
									<li class="nav-item"><a href="tag-form" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>Add Tag</p>
									</a></li>
								</sec:authorize>
							</ul></li>
					</ul>
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<li class="nav-item has-treeview"><a href="slide-list"
							class="nav-link"> <i class="nav-icon far fa-plus-square"></i>
								<p>
									Slides<i class="right fas fa-angle-left"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="slide-list" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Slides List</p>
								</a></li>
								<sec:authorize access="hasRole('admin')">
									<li class="nav-item"><a href="slide-form" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>Add Slide</p>
									</a></li>
								</sec:authorize>
							</ul></li>
					</ul>
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<li class="nav-item has-treeview"><sec:authorize
								access="hasRole('admin')">
								<a href="user-list" class="nav-link"> <i
									class="nav-icon far fa-plus-square"></i>
									<p>
										Users<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<li class="nav-item"><a href="user-list" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>User List</p>
									</a></li>

									<li class="nav-item"><a href="user-form" class="nav-link">
											<i class="far fa-circle nav-icon"></i>
											<p>Add User</p>
									</a></li>
							</sec:authorize>
					</ul>
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<li class="nav-item has-treeview"><sec:authorize
								access="hasRole('admin')">
								<a href="message-list" class="nav-link"> <i
									class="nav-icon far fa-plus-square"></i>
									<p>
										Messages<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<li class="nav-item"><a href="message-list"
										class="nav-link"> <i class="far fa-circle nav-icon"></i>
											<p>Messages List</p>
									</a></li>
							</sec:authorize>
					</ul>
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<li class="nav-item has-treeview"><sec:authorize
								access="hasRole('admin')">
								<a href="comment-list" class="nav-link"> <i
									class="nav-icon far fa-plus-square"></i>
									<p>
										Comments<i class="right fas fa-angle-left"></i>
									</p>
								</a>
								<ul class="nav nav-treeview">
									<li class="nav-item"><a href="comment-list"
										class="nav-link"> <i class="far fa-circle nav-icon"></i>
											<p>Comment List</p>
									</a></li>
							</sec:authorize>
					</ul>
				</nav>
				<!-- /.sidebar-menu -->
			</div>
			<!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>Blog Form</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a
									href="${pageContext.request.contextPath}/index-page">Home</a></li>
								<li class="breadcrumb-item"><a
									href="blog-list">Blogs</a></li>
								<li class="breadcrumb-item active">Blog Form</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card card-primary">
								<div class="card-header">
									<h3 class="card-title">Blog Form</h3>
								</div>
								<!-- /.card-header -->
								<!-- form start -->
								<form:form role="form" action="blog-save" modelAttribute="blog"
								method="post" enctype="multipart/form-data">
								 <form:hidden path="user.username"/>
									<div class="card-body">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label>Category</label>
													<form:hidden path="id" />
													<form:select path="category.id" class="form-control">
														<form:option value="" label="Uncategorized" />
														<form:options items="${categoryList}" itemValue="id"
															itemLabel="name" />
													</form:select>
												</div>
												<div class="form-group">
													<label>Name</label>
													<form:input path="name" type="text" class="form-control"
														placeholder="Enter name" />
													<form:errors path="name" cssClass="text-danger" />
												</div>
												<div class="form-group">
													<label>Description</label>
													<form:textarea type="text" class="form-control"
														placeholder="Enter your blog description"
														path="description" />
													<form:errors path="description" cssClass="text-danger" />
												</div>
												<div class="form-group">
													<label>Text</label>
													<form:textarea type="text" class="form-control"
														placeholder="Enter your blog text" path="text" />
													<form:errors path="text" cssClass="text-danger" />
												</div>
												<div class="form-group">
												<label>Tags</label>
												<form:select path="tagIds" items="${tagList}" itemLabel="name"
													itemValue="id" multiple="true" class="form-control" />
											    </div>
												<div class="form-group">
											  <label for="fileImages">Images</label> 
											  <input type="file" name="fileImages" id="fileImages" 
											  accept="image/png, image/jpeg, image/jpg" multiple/>
													<br><br>
													<c:if test="${not empty blog.images}">
													<img src="${blog.images[0].imageUrl}" alt="Current Photo" width="100"
													height="100" />
													</c:if>
												</div>
												<div class="custom-control custom-checkbox">
												<form:checkbox class="custom-control-input"
													id="customCheckbox1" path="important" />
												<label for="customCheckbox1" class="custom-control-label">Mark
													As Important</label>
											</div>
											<div class="card-footer">
												<button type="submit" class="btn btn-primary">Save</button>
												<a href="blog-list" class="btn btn-outline-secondary">Cancel</a>
											</div>
										</div>
									</div>
									</div>
									</form:form>
							</div>
						</div>
					</div>
				<!-- /.col -->
		</div>
		<!-- /.row -->
		<!-- /.container-fluid -->
		</section>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->

	<!-- Main Footer -->
	<footer class="main-footer">
		<!-- To the right -->
		<div class="float-right d-none d-sm-inline">PHP Laravel</div>
		<!-- Default to the left -->
		<strong>Copyright &copy; 2019 <a href="https://cubes.edu.rs">Cubes
				School</a>.
		</strong> All rights reserved.
	</footer>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED SCRIPTS -->

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