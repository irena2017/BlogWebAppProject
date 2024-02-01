package blog.main.backend;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import blog.main.DAO.UserDAO;
import blog.main.DAO.BlogDAO;
import blog.main.DAO.CategoryDAO;
import blog.main.DAO.CommentDAO;
import blog.main.DAO.ImageDAO;
import blog.main.DAO.MessageDAO;
import blog.main.DAO.SlideDAO;
import blog.main.DAO.TagDAO;
import blog.main.entity.Blog;
import blog.main.entity.Category;
import blog.main.entity.ChangePassword;
import blog.main.entity.Comment;
import blog.main.entity.Const;
import blog.main.entity.Image;
import blog.main.entity.Message;
import blog.main.entity.Role;
import blog.main.entity.Slide;
import blog.main.entity.Tag;
import blog.main.entity.User;

@Controller
@RequestMapping("/administration")
public class AdministrationController {

	@Autowired
	private BlogDAO blogDAO;
	@Autowired
	private CategoryDAO categoryDAO;
	@Autowired
	private TagDAO tagDAO;
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private SlideDAO slideDAO;
	@Autowired
	private MessageDAO messageDAO;
	@Autowired
	private CommentDAO commentDAO;
	@Autowired
	private ImageDAO imageDAO;
	
	
//BLOG ---------------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping("/blog-list")
	public String getBlogList(@RequestParam(required = false) String blogQuery, @RequestParam(required = false) String status, 
			@RequestParam(required = false) String author, @RequestParam(defaultValue = "0") int categoryId, 
			@RequestParam(defaultValue = "0") int id, Principal principal, Model model) {

		boolean enabled = true;

		List<Blog> filteredBlogs = blogDAO.getBlogList();

		if (blogQuery != null && !blogQuery.isEmpty()) {
			filteredBlogs = filteredBlogs.stream()
					.filter(blog -> blog.getName().toLowerCase().contains(blogQuery.toLowerCase()))
					.collect(Collectors.toList());
		}

		if (status != null && !status.isEmpty() && !status.equals("all")) {
			boolean isEnabled = status.equals("enabled");
			filteredBlogs = filteredBlogs.stream().filter(blog -> isEnabled == blog.getEnabled())
					.collect(Collectors.toList());
		}

		if (author != null && !author.isEmpty()) {
			filteredBlogs = filteredBlogs.stream().filter(blog -> blog.getUser().getSeoName().equalsIgnoreCase(author))
					.collect(Collectors.toList());
		}

		if (categoryId != 0) {
			filteredBlogs = filteredBlogs.stream()
					.filter(blog -> (categoryId == -1 && blog.getCategory() == null)
							|| (blog.getCategory() != null && blog.getCategory().getId().equals(categoryId)))
					.collect(Collectors.toList());
		}

		List<Blog> blogsWithComments = new ArrayList<>();
		
	    for (Blog blog : filteredBlogs) {
	        blogsWithComments.add(blogDAO.getBlogWithComments(blog.getId()));
	    }

	    model.addAttribute("blogList", blogsWithComments);
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("categoryList", categoryDAO.getCategoryList());
		model.addAttribute("userList", userDAO.getUserList());
		model.addAttribute("status", blogDAO.getBlogsByStatus(enabled));
		model.addAttribute("filteredBlogs", filteredBlogs);

		return "blog-list";
	}

