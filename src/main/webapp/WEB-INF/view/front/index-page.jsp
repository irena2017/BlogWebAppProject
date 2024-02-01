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
<title>Blog Index Page</title>
<meta name="description" content="blog, health, fitness, sports, business, food, latest">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="all,follow">
<!-- Font Awesome CSS-->
<link rel="stylesheet"
	href="vendor/font-awesome/css/font-awesome.min.css">
<!-- Bootstrap CSS-->
<link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
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
<!-- owl carousel 2 stylesheet-->
<link rel="stylesheet"
	href="plugins/owl-carousel2/assets/owl.carousel.min.css"
	id="theme-stylesheet">
<link rel="stylesheet"
	href="plugins/owl-carousel2/assets/owl.theme.default.min.css"
	id="theme-stylesheet">
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
						<li class="nav-item"><a href="index-page"
							class="nav-link active">Home</a></li>
						<li class="nav-item"><a href="blog-section" class="nav-link">Blog</a>
						</li>
						<li class="nav-item"><a href="contact-form" class="nav-link">Contact</a>
						</li>
					</ul>
					<div class="navbar-text">
						<a href="#" class="search-btn"><i class="icon-search-1"></i></a>
					</div>
				</div>
			</div>
		</nav>
	</header>

	<!-- Hero Section-->

	<div id="index-slider" class="owl-carousel">
		<c:forEach var="slide" items="${slides}">
			<c:if test="${slide.enabled eq true}">
				<section class="hero"
					style="background: url('${not empty slide.image ? slide.image.imageUrl : ''}');
    background-size: cover; background-position: center center;">
					<div class="container">
						<div class="row">
							<div class="col-lg-7">
								<h1>${slide.name}</h1>
								<a href="${slide.buttonUrl}" class="hero-link">${slide.buttonName}</a>
							</div>
						</div>
					</div>
				</section>
			</c:if>
		</c:forEach>
	</div>

	<!-- Intro Section-->
 <section class="intro">
      <div class="container">
        <div class="row">
          <div class="col-lg-8">
            <h2 class="h3">Welcome to Our Blog</h2>
           <p class="text-big">Here you can find <strong>latest blogs</strong>
           on various topics such as <strong> health, sports and business</strong>.</p>
          </div>
        </div>
      </div>
    </section>
	<section class="featured-posts no-padding-top">
		<div class="container">
			<c:forEach var="blog" items="${introBlogs}" varStatus="loopStatus">
				<div class="row d-flex align-items-stretch">
					<c:choose>
						<c:when test="${loopStatus.index % 2 != 0}">
							<div class="image col-lg-5">
								<a href="blog-post?blogName=${blog.seoName}"> <c:if
										test="${not empty blog.images}">
										<c:forEach var="image" items="${blog.images}">
											<img src="${image.imageUrl}" alt="..." class="img-fluid">
										</c:forEach>
									</c:if>
								</a>
							</div>
							<div class="text col-lg-7">
								<div class="text-inner d-flex align-items-center">
									<div class="content">
										<header class="post-header">
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
		                            <a href="blog-post?blogName=${blog.seoName}">
												<h2 class="h4">${blog.name}</h2>
											</a>
										</header>
										<p>${blog.description}</p>
										<footer class="post-footer d-flex align-items-center">
                                     <a href="blog-author?authorUrl=${blog.user.seoName}"
												class="author d-flex align-items-center flex-wrap">
												<div class="avatar">
													<img src="${blog.user.image.imageUrl}" alt="Author Photo"
														class="img-fluid rounded-circle"
														style="width: 100%; height: 100%; object-fit: cover;">
												</div>
												<div class="title">
													<span>${blog.user.name} ${blog.user.surname}</span>
												</div>
											</a>
											<div class="date">
												<i class="icon-clock"></i>${blog.formattedDateMA}
											</div>
											<div class="comments meta-last">
												<i class="icon-comment"></i>${empty blog.comments ? 0 : blog.comments.size()}
											</div>
										</footer>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="text col-lg-7">
								<div class="text-inner d-flex align-items-center">
									<div class="content">
										<header class="post-header">
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
				            <a href="blog-post?blogName=${blog.seoName}">
												<h2 class="h4">${blog.name}</h2>
											</a>
										</header>
										<p>${blog.description}</p>
							<footer class="post-footer d-flex align-items-center">
                             <a href="blog-author?authorUrl=${blog.user.seoName}"
									class="author d-flex align-items-center flex-wrap">
									<div class="avatar">
										<img src="${blog.user.image.imageUrl}" alt="Author Photo"
											class="img-fluid rounded-circle"
											style="width: 100%; height: 100%; object-fit: cover;">
									</div>
									<div class="title">
										<span>${blog.user.name} ${blog.user.surname}</span>
									</div>
											</a>
											<div class="date">
												<i class="icon-clock"></i>${blog.formattedDateMA}
											</div>
											<div class="comments meta-last">
												<i class="icon-comment"></i>${empty blog.comments ? 0 : blog.comments.size()}
											</div>
										</footer>
									</div>
								</div>
							</div>
							<div class="image col-lg-5">
							<a href="blog-post?blogName=${blog.seoName}"> <c:if
										test="${not empty blog.images}">
										<c:forEach var="image" items="${blog.images}">
											<img src="${image.imageUrl}" alt="..." class="img-fluid">
										</c:forEach>
									</c:if>
								</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</c:forEach>
		</div>
	</section>

	<!-- Divider Section-->
	<section
		style="background: url(img/divider-bg.jpg); background-size: cover; background-position: center bottom"
		class="divider">
		<div class="container">
			<div class="row">
				<div class="col-md-7">
					<h2>Meet our team of imaginative and experienced writers. We are creatives who make amazing projects.</h2>
					<a href="contact-form" class="hero-link">Contact Us</a>
				</div>
			</div>
		</div>
	</section>

	<!-- Latest Posts -->
	<section class="latest-posts">
		<div class="container">
			<header>
				<h2>Latest from the blog</h2>
				<p class="text-big">
					<i>Latest 12 blogs on our website.</i>
				</p>
			</header>
			<div class="owl-carousel" id="latest-posts-slider">
				<c:forEach var="blog" items="${latestBlogs}">
					<div class="row">
						<div class="post col md-4">
							<div class="post-thumbnail">
								<a href="blog-post?blogName=${blog.seoName}"> <c:if
										test="${not empty blog.images}">
										<c:forEach var="image" items="${blog.images}">
											<img src="${image.imageUrl}" alt="..." class="img-fluid">
										</c:forEach>
									</c:if>
								</a>
							</div>
							<div class="post-details">
								<div class="post-meta d-flex justify-content-between">
									<div class="date">${blog.formattedDateMonth}</div>
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
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<!-- Page Footer-->
	<footer class="main-footer">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<div class="logo">
						<h6 class="text-white">Bootstrap Blog</h6>
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
										<a href="blog-post?blogName=${blog.seoName}"> <c:if
												test="${not empty blog.images}">
												<c:forEach var="image" items="${blog.images}">
													<img src="${image.imageUrl}" alt="..." class="img-fluid">
												</c:forEach>
											</c:if>
										</a>
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
						<p>&copy; 2017. All rights reserved. Your great site.</p>
					</div>
					<div class="col-md-6 text-right">
						<p> Template By <a
								href="https://bootstrapious.com/p/bootstrap-carousel"
								class="text-white">Bootstrapious</a>
							<!-- Please do not remove the backlink to Bootstrap Temple unless you purchase an attribution-free 
							license @ Bootstrap Temple or support us at http://bootstrapious.com/donate. 
							It is part of the license conditions. Thanks for understanding :)                         -->
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
	<script src="plugins/owl-carousel2/owl.carousel.min.js"></script>
	<script src="https://kit.fontawesome.com/3b55cddae2.js" crossorigin="anonymous"></script>
	<script>
		$("#index-slider").owlCarousel({
			"items" : 1,
			"loop" : true,
			"autoplay" : true,
			"autoplayTimeout" : 3000,
			"autoplayHoverPause" : true
		});

		$("#latest-posts-slider").owlCarousel({
			"items" : 3,
			"loop" : true,
			"autoplay" : true,
			"autoplayTimeout" : 3000,
			"autoplayHoverPause" : true,
			"margin": 30
		});
	</script>
</body>
</html>