package blog.main.DAO;

import java.time.LocalDate;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import blog.main.entity.Comment;

@Repository
public class CommentDAOImpl implements CommentDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	@Override
	public Comment getComment(int id) {
		Session session = sessionFactory.getCurrentSession();

		Comment comment = session.get(Comment.class, id);

		return comment;
	}

	@Transactional
	@Override
	public void save(Comment comment) {

		Session session = sessionFactory.getCurrentSession();

		comment.setDate(LocalDate.now());

		session.saveOrUpdate(comment);
	}

	@Transactional
	@Override
	public Set<Comment> getCommentList() {
		Session session = sessionFactory.getCurrentSession();

		Query<Comment> query = session.createQuery("from Comment comment ORDER BY comment.date DESC", Comment.class);

		List<Comment> resultList = query.getResultList();
		
		Set<Comment> commentSet = new LinkedHashSet<>(resultList);
		
		return commentSet;
	}

	@Transactional
	@Override
	public void enableComments(int id) {
		Session session = sessionFactory.getCurrentSession();

		Comment comment = session.get(Comment.class, id);

		comment.setEnabled(!comment.getEnabled());

		session.saveOrUpdate(comment);

	}

	@Transactional
	@Override
	public Set<Comment> getCommentsByBlogId(int blogId) {
		Session session = sessionFactory.getCurrentSession();

		Query<Comment> query = session.createQuery("SELECT c FROM Comment c JOIN FETCH c.blog b WHERE b.id = :blogId", Comment.class);
		query.setParameter("blogId", blogId);

		List<Comment> commentsByBlogIdList = query.getResultList();
		
		Set<Comment> commentsByBlogIdSet = new LinkedHashSet<>(commentsByBlogIdList);


		return commentsByBlogIdSet;
	}

}
