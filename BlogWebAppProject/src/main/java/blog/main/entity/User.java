package blog.main.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;
import javax.persistence.JoinColumn;

@Entity(name = "users")
@Table
public class User {

	@Id
	@Column(nullable = false, unique = true)
	@Size(min = 4, message = "Username must contain at least 4 characters")
	private String username;
	@Column(nullable = false)
	private String password;
	@Column(nullable = false)
    @Size(min = 3, message = "Name must contain at least 3 characters")
	private String name;
	@Column
	private String surname;
	@Size(min = 6, message = "Phone number must contain at least 6 digits")
	@Column
	private String phoneNumber;
	@Email(message = "Invalid email format")
	@Column
	private String email;
	@Column
	private boolean enabled;
	@OneToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH })
	@JoinTable(name = "authorities", joinColumns = @JoinColumn(name = "username"), inverseJoinColumns = @JoinColumn(name = "authority"))
    private Role role;
	@Transient
	private List<Blog> blogs;
	@OneToOne(cascade = {CascadeType.ALL})
	@JoinColumn(name = "image_id", nullable = true)
    private Image image;
	
	public User() {
	}

	public User(@Size(min = 4, message = "Username must contain at least 4 characters") String username,
			String password, @Size(min = 3, message = "Name must contain at least 3 characters") String name,
			String surname, @Size(min = 6, message = "Phone number must contain at least 6 digits") String phoneNumber,
			@Email(message = "Invalid email format") String email, boolean enabled, Role role, List<Blog> blogs,
			Image image) {
		super();
		this.username = username;
		this.password = password;
		this.name = name;
		this.surname = surname;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.enabled = enabled;
		this.role = role;
		this.blogs = blogs;
		this.image = image;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getSeoName() {

		String seoName = this.name.replaceAll(" ", "-").toLowerCase() + "-"
				+ this.surname.replaceAll(" ", "-").toLowerCase();

		return seoName;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public List<Blog> getBlogs() {
		return blogs;
	}

	public void setBlogs(List<Blog> blogs) {
		this.blogs = blogs;
	}
	
	public void setImage(Image image) {
		this.image = image;
	}

	public Image getImage() {
		return image;
	}

	
}