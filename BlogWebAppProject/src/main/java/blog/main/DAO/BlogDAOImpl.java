package blog.main.DAO;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import blog.main.entity.Blog;
import blog.main.entity.Const;
import blog.main.entity.Image;

@Repository
public class BlogDAOImpl implements BlogDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Transactional
	@Override
	public List<Blog> getBlogList() {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery("from Blog", Blog.class);

		List<Blog> blogs = query.getResultList();

		return blogs;
	}

	@Transactional
	@Override
	public Blog getBlog(int id) {

		Session session = sessionFactory.getCurrentSession();

		Blog b = session.get(Blog.class, id);

		return b;
	}

	@Transactional
	@Override
	public Blog getBlogByName(String blogName) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery(
				"SELECT DISTINCT blog FROM Blog blog WHERE LOWER(REPLACE(blog.name, ' ', '-')) LIKE :blogName AND blog.enabled = true",
				Blog.class);
		query.setParameter("blogName", "%" + blogName + "%");

		List<Blog> resultList = query.getResultList();

		if (resultList.isEmpty()) {
			return null;
		} 
		else {
			return resultList.get(0);
		}
	}

	@Transactional
	@Override
	public void saveBlog(Blog blog) {
		Session session = sessionFactory.getCurrentSession();
	
		session.saveOrUpdate(blog);
	}

	@Transactional
	@Override
	public void deleteBlog(int id) {
		Session session = sessionFactory.getCurrentSession();
		
		Blog blog = session.get(Blog.class, id);

		if (blog != null) {
		   List<Image> images = blog.getImages();

		  for (Image image : images) {
		   try {
			   Path imagePath = Paths.get(Const.FOLDER_PATH + "blog/" + image.getBlogs().get(0).getId() + File.separator + image.getFileName());
			   String imageUrl = imagePath.toString();
		                Files.deleteIfExists(Paths.get(imageUrl));
		            } catch (IOException e) {
		                e.printStackTrace();
		            }

		            session.delete(image);
		        }

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

        session.delete(blog);
		}
	}

	@Transactional
	@Override
	public void markBlogImportant(int id) {

		Session session = sessionFactory.getCurrentSession();

		Blog blog = session.get(Blog.class, id);

		blog.setImportant(!blog.getImportant());

		session.saveOrUpdate(blog);
	}

	@Transactional
	@Override
	public void getBlogEnabled(int id) {

		Session session = sessionFactory.getCurrentSession();

		Blog blog = session.get(Blog.class, id);

		blog.setEnabled(!blog.getEnabled());

		session.saveOrUpdate(blog);
	}

	@Transactional
	@Override
	public List<Blog> getBlogsByImportance() {

		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery(
				"SELECT DISTINCT blog FROM Blog blog WHERE blog.important = 1 AND blog.enabled = true ORDER BY blog.date DESC",
				Blog.class);
		query.setMaxResults(3);

		List<Blog> blogListByImportance = query.getResultList();

		return blogListByImportance;
	}

	@Transactional
	@Override
	public List<Blog> getLatestBlogs(int count) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery("from Blog blog WHERE blog.enabled = true ORDER BY blog.date DESC", Blog.class);
		query.setMaxResults(count);

		List<Blog> latestBlogs = query.getResultList();

		for (Blog blog : latestBlogs) {
			Hibernate.initialize(blog.getCategory());
		}

		return latestBlogs;
	}

	@Transactional
	@Override
	public List<Blog> searchBlogs(String query) {

		Session session = sessionFactory.getCurrentSession();

		Query<Blog> typedQuery = session.createQuery(
"SELECT blog FROM Blog blog WHERE blog.enabled = true AND (blog.name LIKE :query OR blog.text LIKE :query OR blog.description LIKE :query)",
				Blog.class);

		typedQuery.setParameter("query", "%" + query + "%");

		return typedQuery.getResultList();

	}

	@Transactional
	@Override
	public List<Blog> getBlogsByViews() {
		Session session = sessionFactory.getCurrentSession();

		LocalDate lastMonthDate = LocalDate.now().minusMonths(1);

		Query<Blog> query = session.createQuery(
				"FROM Blog blog WHERE blog.enabled = true AND (blog.date >= :lastMonthDate) ORDER BY blog.views DESC",
				Blog.class);
		query.setParameter("lastMonthDate", lastMonthDate);
		query.setMaxResults(3);

		List<Blog> mostPopularBlogs = query.getResultList();

		return mostPopularBlogs;
	}

	@Transactional
	@Override
	public Map<String, Long> countBlogsByCategories() {
		Session session = sessionFactory.getCurrentSession();

		Query<Object[]> query = session.createQuery(
				"SELECT category.name, COUNT(b) FROM Blog b JOIN b.category category WHERE b.enabled = true GROUP BY category.name",
				Object[].class);

		List<Object[]> results = query.getResultList();

		Map<String, Long> blogCountsByCategory = new HashMap<>();

		for (Object[] result : results) {

			String categoryName = (String) result[0];
			Long blogCount = (Long) result[1];
			blogCountsByCategory.put(categoryName, blogCount);
		}
		return blogCountsByCategory;
	}

	@Transactional
	@Override
	public List<Blog> getBlogsByCategory(String categoryName) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery(
				"SELECT DISTINCT b FROM Blog b JOIN b.category c WHERE LOWER(REPLACE(c.name, ' ', '-')) LIKE :categoryName AND b.enabled = true",
				Blog.class);
		query.setParameter("categoryName", "%" + categoryName + "%");

		List<Blog> blogsByCategory = query.getResultList();

		return blogsByCategory;
	}

	@Transactional
	@Override
	public List<Blog> getBlogsByTag(String tagName) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery(
				"SELECT DISTINCT b FROM Blog b JOIN b.tags tag WHERE REPLACE(tag.name, ' ', '-') LIKE :tagName AND b.enabled = true",
				Blog.class);
		query.setParameter("tagName", "%" + tagName + "%");

		List<Blog> blogsByTag = query.getResultList();
		
        for (Blog blog : blogsByTag) {
        	
        	Hibernate.initialize(blog.getTags());
        }

		return blogsByTag;
	}
	
	@Transactional
	@Override
	public Blog getBlogWithTag(int id) {
		Session session = sessionFactory.getCurrentSession();
			
		Blog blog = session.get(Blog.class, id);
		Hibernate.initialize(blog.getTags());
			
		return blog;
	}
	
	@Transactional
	@Override
	public Blog getBlogWithComments(int id) {
	    Session session = sessionFactory.getCurrentSession();

	    Query<Blog> query = session.createQuery("SELECT DISTINCT b FROM Blog b LEFT JOIN FETCH b.comments WHERE b.id = :id", Blog.class);
	    query.setParameter("id", id);

	    Blog blog = query.uniqueResult();

	    if (blog != null && blog.getComments() != null) {
	        Hibernate.initialize(blog.getComments());
	    }

	    return blog;
	}

	
	@Transactional
	@Override
	public List<Blog> getBlogListWithComments() {
	    Session session = sessionFactory.getCurrentSession();

	    Query<Blog> query = session.createQuery("SELECT b FROM Blog b LEFT JOIN FETCH b.comments", Blog.class);
	    List<Blog> blogs = query.getResultList();

	    return blogs;
	}


	@Transactional
	@Override
	public List<Blog> getBlogsByAuthor(String authorUrl) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery("SELECT DISTINCT b FROM Blog b JOIN b.user u WHERE CONCAT(LOWER(REPLACE(u.name, ' ', '-')), '-', LOWER(REPLACE(u.surname, ' ', '-'))) = :authorUrl and b.enabled = true",
				Blog.class);
		query.setParameter("authorUrl", authorUrl);

		List<Blog> blogsByAuthor = query.getResultList();

		return blogsByAuthor;
	}

	@Transactional
	@Override
	public List<Blog> getBlogsByName(String blogName) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery(
				"SELECT DISTINCT b FROM Blog b WHERE LOWER(REPLACE(b.name, ' ', '-')) LIKE :blogName and b.enabled = true",
				Blog.class);
		query.setParameter("blogName", "%" + blogName + "%");

		List<Blog> blogList = query.getResultList();

		for (Blog blog : blogList) {

			blog.setViews(blog.getViews() + 1);

			session.saveOrUpdate(blog);
		}

		return blogList;
	}

	@Transactional
	@Override
	public List<Blog> getBlogSearch(String blogQuery) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> typedBlogQuery = session.createQuery("SELECT b FROM Blog b WHERE b.name LIKE :blogQuery",
				Blog.class);
		typedBlogQuery.setParameter("blogQuery", "%" + blogQuery + "%");

		List<Blog> searchResults = typedBlogQuery.getResultList();

		return searchResults;
	}

	@Transactional
	@Override
	public List<Blog> getBlogsByStatus(boolean enabled) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query;

		if (enabled) {
			query = session.createQuery("from Blog b where b.enabled = true order by b.date", Blog.class);
		} else {
			query = session.createQuery("from Blog b where b.enabled = false order by b.date", Blog.class);
		}

		List<Blog> blogList = query.getResultList();

		return blogList;
	}

	@Transactional
	@Override
	public List<Blog> getBlogSearchByCategory(int categoryId) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery("from Blog b where b.category.id = :categoryId order by b.date",
				Blog.class);
		query.setParameter("categoryId", categoryId);

		List<Blog> blogList = query.getResultList();

		return blogList;
	}

	@Transactional
	@Override
	public List<Blog> getBlogSearchByAuthor(String author) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery(
				"from Blog b where REPLACE(CONCAT(b.user.name, ' ', b.user.surname), ' ', '-') = :author order by b.date",
				Blog.class);
		query.setParameter("author", author);

		List<Blog> blogList = query.getResultList();

		return blogList;
	}

	@Transactional
	@Override
	public Blog getPreviousPost(String blogName) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery(
				"SELECT DISTINCT b FROM Blog b WHERE LOWER(REPLACE(b.name, ' ', '-')) LIKE :blogName AND b.enabled = true",
				Blog.class);
		query.setParameter("blogName", "%" + blogName + "%");

		Blog currentBlog = query.uniqueResult();

		if (currentBlog == null) {
			return null;
		}

		LocalDate date = currentBlog.getDate();

		Query<Blog> previousQuery = session
				.createQuery("FROM Blog b WHERE b.date < :date AND b.enabled = true ORDER BY b.date DESC", Blog.class);
		previousQuery.setParameter("date", date);
		previousQuery.setMaxResults(1);

		return previousQuery.uniqueResult();
	}

	@Transactional
	@Override
	public Blog getNextPost(String blogName) {
		Session session = sessionFactory.getCurrentSession();

		Query<Blog> query = session.createQuery(
				"SELECT DISTINCT b FROM Blog b WHERE LOWER(REPLACE(b.name, ' ', '-')) LIKE :blogName AND b.enabled = true",
				Blog.class);
		query.setParameter("blogName", "%" + blogName + "%");

		Blog currentBlog = query.uniqueResult();

		if (currentBlog == null) {
			return null;
		}

		LocalDate date = currentBlog.getDate();

		Query<Blog> nextQuery = session
				.createQuery("FROM Blog b WHERE b.date > :date AND b.enabled = true ORDER BY b.date ASC", Blog.class);
		nextQuery.setParameter("date", date);
		nextQuery.setMaxResults(1);

		return nextQuery.uniqueResult();
	}

	@Transactional
	@Override
	public List<Blog> getBlogsByPage(int page) {
		Session session = sessionFactory.getCurrentSession();

		Query<Long> countQuery = session.createQuery("SELECT COUNT(*) FROM Blog WHERE enabled = true", Long.class);
		Long totalBlogs = (Long) countQuery.uniqueResult();

		int totalPages = (int) Math.ceil((double) totalBlogs / 12);

		Query<Blog> selectQuery = session.createQuery("FROM Blog b WHERE b.enabled = true ORDER BY b.date DESC",
				Blog.class);
		int firstResult = (page - 1) * 12;
		int maxResults = 12;

		if (page == totalPages) {
			int remainingBlogs = (int) (totalBlogs - (page - 1) * 12);
			maxResults = remainingBlogs;
		}

		selectQuery.setFirstResult(firstResult);
		selectQuery.setMaxResults(maxResults);

		return selectQuery.list();
	}

	@Transactional
	@Override
	public long getBlogsNumber() {
		Session session = sessionFactory.getCurrentSession();

		Query<Long> query = session.createQuery("SELECT COUNT(*) FROM Blog WHERE enabled = true", Long.class);

		long blogNumber = query.uniqueResult();

		return blogNumber;
	}

	

}