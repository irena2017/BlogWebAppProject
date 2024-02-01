<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--<c:set var="status" value="${param.status}" />
<c:set var="blogQuery" value="${param.blogQuery}" />
<c:set var="categoryId" value="${param.categoryId}" />
<c:set var="author" value="${param.author}" />-->
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

<title>Blog List</title>

<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/adminlte.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/custom.css">
<!-- Google Font: Source Sans Pro -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700"
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
					<li class="nav-item dropdown"><a class="nav-link"
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
											<h3 class="dropdown-item-title">${message.user.name}
												${message.user.surname}</h3>
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
							<h1>Blogs</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index-page">Home</a></li>
								<li class="breadcrumb-item active">Blogs</li>
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
									<h3 class="card-title">Search Blogs</h3>
									<div class="card-tools">
										<a href="blog-form" class="btn btn-success"> <i
											class="fas fa-plus-square"></i> Add New Blog
										</a>
									</div>
								</div>
								<!-- /.card-header -->
								<sec:authorize access="hasRole('admin')">
								<div class="card-body">
									<div class="form-row">
										<form:form
											action="${pageContext.request.contextPath}/administration/blog-list"
											method="GET">
											<label>Search</label>
											<div class="input-group">
												<input type="search" placeholder="Search blogs by title"
													name="blogQuery" class="form-control" />
												<div class="input-group-append">
													<button type="submit"
														class="btn ml-2 fa-solid fa-magnifying-glass"></button>
												</div>
											</div>
										</form:form>
										<form:form
											action="${pageContext.request.contextPath}/administration/blog-list"
											method="GET">
											<label>All Categories</label>
											<div class="input-group">
											<select name="categoryId" class="form-control">
											   <option value ="-1">Uncategorized</option>
												<c:forEach var="category" items="${categoryList}">
													<option value="${category.id}">${category.name}</option>
												</c:forEach>
											</select>
											<div class="input-group-append">
													<button type="submit"
														class="btn ml-2 fas fa-filter"></button>
												</div>
											</div>
										</form:form>
											<form:form
												action="${pageContext.request.contextPath}/administration/blog-list"
												method="GET">
												<label>All Authors</label>
												<div class="input-group">
													<select name="author" class="form-control">
														<option value="">All Authors</option>
														<c:forEach var="user" items="${userList}">
															<option value="${user.seoName}">${user.name}
																${user.surname}</option>
														</c:forEach>
													</select>
													<div class="input-group-append">
														<button type="submit" class="btn ml-2 fas fa-filter"></button>
													</div>
												</div>
											</form:form>
											<form:form
											action="${pageContext.request.contextPath}/administration/blog-list"
											method="GET">
											<label>Status</label>
											<div class="input-group">
												<select name="status" class="form-control">
													<option value="all">---All---</option>
													<option value="enabled">Enabled</option>
													<option value="disabled">Disabled</option>
												</select>
												<div class="input-group-append">
													<button type="submit" class="btn ml-2 fas fa-filter">
													</button>
												</div>
											</div>
										</form:form>
									</div>
								</div>
								</sec:authorize>
								<div class="card-footer clearfix"></div>
                               </div>
                              <div class="card">
                         <div class="card-header">
                <h3 class="card-title">All Blogs</h3>
                         </div>
         <div class="card-body">
         <table class="table table-bordered">
            <thead>
                <tr>
                    <th class="text-center">#</th>
                    <th class="text-center">Photos</th>
                    <th class="text-center">Date</th>
                    <th class="text-center">Category</th>
                    <th class="text-center">Name</th>
                    <th class="text-center">Author</th>
                    <th class="text-center">Comments</th>
                    <th class="text-center">Views</th>
                    <th class="text-center">Actions</th>
                </tr>
            </thead>
            <tbody>
             <c:forEach var="blog" items="${filteredBlogs}">
<c:choose>
<c:when
	test="${blog.user.username eq pageContext.request.userPrincipal.name || pageContext.request.isUserInRole('admin')}">
	<c:choose>
		<c:when
			test="${status == null || (status == 'all') || (status == 'enabled' && blog.enabled) || (status == 'disabled' && !blog.enabled)}">
			<c:choose>
				<c:when
					test="${empty param.blogQuery || fn:contains(blog.seoName, param.blogQuery)}">
					<c:choose>
						<c:when
							test="${empty param.category || blog.category.id == param.categoryId}">
							<c:choose>
								<c:when
									test="${empty param.author || blog.user.seoName == author}">
									<tr>
										<td class="text-center">${blog.id}</td>
										<td class="text-center">
										<c:forEach var="image" items="${blog.images}">
										<img src="${image.imageUrl}" style="max-width: 80px;">
										</c:forEach>
											</td>
										<td class="text-center">${blog.date}</td>
								        <td class="text-center">${blog.category != null ? blog.category.name : 'Uncategorized'}</td>
										<td class="text-center"><strong>${blog.name}</strong></td>
										<td class="text-center">${blog.user.name}
											${blog.user.surname}</td>
										<td class="text-center">${empty blog.comments ? 0 : blog.comments.size()}</td>
										<td class="text-center">${blog.views}</td>
										<td class="text-center">
											<div class="btn-group">
												<a href="blog-form-update?id=${blog.id}"
													class="btn btn-info"> <i
													class="fas fa-edit"></i></a> 
													<a href="blog-enabled?id=${blog.id}"
													class="btn btn-info"> <c:if
														test="${blog.enabled}">
														<i class="fas fa-eye"></i>
													</c:if> 
													<c:if test="${!blog.enabled}">
														<i class="fas fa-eye-slash"></i>
													</c:if></a> 
													<a href="blog-important?id=${blog.id}"
													class="btn btn-info"> <c:if
														test="${blog.important}">
														<i class="fas fa-star"
															style="color: #ffd31d;"></i>
													</c:if> 
													<c:if test="${!blog.important}">
														<i class="fas fa-star"></i>
													</c:if></a>
												<button type="button" class="btn btn-info"
													data-toggle="modal"
													data-target="#delete-modal-${blog.id}">
													<i class="fas fa-trash"></i>
												</button>
											</div>
											<div class="modal fade"
												id="delete-modal-${blog.id}">
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<h4 class="modal-title">Delete Blog
																Post</h4>
															<button type="button" class="close"
																data-dismiss="modal" aria-label="Close">
																<span aria-hidden="true">&times;</span>
															</button>
														</div>
														<div class="modal-body">
															<p>Are you sure you want to delete blog?</p>
															<strong></strong>
														</div>
														<div
															class="modal-footer justify-content-between">
															<button type="button"
																class="btn btn-default"
																data-dismiss="modal">Cancel</button>
															<a href="blog-delete?id=${blog.id}"
																class="btn btn-danger">Delete</a>
																</div>
																	</div>
																	   </div>
																		</div>
																		</td>
																	</tr>
																</c:when>
															</c:choose>
														</c:when>
													</c:choose>
												</c:when>
											</c:choose>
										</c:when>
									</c:choose>
								</c:when>
							</c:choose>
						</c:forEach>
			            </tbody>
			        </table>
			    </div>
			<!-- /.content-wrapper -->
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
<div class="card-footer clearfix">
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
			<script src="https://kit.fontawesome.com/3b55cddae2.js"
				crossorigin="anonymous"></script>
</body>
</html>