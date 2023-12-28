<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Blog</title>
<meta name="description" content="blog, business, sports, food, travel, tips, tricks, entairtainment, music, dance, hits, latest, health, lifestyle">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="all,follow">
<!-- Bootstrap CSS-->
<link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome CSS-->
<link rel="stylesheet"
	href="vendor/font-awesome/css/font-awesome.min.css">
<!-- Custom icon font-->
<link rel="stylesheet" href="css/fontastic.css">
<!-- Google fonts - Open Sans-->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
<!-- Fancybox-->
<link rel="stylesheet"
	href="vendor/@fancyapps/fancybox/jquery.fancybox.min.css">
<!-- theme stylesheet-->
<link rel="stylesheet" href="css/style.default.css"
	id="theme-stylesheet">
<!-- Custom stylesheet - for your changes-->
<link rel="stylesheet" href="css/custom.css">
<!-- Favicon-->
<link rel="shortcut icon" href="favicon.png">
<!-- Tweaks for older IEs-->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
</head>
<body>
	<header class="header">
		<!-- Main Navbar-->
		<nav class="navbar navbar-expand-lg">
			<div class="search-area">
				<div
					class="search-area-inner d-flex align-items-center justify-content-center">
					<div class="close-btn">
						<i class="icon-close"></i>
					</div>
					<div class="row d-flex justify-content-center">
						<div class="col-md-8">
							<form:form action="blog-search" class="search-form" method="GET">
								<div class="form-group">
									<input type="search" placeholder="What are you looking for?"
										name="query" />
									<button type="submit" class="submit">
										<i class="icon-search"></i>
									</button>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<!-- Navbar Brand -->
				<div
					class="navbar-header d-flex align-items-center justify-content-between">
					<!-- Navbar Brand -->
					<a href="index-page" class="navbar-brand">Blog</a>
					<!-- Toggle Button-->
					<button type="button" data-toggle="collapse"
						data-target="#navbarcollapse" aria-controls="navbarcollapse"
						aria-expanded="false" aria-label="Toggle navigation"
						class="navbar-toggler">
						<span></span><span></span><span></span>
					</button>
				</div>
				<!-- Navbar Menu -->
				<div id="navbarcollapse" class="collapse navbar-collapse">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a href="index-page" class="nav-link">Home</a>
						</li>
						<li class="nav-item"><a href="blog-section"
							class="nav-link active">Blog</a></li>
						<li class="nav-item"><a href="contact-form" class="nav-link">Contact</a>
						</li>
					</ul>
					<div class="navbar-text">
						<a href="blog-search" class="search-btn"><i
							class="icon-search-1"></i></a>
					</div>
				</div>
			</div>
		</nav>
	</header>
	<div class="container">
		<div class="row">
			<!-- Latest Posts -->
			<main class="posts-listing col-lg-8">
				<div class="container">
					<div class="row">
						<!-- post -->
						<c:forEach var="blog" items="${pagesByBlog}">
							<c:set var="category" value="${blog.category}" />
							<div class="post col-xl-6">
								<div class="post-thumbnail">
								 <a href="blog-post?blogName=${blog.seoName}">
								<c:if test="${not empty blog.images}">
										<c:forEach var="image" items="${blog.images}">
											<img src="${image.imageUrl}" alt="..." class="img-fluid">
										</c:forEach>
									</c:if>
								 </a>
								</div>
							<div class="post-details">
								<div class="post-meta d-flex justify-content-between">
									<div class="date meta-last">${blog.formattedDateMonth}</div>
									<div class="category"
										class="item d-flex justify-content-between">
										<c:choose>
											<c:when test="${blog.category.name ne null}">
									<a href="blog-category?categoryName=${blog.category.seoName}">
													${blog.category.name}</a>
											</c:when>
											<c:otherwise>
												<b style="color: #999;">UNCATEGORIZED</b>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<a href="blog-post?blogName=${blog.seoName}">
										<h3 class="h4">${blog.name}</h3>
									</a>
									<p class="text-muted">${blog.description}</p>
									<footer class="post-footer d-flex align-items-center">
										<a href="blog-author?authorUrl=${blog.user.seoName}"
											class="author d-flex align-items-center flex-wrap"> 
											<div class="avatar">
										<img src="${blog.user.image.imageUrl}" alt="Author Photo"
												class="img-fluid rounded-circle"
												style="width: 100%; height: 100%; object-fit: cover;">
										</div>
										</a>
										<div class="date">
											<i class="icon-clock"></i>${blog.formattedDateMA}</div>
										<div class="comments meta-last">
											<i class="icon-comment"></i>${empty blog.comments ? 0 : blog.comments.size()}</div>
									</footer>
								</div>
							</div>
						</c:forEach>
					</div>
					<nav aria-label="Page navigation example">
						<ul
							class="pagination pagination-template d-flex justify-content-center">
							<c:if test="${currentPage > 1}">
								<li class="page-item"><a class="page-link"
									href="?page=${currentPage - 1}" aria-label="Previous"> <span
										aria-hidden="true">&laquo;</span></a></li>
							</c:if>
							<c:forEach begin="1" end="${totalPages}" var="i">
								<c:choose>
									<c:when test="${currentPage == i}">
										<li class="page-item active"><span class="page-link">${i}</span></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link"
											href="?page=${i}">${i}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${currentPage < totalPages}">
								<li class="page-item"><a class="page-link"
									href="?page=${currentPage + 1}" aria-label="Next"><span
										aria-hidden="true">&raquo;</span> </a></li>
							</c:if>
						</ul>
					</nav></main>
			<!-- Widget [Search Bar Widget]-->
			<aside class="col-lg-4">
				<div class="widget search">
					<header>
						<h3 class="h6">Search the blog</h3>
					</header>
					<form:form action="blog-search" class="search-form" method="GET">
						<div class="form-group">
							<input type="search" placeholder="What are you looking for?"
								name="query" />
							<button type="submit" class="submit">
								<i class="icon-search"></i>
							</button>
						</div>
					</form:form>
				</div>

				<!-- Widget [Latest Posts Widget]        -->
				<div class="widget latest-posts">
					<header>
						<h3 class="h6">Latest Posts</h3>
					</header>
					<div class="blog-posts">
						<c:forEach var="blog" items="${mostPopularBlogs}">
							<div class="item d-flex align-items-center">
								<div class="image">
								<c:if test="${not empty blog.images}">
										<c:forEach var="image" items="${blog.images}">
											<img src="${image.imageUrl}" alt="..." class="img-fluid">
										</c:forEach>
									</c:if>
								</div>
								<div class="title">
						<a href="blog-post?blogName=${blog.seoName}">
										<strong>${blog.name}</strong>
									</a>
									<div class="d-flex align-items-center">
										<div class="views">
											<i class="icon-eye"></i>${blog.views}
										</div>
										<div class="comments">
											<i class="icon-comment"></i>${empty blog.comments ? 0 : blog.comments.size()}
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<!-- Widget [Categories Widget]-->
			<div class="widget categories">
				<header>
					<h3 class="h6">Categories</h3>
				</header>
				<ul class="list-inline">
					<c:forEach var="category" items="${categories}">
						<li class="item d-flex justify-content-between">
						<c:choose>
								<c:when test="${category.name ne null}">
							<a href="blog-category?categoryName=${category.seoName}">
										${category.name}</a><span>${countBlogsByCategory[category.name]}</span>
								</c:when>
								<c:otherwise>
                           Uncategorized
                        </c:otherwise>
							</c:choose>
							</li>
					</c:forEach>
				</ul>
			</div>
				<!-- Widget [Tags Cloud Widget]-->
				<div class="widget tags">
					<header>
						<h3 class="h6">Tags</h3>
					</header>
					<ul class="list-inline">
						<c:forEach var="tag" items="${sortedTags}">
							<li class="list-inline-item">
						<a href="blog-tag?tagName=${tag.seoName}" class="tag">#${tag.name}</a></li>
						</c:forEach>
					</ul>
				</div>
			</aside>
		</div>
	</div>
	<!-- Page Footer-->
	<footer class="main-footer">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<div class="logo">
						<h6 class="text-white">Blog</h6>
					</div>
					<div class="contact-details">
						<p>53 Broadway, Broklyn, NY 11249</p>
						<p>Phone: (020) 123 456 789</p>
						<p>
							Email: <a href="mailto:info@company.com">Info@Company.com</a>
						</p>
						<ul class="social-menu">
							<li class="list-inline-item"><a href="https://facebook.com"><i
									class="fa fa-facebook"></i></a></li>
							<li class="list-inline-item"><a href="https://twitter.com"><i
									class="fa-brands fa-x-twitter"></i></a></li>
							<li class="list-inline-item"><a href="https://instagram.com"><i
									class="fa fa-instagram"></i></a></li>
							<li class="list-inline-item"><a href="https://behance.com"><i
									class="fa fa-behance"></i></a></li>
							<li class="list-inline-item"><a href="https://pinterest.com"><i
									class="fa fa-pinterest"></i></a></li>
						</ul>
					</div>
				</div>
				<div class="col-md-4">
					<div class="menus d-flex">
						<ul class="list-unstyled">
							<li><a href="index-page">Home</a></li>
							<li><a href="blog-section">Blog</a></li>
							<li><a href="contact-form">Contact</a></li>
						    <li><a href="loginPage">Login
						<form:form
								action="${pageContext.request.contextPath}/loginPage">
							</form:form>
						</a>
						</li>
						</ul>
						<ul class="list-unstyled">
						<c:forEach var="category" items="${topFourCategories}">
							<li>
							<a href="blog-category?categoryName=${category.seoName}">${category.name}</a>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="col-md-4">
				<c:forEach var="blog" items="${footerLatestBlogs}">
					<div class="latest-posts">
						<a href="blog-post?blogName=${blog.seoName}">
						<div class="post d-flex align-items-center">
								<div class="image">
								<c:if test="${not empty blog.images}">
										<c:forEach var="image" items="${blog.images}">
											<img src="${image.imageUrl}" alt="..." class="img-fluid">
										</c:forEach>
									</c:if>
									</div>
								<div class="title">
									<strong>${blog.name}</strong>
									<span class="date last-meta">${blog.formattedDateWithComma}</span>
								</div>
								</div>
								</a>
								</div>
								</c:forEach>
							</div>
					</div>
				</div>
		<div class="copyrights">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<p>&copy; 2017. All rights reserved. Blog.</p>
					</div>
					<div class="col-md-6 text-right">
						<p> Template By <a
								href="https://bootstrapious.com/p/bootstrap-carousel"
								class="text-white">Bootstrapious</a>
<!-- Please do not remove the backlink to Bootstrap Temple unless you purchase 
an attribution-free license @ Bootstrap Temple or support us at 
http://bootstrapious.com/donate. It is part of the license conditions. Thanks for understanding :) -->
						</p>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- JavaScript files-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/popper.js/umd/popper.min.js">
		
	</script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="vendor/jquery.cookie/jquery.cookie.js">
		
	</script>
	<script src="vendor/@fancyapps/fancybox/jquery.fancybox.min.js"></script>
	<script src="js/front.js"></script>
	<script src="https://kit.fontawesome.com/3b55cddae2.js" crossorigin="anonymous"></script>
</body>
</html>