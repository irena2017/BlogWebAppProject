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
<title>Blog Post</title>
<meta name="description"
	content="blog, business, sports, food, travel, tips, tricks, entairtainment, music, dance, hits, latest, health, lifestyle">
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
			<!-- Post -->
			<main class="post blog-post col-lg-8">
				<div class="container">
					<div class="post-single">
						<c:forEach var="blog" items="${blogsByName}">
							<div class="post-thumbnail">
								<c:if test="${not empty blog.images}">
										<c:forEach var="image" items="${blog.images}">
											<img src="${image.imageUrl}" alt="..." class="img-fluid">
										</c:forEach>
									</c:if>
							</div>
							<div class="post-details">
								<div class="post-meta d-flex justify-content-between">
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
								<h1>${blog.name}
							<a href="blog-post?blogName=${blog.seoName}">
									</a>
								</h1>
								<div class="post-footer d-flex align-items-center flex-column flex-sm-row">
                                <a href="blog-author?authorUrl=${blog.user.seoName}"
									class="author d-flex align-items-center flex-wrap">
										<div class="avatar">
										<img src="${blog.user.image.imageUrl}" alt="Author Photo"
												class="img-fluid rounded-circle" style="width: 100%; height: 100%; object-fit: cover;">
										</div>
										<div class="title">
											<span>${blog.user.name} ${blog.user.surname}</span>
										</div>
									</a>
									<div class="d-flex align-items-center flex-wrap">
										<div class="date">
											<i class="icon-clock"></i>${blog.formattedDateMA}
										</div>
										<div class="views">
											<i class="icon-eye"></i>${blog.views}
										</div>
										<div class="comments meta-last">
											<a href="#post-comments"><i class="icon-comment"></i>${empty blog.comments ? 0 : blog.comments.size()}
											</a>
										</div>
									</div>
								</div>
								<div class="post-body">
									<p class="lead">${blog.description}</p>
									<p>${blog.text}</p>
						<a href="blog-post?blogName=${blog.seoName}"></a>
									<div class="post-tags">
										<ul class="list-inline">
											<c:forEach var="tag" items="${tagsByBlog}">
												<li class="list-inline-item"><a
													href="blog-tag?tagName=${tag.seoName}"
													class="tag">#${tag.name}</a></li>
											</c:forEach>
										</ul>
									</div>
									<div
										class="posts-nav d-flex justify-content-between align-items-stretch flex-column flex-md-row">
										<c:if test="${not empty previousPost}">
											<a href="blog-post?blogName=${previousPost.seoName}"
												class="prev-post text-left d-flex align-items-center">
												<div class="icon prev">
													<i class="fa fa-angle-left"></i>
												</div>
												<div class="text">
													<strong class="text-primary">Previous Post</strong>
													<h6 class="text-primary">${previousPost.name}</h6>
												</div>
											</a>
										</c:if>

										<c:if test="${not empty nextPost}">
											<a href="blog-post?blogName=${nextPost.seoName}"
												class="next-post text-right d-flex align-items-center justify-content-end">
												<div class="text">
													<strong class="text-primary">Next Post</strong>
													<h6 class="text-primary">${nextPost.name}</h6>
												</div>
												<div class="icon next">
													<i class="fa fa-angle-right"></i>
												</div>
											</a>
										</c:if>
									</div>

									<div class="post-comments" id="post-comments">
									<header>
										<h3 class="h6">
						Post Comments<span class="no-of-comments">(${empty numberOfComments ? 0 : numberOfComments})</span>
										</h3>
									</header>
						</c:forEach>
						<c:forEach items="${commentsByBlog}" var="comment">
							<c:if test="${comment.enabled}">
								<div class="comment">
									<div class="comment-header d-flex justify-content-between">
										<div class="user d-flex align-items-center">
											<div class="avatar">
												<img src="${comment.user.image.imageUrl}" alt="..."
													class="img-fluid rounded-circle"
													style="width: 100%; object-fit: cover;">
											</div>
											<div class="title">
			<strong>${comment.name}</strong> <span class="date">${comment.formattedDateMY}</span>
											</div>
										</div>
									</div>
									<div class="comment-body">
										<p>${comment.text}</p>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="add-comment">
					<header>
						<h3 class="h6">Leave a reply</h3>
					</header>
					<form:form modelAttribute="comment" method="post"
						action="comment-save" class="commenting-form" role="form">
						<form:hidden path="blog.id" />
						<div class="row">
							<div class="form-group col-md-6">
								<form:input path="name" placeholder="Name" class="form-control" />
							</div>
							<div class="form-group col-md-6">
								<form:input path="email"
									placeholder="Email address (will not be published)"
									class="form-control" />
							</div>
							<div class="form-group col-md-12">
								<form:textarea path="text" placeholder="Type your comment"
									class="form-control" rows="3" />
							</div>
							<div class="form-group col-md-12">
								<button type="submit" class="btn btn-secondary">Submit
									Comment</button>
							</div>
						</div>
					</form:form>
				</div>
			</main>
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
							<a
								href="blog-post?blogName=${blog.seoName}">
								<strong>${blog.name}</strong>
							</a>
							<div class="d-flex align-items-center">
								<div class="views">
									<i class="icon-eye"></i>${blog.views}
								</div>
								<div class="comments">${empty blog.comments ? 0 : blog.comments.size()}
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
					<li class="item d-flex justify-content-between"><c:choose>
							<c:when test="${category.name ne null}">
								<a
									href="blog-category?categoryName=${category.seoName}">
									${category.name}</a>
								<span>${countBlogsByCategory[category.name]}</span>
							</c:when>
							<c:otherwise>
                           Uncategorized
                        </c:otherwise>
						</c:choose></li>
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
					<li class="list-inline-item"><a
						href="blog-tag?tagName=${tag.seoName}" class="tag">#${tag.name}</a></li>
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
							<li><a href="loginPage">Login <form:form
										action="${pageContext.request.contextPath}/loginPage">
									</form:form>
							</a></li>
						</ul>
						<ul class="list-unstyled">
							<c:forEach var="category" items="${topFourCategories}">
								<li><a
									href="blog-category?categoryName=${category.seoName}">${category.name}</a>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="col-md-4">
					<c:forEach var="blog" items="${footerLatestBlogs}">
						<div class="latest-posts">
							<a
								href="blog-post?blogName=${blog.seoName}">
								<div class="post d-flex align-items-center">
									<div class="image">
										<c:if test="${not empty blog.images}">
										<c:forEach var="image" items="${blog.images}">
											<img src="${image.imageUrl}" alt="..." class="img-fluid">
										</c:forEach>
									</c:if>
									</div>
									<div class="title">
										<strong>${blog.name}</strong> <span class="date last-meta">${blog.formattedDateWithComma}</span>
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
						<p>
							Template By <a
								href="https://bootstrapious.com/p/bootstrap-carousel"
								class="text-white">Bootstrapious</a>
							<!-- Please do not remove the backlink to Bootstrap Temple unless you purchase 
an attribution-free license @ Bootstrap Temple or support us at 
http://bootstrapious.com/donate. It is part of the license conditions. Thanks for understanding :)                         -->
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
	<script src="https://kit.fontawesome.com/3b55cddae2.js"
		crossorigin="anonymous"></script>

</body>
</html>