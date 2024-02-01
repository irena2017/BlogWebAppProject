package blog.main.front;

import java.util.Set;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import blog.main.DAO.BlogDAO;
import blog.main.DAO.CategoryDAO;
import blog.main.DAO.CommentDAO;
import blog.main.DAO.MessageDAO;
import blog.main.DAO.SlideDAO;
import blog.main.DAO.TagDAO;
import blog.main.DAO.UserDAO;
import blog.main.entity.Blog;
import blog.main.entity.Comment;
import blog.main.entity.Const;
import blog.main.entity.Message;
import blog.main.entity.User;
import blog.main.exception.NotFoundException;

@Controller
@RequestMapping("/")

public class FrontController {

	@Autowired
	private BlogDAO blogDAO;
	@Autowired
	private SlideDAO slideDAO;
	@Autowired
	private MessageDAO messageDAO;
	@Autowired
	private CategoryDAO categoryDAO;
	@Autowired
	private TagDAO tagDAO;
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private CommentDAO commentDAO;

	@RequestMapping({ "/", "/index-page" })
	public String getIndexPage(@RequestParam(required = false) String query, @RequestParam(defaultValue = "0") int position, 
			@RequestParam(defaultValue = "0") int maxResults, Model model) {

		model.addAttribute("blogs", blogDAO.getBlogList());
		model.addAttribute("introBlogs", blogDAO.getBlogsByImportance());
		model.addAttribute("searchResults", blogDAO.searchBlogs(query));
		model.addAttribute("mostPopularBlogs", blogDAO.getBlogsByViews());
		model.addAttribute("categories", categoryDAO.getCategoryListByOrder(position, maxResults));
		model.addAttribute("topFourCategories", categoryDAO.getCategoryListByOrder(position, 4));
		model.addAttribute("slides", slideDAO.getSlidesByPosition(position));
		model.addAttribute("latestBlogs", blogDAO.getLatestBlogs(12));
		model.addAttribute("footerLatestBlogs", blogDAO.getLatestBlogs(3));

		return "front/index-page";
	}

	@RequestMapping("/contact-form")
	public String getMessageForm(@RequestParam(required = false) String query, @RequestParam(defaultValue = "0") int position,
			@RequestParam(defaultValue = "0") int maxResults, Model model) {

		Message message = new Message();

		model.addAttribute("mostPopularBlogs", blogDAO.getBlogsByViews());
		model.addAttribute("searchResults", blogDAO.searchBlogs(query));
		model.addAttribute("message", message);
		model.addAttribute("categories", categoryDAO.getCategoryListByOrder(position, maxResults));
		model.addAttribute("topFourCategories", categoryDAO.getCategoryListByOrder(position, 4));
		model.addAttribute("footerLatestBlogs", blogDAO.getLatestBlogs(3));

		return "front/contact-form";
	}

	@RequestMapping("/message-save")
	public String saveMessage(Message message) {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {

			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			String username = userDetails.getUsername();
			User user = userDAO.getUser(username);

			if (user != null) {
				message.setUser(user);
			}

		messageDAO.saveMessage(message);
		}

		return "redirect: index-page";
	}

	@RequestMapping("/blog-section")
	public String getBlogSection(@RequestParam(required = false) String query, @RequestParam(defaultValue = "0") int position, 
			@RequestParam(defaultValue = "0") int maxResults, @RequestParam(defaultValue = "1") int page, Model model) {

		long totalBlogs = blogDAO.getBlogsNumber();
		int totalPages = (int) Math.ceil((double) totalBlogs / Const.BLOGS_PER_PAGE);

		int remainingBlogs = (int) (totalBlogs % Const.BLOGS_PER_PAGE);

		int maxBlogResults = Const.BLOGS_PER_PAGE;
		if (page == totalPages) {
			remainingBlogs = (int) (totalBlogs % Const.BLOGS_PER_PAGE);
			maxBlogResults = remainingBlogs;
		}

		model.addAttribute("searchResults", blogDAO.searchBlogs(query));
		model.addAttribute("latestBlogs", blogDAO.getLatestBlogs(maxBlogResults));
		model.addAttribute("mostPopularBlogs", blogDAO.getBlogsByViews());
		model.addAttribute("countBlogsByCategory", blogDAO.countBlogsByCategories());
		model.addAttribute("categories", categoryDAO.getCategoryListByOrder(0, 0));
		model.addAttribute("topFourCategories", categoryDAO.getCategoryListByOrder(0, 4));
		model.addAttribute("sortedTags", tagDAO.getSortedTags());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("remainingBlogs", remainingBlogs);
		model.addAttribute("pagesByBlog", blogDAO.getBlogsByPage(page));
		model.addAttribute("footerLatestBlogs", blogDAO.getLatestBlogs(3));

		return "front/blog-section";
	}

