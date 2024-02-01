package blog.main.DAO;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import blog.main.entity.Category;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	@Override
	public List<Category> getCategoryList() {

		Session session = sessionFactory.getCurrentSession();

		Query<Category> query = session.createQuery("from Category", Category.class);

		List<Category> categoryList = query.getResultList();

		return categoryList;
	}

	@Transactional
	@Override
	public void deleteCategory(int id) {

		Session session = sessionFactory.getCurrentSession();

		Category c = session.get(Category.class, id);

		session.delete(c);
	}

	@Transactional
	@Override
	public void saveCategory(Category category) {

		Session session = sessionFactory.getCurrentSession();

		session.saveOrUpdate(category);
	}

	@Transactional
	@Override
	public Category getCategory(int id) {

		Session session = sessionFactory.getCurrentSession();

		Category category = session.get(Category.class, id);

		return category;
	}

	@Transactional
	@Override
	public List<Category> getCategoryListByOrder(int position, int maxResults) {
		Session session = sessionFactory.getCurrentSession();

		Query<Category> query;

		if (maxResults == 0) {
			query = session.createQuery("FROM Category ORDER BY position ASC", Category.class);
		} else {
			query = session.createQuery("FROM Category ORDER BY position ASC", Category.class);
			query.setMaxResults(4);
		}

		List<Category> categoriesList = query.getResultList();

		return categoriesList;
	}
	
	@Transactional
	@Override
	public String updateCategoryOrder (@RequestParam(required=false)Category category, @RequestParam(required = false) String direction,
			@RequestParam(defaultValue="0") int newPosition) {
		Session session = sessionFactory.getCurrentSession();
	    
	    if(direction.equals("up")) {
	    	newPosition = category.getPosition() - 1;
	    }
	    else if(direction.equals("down"))  {
	    	newPosition = category.getPosition() + 1;
	    }
	    
	    category.setPosition(newPosition);
	    
	    session.saveOrUpdate(category);
	    
	    return "redirect:/administration/category-list";
	}

	@Transactional
	@Override
	public Category getCategoryByPosition(int position) {
		Session session = sessionFactory.getCurrentSession();
		
		Query<Category> query = session.createQuery("SELECT c FROM Category c WHERE c.position = :position", Category.class);
		query.setParameter("position", position);
		
		Category categoryByPosition = query.getSingleResult();
		
		return categoryByPosition;
	}
	
	
}