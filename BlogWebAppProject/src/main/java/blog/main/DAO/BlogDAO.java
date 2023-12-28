package blog.main.DAO;

import java.util.List;
import java.util.Map;


import blog.main.entity.Blog;

public interface BlogDAO {

	public List<Blog> getBlogList();

	public Blog getBlog(int id);

	public Blog getBlogByName(String blogName);

	public void saveBlog(Blog blog);

	public void deleteBlog(int id);

	public void markBlogImportant(int id);

	public void getBlogEnabled(int id);

	public List<Blog> getBlogsByImportance();

	public List<Blog> getLatestBlogs(int count);

	public List<Blog> searchBlogs(String query);

	public Map<String, Long> countBlogsByCategories();

	public List<Blog> getBlogsByCategory(String categoryName);

	public List<Blog> getBlogsByViews();

	public List<Blog> getBlogsByTag(String tagName);
	
	public Blog getBlogWithTag(int id);
	
	public List<Blog> getBlogListWithComments();

	public List<Blog> getBlogsByAuthor(String authorUrl);

	public List<Blog> getBlogsByName(String blogName);

	public List<Blog> getBlogSearch(String blogQuery);

	public List<Blog> getBlogsByStatus(boolean enabled);

	public List<Blog> getBlogSearchByCategory(int categoryId);

	public List<Blog> getBlogSearchByAuthor(String author);

	public Blog getPreviousPost(String blogName);

	public Blog getNextPost(String blogName);

	public List<Blog> getBlogsByPage(int page);

	public long getBlogsNumber();

	public Blog getBlogWithComments(int id);

}