	@RequestMapping("/blog-form")
	public String getBlogForm(Model model, Principal principal) {

		Blog blog = new Blog();

		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));
		model.addAttribute("tagList", tagDAO.getTagList());
		model.addAttribute("blog", blog);
		model.addAttribute("categoryList", categoryDAO.getCategoryList());

		return "blog-form";
	}

	@RequestMapping("/blog-form-update")
	public String getBlogUpdateForm(@RequestParam int id, Principal principal, Model model) {

		Blog blog = blogDAO.getBlogWithTag(id);

		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));
		model.addAttribute("blog", blog);
		model.addAttribute("categoryList", categoryDAO.getCategoryList());
		model.addAttribute("tagList", tagDAO.getTagList());

		return "blog-form";
	}

	@RequestMapping("/blog-save")
	public String saveBlog(@RequestParam(required=false) List <Integer> tagIds, @RequestParam(required=false) MultipartFile[] fileImages,
		   @Valid @ModelAttribute Blog blog, BindingResult result, Principal principal, Model model) {

		if (result.hasErrors()) {
			model.addAttribute("categoryList", categoryDAO.getCategoryList());
			model.addAttribute("tagList", tagDAO.getTagList());
			model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
			model.addAttribute("messageList", messageDAO.getAllMessages());

			return "blog-form";
		}
		
		if (blog.getId() == 0) {
			blog.setDate(LocalDate.now());
		} 
		else {
			Blog existingBlog = blogDAO.getBlog(blog.getId());
			blog.setDate(existingBlog.getDate());
		}

		if (blog.getCategory().getId() == null) {
			blog.setCategory(null);
		} 
		else {
			Category category = categoryDAO.getCategory(blog.getCategory().getId());
			blog.setCategory(category);
		}
		
		User user = userDAO.getUser(principal.getName());
		     
		blog.setUser(user);
		blog.setEnabled(true);

        List<Tag> tags = tagDAO.getTagsById(tagIds);
		
		blog.setTags(tags);
		
		blogDAO.saveBlog(blog);
		
		if (fileImages != null && fileImages.length > 0) {
	        try {
	        	int id = blog.getId();
	            List<Image> savedImages = imageDAO.saveBlogImages(fileImages, id, blog);
	            blog.setImages(savedImages);
	            Image image = new Image();
	            image.setBlogs(Arrays.asList(blog)); 
	            for (Image image1 : savedImages) {
	    	        imageDAO.saveImage(image1);
	    	    }
	        } 
	        catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
		
		blogDAO.saveBlog(blog);
		
		return "redirect:/administration/blog-list";
    }

	@RequestMapping("/blog-delete")
	public String deleteBlog(@RequestParam int id, Blog blog) {
		
	    Path blogFolderPath = Paths.get(Const.FOLDER_PATH + "blog/" + blog.getId());
	    try {
	        Files.walk(blogFolderPath)
	             .sorted(Comparator.reverseOrder())
	             .map(Path::toFile)
	             .forEach(File::delete);
	    } 
	    catch (IOException e) {
	        e.printStackTrace();
	    }
	    
	    blogDAO.deleteBlog(id);

	    return "redirect:/administration/blog-list";
	}

	@RequestMapping("/blog-important")
	public String blogMarkAsImportant(@RequestParam int id) {

		blogDAO.markBlogImportant(id);

		return "redirect:/administration/blog-list";
	}

	@RequestMapping("/blog-enabled")
	public String blogEnabled(@RequestParam(required = false) int id) {

		blogDAO.getBlogEnabled(id);

		return "redirect:/administration/blog-list";
	}

//CATEGORY ------------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping("/category-list")
	public String getCategoryList(Model model, Principal principal) {

		List<Category> list = categoryDAO.getCategoryList();
		
		Collections.sort(list, Comparator.comparingInt(Category::getPosition));
		
		model.addAttribute("categoryList", list);
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "category-list";
	}

	@RequestMapping("/category-form")
	public String getCategoryForm(Principal principal, Model model) {

		Category category = new Category();

		model.addAttribute("category", category);
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "category-form";
	}

	@RequestMapping("/category-form-update")
	public String getCategoryUpdateForm(@RequestParam int id, Principal principal, Model model) {

		Category category = categoryDAO.getCategory(id);

		model.addAttribute("category", category);
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "category-form";
	}

	@RequestMapping("/update-category-order")
	public String updateCategoryOrder(@RequestParam int categoryId, @RequestParam String direction, 
			@RequestParam(defaultValue = "0") int newPosition) {
	   
		Category category = categoryDAO.getCategory(categoryId);

	    if (category != null) {

	        if ("up".equals(direction)) {
	            newPosition = category.getPosition() - 1;
	        } else if ("down".equals(direction)) {
	            newPosition = category.getPosition() + 1;
	        }
	        categoryDAO.updateCategoryOrder(category, direction, newPosition);
	    } 

	    categoryDAO.saveCategory(category);
	    
	    return "redirect:/administration/category-list";
	}

	@RequestMapping("/category-save")
	public String saveCategory(@RequestParam(required=false) MultipartFile fileImage,  @RequestParam(defaultValue ="0") int position,
			@Valid @ModelAttribute Category category, BindingResult result, Model model) throws IOException {

		if (result.hasErrors()) {
			return "category-form";
		}

		position = category.getPosition();
		
		if (position < 1) {
			model.addAttribute("error", "Position must be 1 or higher.");
			return "category-form";
		}	
		
		categoryDAO.saveCategory(category);
		
		if (fileImage != null) {
		int id = category.getId();
		Image image = new Image();
		String imageUrl = imageDAO.saveCategoryImage(fileImage, id, category);
        image.setFileName(fileImage.getOriginalFilename());
		image.setImageUrl(imageUrl);
		category.setImage(image);
		}
		categoryDAO.saveCategory(category);

		return "redirect:/administration/category-list";
	}

	@RequestMapping("/category-delete")
	public String deleteCategory(@RequestParam int id, Category category) {
		
		Path blogFolderPath = Paths.get(Const.FOLDER_PATH + "category/" + category.getId());
	    try {
	        Files.walk(blogFolderPath)
	             .sorted(Comparator.reverseOrder())
	             .map(Path::toFile)
	             .forEach(File::delete);
	    } 
	    catch (IOException e) {
	        e.printStackTrace();
	    }
	    
	   categoryDAO.deleteCategory(id);

		return "redirect:/administration/category-list";
	}

//TAG ------------------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping("/tag-list")
	public String getTagList(Principal principal, Model model) {

		List<Tag> list = tagDAO.getTagList();

		model.addAttribute("tagList", list);
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "tag-list";
	}

	@RequestMapping("/tag-form")
	public String getTagForm(Principal principal, Model model) {

		Tag tag = new Tag();

		model.addAttribute("tag", tag);
		model.addAttribute("tagList", tagDAO.getTagList());
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "tag-form";
	}

	@RequestMapping("/tag-save")
	public String saveTag(@ModelAttribute Tag tag) {

		tagDAO.saveTag(tag);

		return "redirect:/administration/tag-list";
	}

	@RequestMapping("/tag-form-update")
	public String updateTagForm(@RequestParam int id, Principal principal, Model model) {

		Tag tag = tagDAO.getTag(id);

		model.addAttribute("tag", tag);
		model.addAttribute("tagList", tagDAO.getTagList());
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "tag-form";
	}

	@RequestMapping("/tag-delete")
	public String deleteTag(@RequestParam int id) {

		tagDAO.deleteTag(id);

		return "redirect:/administration/tag-list";

	}

//USER------------------------------------------------------------------------------------------------------------------------------------------------
	
	@RequestMapping(value = "/user-list")
	public String getUserList(Principal principal, Model model) {
	   
		model.addAttribute("userList", userDAO.getUserList());
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));	
		
		return "user-list";	
	}
	 
	@RequestMapping("/user-form")
	public String getAuthorForm(Principal principal, Model model) {

		User user = new User();

		model.addAttribute("user", user);
		model.addAttribute("roles", userDAO.getRoles());
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "user-form";
	}

	@RequestMapping("/user-save")
	public String saveUser(@RequestParam(required=false) MultipartFile fileImage, @RequestParam(required=false) Role role, @Valid @ModelAttribute User user, BindingResult result, 
			Model model) throws IOException {
	    	
		if (result.hasErrors() || !userDAO.isPasswordComplex(user.getPassword())) {
		    if (!userDAO.isPasswordComplex(user.getPassword())) {
		        result.rejectValue("password", "password.complexity",
		            "Password needs to have must contain at least six characters, a number, "
		            + "an upper-case letter a lower-case letter and a special character.");
		    }

		    model.addAttribute("roles", userDAO.getRoles());
		    model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		    model.addAttribute("messageList", messageDAO.getAllMessages());

		    return "user-form";
		}
		
		if (userDAO.isUsernameTaken(user.getUsername())) {
		    result.rejectValue("username", "username.duplicate", "Username is already taken.");
		    
		    model.addAttribute("roles", userDAO.getRoles());
		    model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		    model.addAttribute("messageList", messageDAO.getAllMessages());
		    
		    return "user-form";
		}

	    user.setRole(role);
        
	    String passwordEncode = new BCryptPasswordEncoder().encode(user.getPassword());
		
		user.setPassword("{bcrypt}"+passwordEncode);
		
		if (fileImage != null) {
	        Image image = new Image();
	        String imageUrl = imageDAO.saveUserImage(fileImage, user);
	        image.setImageUrl(imageUrl);
	        image.setFileName(fileImage.getOriginalFilename());
	        user.setImage(image);
	    }
		
		user.setEnabled(true);
		userDAO.saveUser(user);
		
	    return "redirect:/administration/user-list";
	}

	@RequestMapping("/user-delete")
	public String deleteUser(@RequestParam String username, User user) {
		
		Path blogFolderPath = Paths.get(Const.FOLDER_PATH + "users/" + user.getUsername());
	    try {
	        Files.walk(blogFolderPath)
	             .sorted(Comparator.reverseOrder())
	             .map(Path::toFile)
	             .forEach(File::delete);
	    } 
	    catch (IOException e) {
	        e.printStackTrace();
	    }

		userDAO.deleteUser(username);

		return "redirect:/administration/user-list";
	}


	@RequestMapping("/user-edit-profile")
	public String getUserEditProfile(Principal principal, Model model) {

		User user = userDAO.getUser(principal.getName());

		model.addAttribute("user", user);
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "user-edit-profile";
	}
	
	@RequestMapping("/user-edit-profile-action")
    public String getUserEditProfileAction(@RequestParam(required=false) MultipartFile fileImage,  User user, Principal principal, Model model) 
		throws IOException {
		
		User existingUser = userDAO.getUser(principal.getName());
		
		if (fileImage != null) {
	        String imageUrl = imageDAO.saveUserImage(fileImage, existingUser);

	        Image existingImage = existingUser.getImage();

	        if (existingImage == null) {
	            existingImage = new Image();
	            existingUser.setImage(existingImage);
	        }

	        existingImage.setImageUrl(imageUrl);
	        
	        imageDAO.saveImage(existingImage);
	    }
		
		existingUser.setName(user.getName());
		existingUser.setSurname(user.getSurname());
		existingUser.setPhoneNumber(user.getPhoneNumber());
		existingUser.setEmail(user.getEmail());

		userDAO.saveUser(existingUser);

		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());

		return "redirect:/administration/user-list";
	}

	@RequestMapping("/user-change-password")
	public String getUserChangePassword(Principal principal, Model model) {

		User user = userDAO.getUser(principal.getName());

		model.addAttribute("user", user);
		model.addAttribute("changePassword", new ChangePassword());
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "user-change-password";
	}

	@RequestMapping("/user-change-password-action")
	public String getUserChangePasswordAction(@ModelAttribute @Valid ChangePassword changePassword,
			BindingResult result, Principal principal) {
		if (result.hasErrors()) {
			return "user-change-password";
		}

		if (!changePassword.getNewPassword().equals(changePassword.getConfirmPassword())) {
			result.rejectValue("confirmPassword", "password.mismatch",
					"Password and confirmation password don't match.");
			return "user-change-password";
		}

		if (changePassword.getOldPassword().equals(changePassword.getNewPassword())) {
			result.rejectValue("newPassword", "password.mismatch",
					"New password must be different from the old password.");
			return "user-change-password";
		}

		if (!userDAO.isPasswordComplex(changePassword.getNewPassword())) {
			result.rejectValue("newPassword", "password.complexity",
					"Password needs to have must contain at least six characters, a number, "
				            + "an upper-case letter a lower-case letter and a special character.");
			return "user-change-password";
		}

		User user = userDAO.getUser(principal.getName());
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		if (!encoder.matches(changePassword.getOldPassword(), user.getPassword().replace("{bcrypt}", ""))) {
			result.rejectValue("oldPassword", "password.mismatch", "Incorrect password.");
			return "user-change-password";
		}

		user.setPassword("{bcrypt}" + encoder.encode(changePassword.getNewPassword()));
		userDAO.saveUser(user);

		return "redirect: user-list";
	}

	@RequestMapping("/user-enable")
	public String userEnable(@RequestParam(required = false) String username) {

		userDAO.enableUser(username);

		return "redirect:user-list";
	}
	

