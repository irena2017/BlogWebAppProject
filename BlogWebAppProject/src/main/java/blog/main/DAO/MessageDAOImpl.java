package blog.main.DAO;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import blog.main.entity.Message;

@Repository
public class MessageDAOImpl implements MessageDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	@Override
	public void saveMessage(Message message) {

		Session session = sessionFactory.getCurrentSession();

		LocalDateTime currentDateTime = LocalDateTime.now();
		message.setDate(currentDateTime);

		session.saveOrUpdate(message);
	}

	@Transactional
	@Override
	public List<Message> getAllMessages() {
		Session session = sessionFactory.getCurrentSession();

		Query<Message> query = session.createQuery("from Message", Message.class);

		return query.getResultList();
	}

	@Transactional
	@Override
	public long getUnreadMessagesCount() {
		Session session = sessionFactory.getCurrentSession();

		Query<Long> query = session.createQuery("select count(*) from Message m where m.isRead = 0", Long.class);

		return query.uniqueResult();
	}

	@Transactional
	@Override
	public Message getMessage(int id) {

		Session session = sessionFactory.getCurrentSession();

		Message m = session.get(Message.class, id);

		return m;
	}

	@Transactional
	@Override
	public void deleteMessage(int id) {

		Session session = sessionFactory.getCurrentSession();

		Message message = session.get(Message.class, id);

		session.delete(message);

	}

}