	@RequestMapping("/blog-search")
	public String search(@RequestParam String query, @RequestParam(defaultValue = "0") int position,
			@RequestParam(defaultValue = "0") int maxResults, Model model) {

		model.addAttribute("blogs", blogDAO.getBlogList());
		model.addAttribute("searchResults", blogDAO.searchBlogs(query));
		model.addAttribute("query", query);
		model.addAttribute("latestBlogs", blogDAO.getLatestBlogs(12));
		model.addAttribute("mostPopularBlogs", blogDAO.getBlogsByViews());
		model.addAttribute("countBlogsByCategory", blogDAO.countBlogsByCategories());
		model.addAttribute("categories", categoryDAO.getCategoryListByOrder(position, maxResults));
		model.addAttribute("topFourCategories", categoryDAO.getCategoryListByOrder(position, 4));
		model.addAttribute("sortedTags", tagDAO.getSortedTags());
		model.addAttribute("footerLatestBlogs", blogDAO.getLatestBlogs(3));

		return "front/blog-search";
	}

	@RequestMapping("/blog-category")
	public String getBlogsByCategory(@RequestParam(required = false) String query,
			@RequestParam(defaultValue = "0") String categoryName, @RequestParam(defaultValue = "0") int position,
			@RequestParam(defaultValue = "0") int maxResults, @RequestParam(defaultValue = "0") String tagName,
			Model model) {

		model.addAttribute("blogs", blogDAO.getBlogList());
		model.addAttribute("searchResults", blogDAO.searchBlogs(query));
		model.addAttribute("latestBlogs", blogDAO.getLatestBlogs(12));
		model.addAttribute("mostPopularBlogs", blogDAO.getBlogsByViews());
		model.addAttribute("countBlogsByCategory", blogDAO.countBlogsByCategories());
		model.addAttribute("categories", categoryDAO.getCategoryListByOrder(position, maxResults));
		model.addAttribute("topFourCategories", categoryDAO.getCategoryListByOrder(position, 4));
		model.addAttribute("blogsByCategory", blogDAO.getBlogsByCategory(categoryName));
		model.addAttribute("sortedTags", tagDAO.getSortedTags());
		model.addAttribute("blogsByTag", blogDAO.getBlogsByTag(tagName));
		model.addAttribute("footerLatestBlogs", blogDAO.getLatestBlogs(3));

		return "front/blog-category";
	}

	@RequestMapping("/blog-tag")
	public String getBlogsByTag(@RequestParam(required = false) String query,
			@RequestParam(required=false) String categoryName, @RequestParam(defaultValue = "0") int position,
			@RequestParam(defaultValue = "0") int maxResults, @RequestParam(required=false)String tagName,
			Model model) {

		model.addAttribute("blogs", blogDAO.getBlogList());
		model.addAttribute("searchResults", blogDAO.searchBlogs(query));
		model.addAttribute("latestBlogs", blogDAO.getLatestBlogs(12));
		model.addAttribute("mostPopularBlogs", blogDAO.getBlogsByViews());
		model.addAttribute("countBlogsByCategory", blogDAO.countBlogsByCategories());
		model.addAttribute("categories", categoryDAO.getCategoryListByOrder(position, maxResults));
		model.addAttribute("topFourCategories", categoryDAO.getCategoryListByOrder(position, 4));
		model.addAttribute("blogsByCategory", blogDAO.getBlogsByCategory(categoryName));
		model.addAttribute("sortedTags", tagDAO.getSortedTags());
		model.addAttribute("blogsByTag", blogDAO.getBlogsByTag(tagName));
		model.addAttribute("footerLatestBlogs", blogDAO.getLatestBlogs(3));

		return "front/blog-tag";
	}

