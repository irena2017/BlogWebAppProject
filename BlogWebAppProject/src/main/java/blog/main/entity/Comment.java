package blog.main.entity;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Table(name = "comment")
@Entity
public class Comment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	@ManyToOne(cascade = { CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH })
	@JoinColumn(name = "commentUsername")
	private User user;
	@Column
	private LocalDate date;
	@Column
	private String name;
	@Column
	private String email;
	@Column
	private String text;
	@JoinColumn(name = "idBlog")
	@ManyToOne(cascade = { CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH })
	private Blog blog;
	@Column
	private boolean enabled;

	public Comment() {
	}

	public Comment(User user, LocalDate date, String name, String email, String text, Blog blog, boolean enabled) {
		super();
		this.user = user;
		this.date = date;
		this.name = name;
		this.email = email;
		this.text = text;
		this.blog = blog;
		this.enabled = enabled;
	}

	public long getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public LocalDate getDate() {
		return date;
	}

	public void setDate(LocalDate date) {
		this.date = date;
	}

	public String getFormattedDateMY() {
		if (this.date == null) {
			return "Unavailable";
		}
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy");
		return this.date.format(formatter);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Blog getBlog() {
		return blog;
	}

	public void setBlog(Blog blog) {
		this.blog = blog;
	}

	public boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

}
