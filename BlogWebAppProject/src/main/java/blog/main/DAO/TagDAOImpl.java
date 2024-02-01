package blog.main.DAO;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import blog.main.entity.Tag;

@Repository
public class TagDAOImpl implements TagDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	@Override
	public List<Tag> getTagList() {

		Session session = sessionFactory.getCurrentSession();

		Query<Tag> query = session.createQuery("from Tag", Tag.class);

		List<Tag> tagList = query.getResultList();

		return tagList;
	}

	@Transactional
	@Override
	public Tag getTag(int id) {

		Session session = sessionFactory.getCurrentSession();

		Tag tag = session.get(Tag.class, id);

		return tag;

	}

	@Transactional
	@Override
	public void saveTag(Tag tag) {

		Session session = sessionFactory.getCurrentSession();

		session.saveOrUpdate(tag);
	}

	@Transactional
	@Override
	public void deleteTag(int id) {

		Session session = sessionFactory.getCurrentSession();

		Tag t = session.get(Tag.class, id);

		session.delete(t);
	}

	@Transactional
	@Override
	public List<Tag> getTagsById(List<Integer> ids) {

		Session session = sessionFactory.getCurrentSession();
		Query<Tag> query = session.createQuery("select t from Tag t where t.id IN (:ids)", Tag.class);
		query.setParameter("ids", ids);

		List<Tag> tags = query.getResultList();

		return tags;
	}

	@Transactional
	@Override
	public List<Tag> getSortedTags() {
		Session session = sessionFactory.getCurrentSession();

		Query<Tag> query = session
				.createQuery("SELECT t FROM Tag t JOIN t.blogs b GROUP BY t.id ORDER BY COUNT(b) DESC", Tag.class);

		List<Tag> tags = query.getResultList();

		return tags;
	}

	@Transactional
	@Override
	public List<Tag> getTagsByBlog(int id) {
		Session session = sessionFactory.getCurrentSession();

		Query<Tag> query = session.createQuery("SELECT t FROM Tag t JOIN t.blogs b WHERE b.id = :id", Tag.class);
		query.setParameter("id", id);

		List<Tag> tagsByBlog = query.getResultList();
		
		for (Tag tag : tagsByBlog) {
        	
        	Hibernate.initialize(tag.getBlogs());
        }

		return tagsByBlog;

	}

}