//SLIDES---------------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping("/slide-list")
	public String getSlideList(Slide slide, Principal principal, Model model) {
		
		model.addAttribute("slideList", slideDAO.getSlideList());
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "slide-list";
	}

	@RequestMapping("/slide-enable")
	public String enableSlide(@RequestParam int id) {

		slideDAO.enableSlide(id);

		return "redirect:/administration/slide-list";
	}

	@RequestMapping("/slide-form")
	public String getSlideForm(Principal principal, Model model) {

		Slide slide = new Slide();

		model.addAttribute("slide", slide);
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "slide-form";

	}

	@RequestMapping("/slide-form-update")
	public String getSlideFormUpdate(@RequestParam(required=false) int id, Principal principal, Model model) {

		Slide slide = slideDAO.getSlide(id);

		model.addAttribute("slide", slide);
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "slide-form";
	}

	@RequestMapping("/slide-delete")
	public String deleteSlide(@RequestParam int id, Slide slide) {
			
			Path blogFolderPath = Paths.get(Const.FOLDER_PATH + "slide/" + slide.getId());
		    try {
		        Files.walk(blogFolderPath)
		             .sorted(Comparator.reverseOrder())
		             .map(Path::toFile)
		             .forEach(File::delete);
		    } 
		    catch (IOException e) {
		        e.printStackTrace();
		    }

		slideDAO.deleteSlide(id);

		return "redirect:/administration/slide-list";
	}

	@RequestMapping("/slide-save")
	public String saveSlide(@ModelAttribute Slide slide, Model model, @RequestParam(required=false) MultipartFile fileImage, 
			@RequestParam(defaultValue = "0") int position) throws IOException {
		
		position = slide.getPosition();
		
		if (position < 1) {
			model.addAttribute("error", "Position must be 1 or higher.");
			return "slide-form";
		}	
		
		slideDAO.saveSlide(slide);
		
		if (fileImage != null) {
		Image image = new Image();
		int id = slide.getId();
		String imageUrl = imageDAO.saveSlideImage(fileImage, id, slide);
        image.setFileName(fileImage.getOriginalFilename());
		image.setImageUrl(imageUrl);
		slide.setImage(image);
		}
		
		slideDAO.saveSlide(slide);
	
		return "redirect:/administration/slide-list";
	
	}

