package blog.main.DAO;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import blog.main.entity.Role;
import blog.main.entity.User;
import blog.main.exception.NotFoundException;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	@Override
	public List<User> getUserList() {

		Session session = sessionFactory.getCurrentSession();

		Query<User> query = session.createQuery("from users", User.class);

		List<User> userList = query.getResultList();
		
		return userList;
	}

	@Transactional
	@Override
	public User saveUser(User user) {

		Session session = sessionFactory.getCurrentSession();
		
		user.setEnabled(true);

		session.saveOrUpdate(user);

		return user;

	}

	@Transactional
	@Override
	public void deleteUser(String username) {

		Session session = sessionFactory.getCurrentSession();

		User u = session.get(User.class, username);

		session.delete(u);
	}

	@Transactional
	@Override
	public User getUser(String username) {

		Session session = sessionFactory.getCurrentSession();

		User user = session.get(User.class, username);

		if (user == null) {

			throw new NotFoundException("The user was not found.");
		}

		return user;
	}

	@Transactional
	@Override
	public List<Role> getRoles() {

		Session session = sessionFactory.getCurrentSession();

		Query<Role> query = session.createQuery("from roles", Role.class);

		List<Role> roles = query.getResultList();

		return roles;
	}
	

	@Transactional
	@Override
	public boolean isPasswordComplex(String password) {

		String regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{6,}$";

		return password.matches(regex);
	}

	@Transactional
	@Override
	public void enableUser(String username) {

		Session session = sessionFactory.getCurrentSession();

		User user = session.get(User.class, username);

		user.setEnabled(!user.getEnabled());

		session.saveOrUpdate(user);

	}

	@Transactional
	@Override
	public boolean isUsernameTaken(String username) {
	    Session session = sessionFactory.getCurrentSession();

	    Query<User> query = session.createQuery("from users", User.class);

		List<User> users = query.getResultList();
	    
	    for (User user : users) {
	        if (user.getUsername().equals(username)) {
	            return true;
	        }
	    }
	    return false;
	}
	

}