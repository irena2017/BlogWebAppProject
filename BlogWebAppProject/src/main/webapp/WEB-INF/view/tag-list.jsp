<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">

<title>Tag List</title>

<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/adminlte.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
<!-- Google Font: Source Sans Pro -->
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700"
	rel="stylesheet">
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
			<a href="https://cubes.edu.rs/" class="brand-link"> <img
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
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="blog-list" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Blogs List</p>
								</a></li>
								<li class="nav-item"><a href="blog-form" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Add Blog</p>
								</a></li>
							</ul> <sec:authorize access="hasRole('admin')">
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
										<li class="nav-item"><a href="category-form"
											class="nav-link"> <i class="far fa-circle nav-icon"></i>
												<p>Add Category</p>
										</a></li>
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
								<li class="nav-item"><a href="tag-form" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Add Tag</p>
								</a></li>
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
								<li class="nav-item"><a href="slide-form" class="nav-link">
										<i class="far fa-circle nav-icon"></i>
										<p>Add Slide</p>
								</a></li>
							</ul></li>
					</ul>
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<li class="nav-item has-treeview"><a href="user-list"
							class="nav-link"> <i class="nav-icon far fa-plus-square"></i>
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
							</ul></li>
					</ul>
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<li class="nav-item has-treeview"><a href="message-list"
							class="nav-link"> <i class="nav-icon far fa-plus-square"></i>
								<p>
									Messages<i class="right fas fa-angle-left"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="message-list"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>Messages List</p>
								</a></li>
							</ul></li>
					</ul>
					<ul class="nav nav-pills nav-sidebar flex-column"
						data-widget="treeview" role="menu" data-accordion="false">
						<li class="nav-item has-treeview"><a href="comment-list"
							class="nav-link"> <i class="nav-icon far fa-plus-square"></i>
								<p>
									Comments<i class="right fas fa-angle-left"></i>
								</p>
						</a>
							<ul class="nav nav-treeview">
								<li class="nav-item"><a href="comment-list"
									class="nav-link"> <i class="far fa-circle nav-icon"></i>
										<p>Comment List</p>
								</a></li>
							</ul></li>
					</ul>
					</sec:authorize>
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
							<h1>Tags</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index-page">Home</a></li>
								<li class="breadcrumb-item active">Tags List</li>
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
							<div class="card">
								<div class="card-header">
									<h3 class="card-title">All Tags</h3>
									<div class="card-tools">
										<a href="tag-form" class="btn btn-success"> <i
											class="fas fa-plus-square"></i> Add new Tag
										</a>
									</div>
								</div>
								<!-- /.card-header -->
								<div class="card-body">
									<table class="table table-bordered">
										<thead>
											<tr>
												<th class="text-center" style="width: 10px">#</th>
												<th class="text-center">Name</th>
												<th class="text-center">Actions</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="tag" items="${tagList}">
												<tr>
												    <th class="text-center">${tag.id}</th>
													<td class="text-center" ><strong>${tag.name}</strong></td>
													<td class="text-center">
														<div class="btn-group">
															<a href="tag-form-update?id=${tag.id}"
																class="btn btn-info"> <i class="fas fa-edit"></i>
															</a>
															<button type="button" class="btn btn-info"
																data-toggle="modal"
																data-target="#delete-modal-${tag.id}">
																<i class="fas fa-trash"></i>
															</button>
														</div>
													</td>
												</tr>

												<div class="modal fade" id="delete-modal-${tag.id}">
													<div class="modal-dialog">
														<div class="modal-content">
															<div class="modal-header">
																<h4 class="modal-title">Delete Tag</h4>
																<button type="button" class="close" data-dismiss="modal"
																	aria-label="Close">
																	<span aria-hidden="true">&times;</span>
																</button>
															</div>
															<div class="modal-body">
																<p>Are you sure you want to delete tag?</p>
																<strong></strong>
															</div>
															<div class="modal-footer justify-content-between">
																<button type="button" class="btn btn-default"
																	data-dismiss="modal">Cancel</button>
																<a href="tag-delete?id=${tag.id}" class="btn btn-danger">Delete</a>

															</div>
														</div>
														<!-- /.modal-content -->
													</div>
													<!-- /.modal-dialog -->
												</div>
												<!-- /.modal -->
											</c:forEach>
										</tbody>
									</table>
								</div>
								<!-- /.card-body -->
								<div class="card-footer clearfix"></div>
							</div>
							<!-- /.card -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
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
				<strong>Copyright &copy; 2019 <a
					href="https://cubes.edu.rs">Cubes School</a>.
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