//MESSAGES------------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping("/message-list")
	public String getMessageList(Principal principal, Model model) {
		
		model.addAttribute("userList", userDAO.getUserList());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "message-list";
	}

	@RequestMapping("/message-read")
	public String getMarkMessageRead(@RequestParam int id) {

		Message m = messageDAO.getMessage(id);

		m.setIsRead(true);

		messageDAO.saveMessage(m);

		return "redirect:/administration/message-list";
	}

	@RequestMapping("/message-delete")
	public String deleteMessage(@RequestParam int id) {

		messageDAO.deleteMessage(id);

		return "redirect:/administration/message-list";

	}

//COMMENT--------------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping("/comment-list")
	public String getCommentList(@RequestParam(defaultValue = "0") int blogId, Principal principal, Model model) {

		Set<Comment> filteredComments = commentDAO.getCommentsByBlogId(blogId);

		Set<Comment> commentList = commentDAO.getCommentList();
		
		if (blogId != 0) {
	        filteredComments = commentList.stream()
	                .filter(comment -> comment.getBlog().getId() == blogId)
	                .collect(Collectors.toSet());
	    } else {
	        filteredComments = commentList;
	    }
		
		model.addAttribute("commentList", commentList);
		model.addAttribute("filteredComments", filteredComments);
		model.addAttribute("commentsByBlogs", commentDAO.getCommentsByBlogId(blogId));
		model.addAttribute("messagesCount", messageDAO.getUnreadMessagesCount());
		model.addAttribute("messageList", messageDAO.getAllMessages());
		model.addAttribute("principal", userDAO.getUser(principal.getName()));

		return "comment-list";

	}

	@RequestMapping("/comment-enable")
	public String enableComment(@RequestParam int id) {

		commentDAO.enableComments(id);

		return "redirect:/administration/comment-list";

	}

	@RequestMapping("/comment-search")
	public String searchComment(@RequestParam(defaultValue = "0") int blogId, @ModelAttribute Comment comment,
			Model model) {

		Set<Comment> comments = commentDAO.getCommentsByBlogId(blogId);

		model.addAttribute("commentsByBlogs", comments);
		model.addAttribute("commentList", commentDAO.getCommentList());

		return "comment-list";
	}
	
	
	
}