	@RequestMapping("/blog-author")
	public String getBlogsByAuthor(@RequestParam(required = false) String query,
			@RequestParam(defaultValue = "0") String categoryName, @RequestParam(defaultValue = "0") int position,
			@RequestParam(defaultValue = "0") int maxResults, @RequestParam(defaultValue = "0") String tagName,
			@RequestParam(defaultValue = "0") String authorUrl, Model model) {

		model.addAttribute("blogs", blogDAO.getBlogList());
		model.addAttribute("searchResults", blogDAO.searchBlogs(query));
		model.addAttribute("latestBlogs", blogDAO.getLatestBlogs(12));
		model.addAttribute("mostPopularBlogs", blogDAO.getBlogsByViews());
		model.addAttribute("countBlogsByCategory", blogDAO.countBlogsByCategories());
		model.addAttribute("categories", categoryDAO.getCategoryListByOrder(position, maxResults));
		model.addAttribute("topFourCategories", categoryDAO.getCategoryListByOrder(position, 4));
		model.addAttribute("blogsByCategory", blogDAO.getBlogsByCategory(categoryName));
		model.addAttribute("sortedTags", tagDAO.getSortedTags());
		model.addAttribute("blogsByTag", blogDAO.getBlogsByTag(tagName));
		model.addAttribute("blogsByAuthor", blogDAO.getBlogsByAuthor(authorUrl));
		model.addAttribute("footerLatestBlogs", blogDAO.getLatestBlogs(3));

		return "front/blog-author";
	}

	@RequestMapping("/blog-post")
	public String getBlogPost(@RequestParam(required = false) String query,
			@RequestParam(defaultValue="0") int position, @RequestParam(defaultValue="0") int id,
			@RequestParam String blogName, Model model) {

		Blog blog = blogDAO.getBlogByName(blogName);
		
		if (blog == null) {
			return "redirect:/front/blog-post";
		}
		
		id = blog.getId();

		Comment comment = new Comment();
		comment.setBlog(blog);
		
		Set<Comment> commentList = commentDAO.getCommentsByBlogId(id);
		long enabledCommentCount = commentList.stream().filter(Comment::getEnabled).count();

		model.addAttribute("blogsByName", blogDAO.getBlogsByName(blogName));
		model.addAttribute("searchResults", blogDAO.searchBlogs(query));
		model.addAttribute("latestBlogs", blogDAO.getLatestBlogs(12));
		model.addAttribute("mostPopularBlogs", blogDAO.getBlogsByViews());
		model.addAttribute("countBlogsByCategory", blogDAO.countBlogsByCategories());
		model.addAttribute("categories", categoryDAO.getCategoryListByOrder(position, 0));
		model.addAttribute("topFourCategories", categoryDAO.getCategoryListByOrder(position, 4));
		model.addAttribute("sortedTags", tagDAO.getSortedTags());
		model.addAttribute("tagsByBlog", tagDAO.getTagsByBlog(id));
		model.addAttribute("previousPost", blogDAO.getPreviousPost(blogName));
		model.addAttribute("nextPost", blogDAO.getNextPost(blogName));
		model.addAttribute("commentsByBlog", commentDAO.getCommentsByBlogId(id));
		model.addAttribute("comment", comment);
		model.addAttribute("numberOfComments", enabledCommentCount);
		model.addAttribute("footerLatestBlogs", blogDAO.getLatestBlogs(3));

		return "front/blog-post";
	}

	@RequestMapping("/comment-save")
	public String getCommentForm(@RequestParam(required = false) String blogName, @ModelAttribute Comment comment, Blog blog) {

		comment.setEnabled(true);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication != null && authentication.isAuthenticated()) {
			String username = authentication.getName();
			User user;
			try {
				user = userDAO.getUser(username);
			} catch (NotFoundException e) {
				return "redirect:/loginPage";
			}
			if (user != null) {
			    comment.setUser(user);
			}
		}
			
		commentDAO.save(comment);
		
		blog = blogDAO.getBlog(comment.getBlog().getId());
		Set<Comment> comments = commentDAO.getCommentsByBlogId(blog.getId());

		blog.setComments(comments);
		blogDAO.saveBlog(blog);

		return "redirect:/blog-post?blogName=" + blog.getSeoName();
		
	} 
			
	

}