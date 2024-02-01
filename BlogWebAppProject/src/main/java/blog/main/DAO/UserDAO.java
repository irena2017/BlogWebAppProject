package blog.main.DAO;

import java.util.List;

import blog.main.entity.Role;
import blog.main.entity.User;

public interface UserDAO {

	public List<User> getUserList();

	public User getUser(String username);

	public User saveUser(User user);

	public void deleteUser(String username);

	public List<Role> getRoles();

	public boolean isPasswordComplex(String password);

	public void enableUser(String username);
	
	public boolean isUsernameTaken(String username);


	

}
