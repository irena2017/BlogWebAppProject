package blog.main.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table
public class Image {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int id;
    @Column
    private String imageUrl;
    @Column
    private String fileName;
    @ManyToMany(cascade = {CascadeType.ALL})
	@JoinTable(name = "Blog_Image", joinColumns = @JoinColumn(name = "image_id"), inverseJoinColumns = @JoinColumn(name = "blog_id"))
    private List<Blog> blogs;
    @OneToOne(mappedBy = "image", cascade = {CascadeType.ALL})
    private Category category;
    @OneToOne(mappedBy = "image", cascade = {CascadeType.ALL})
    private Slide slide;
    @OneToOne(mappedBy = "image", cascade = {CascadeType.ALL})
    private User user;

    public Image() {
    }

	public Image(String imageUrl, String fileName, List<Blog> blogs, Category category, Slide slide, User user) {
		super();
		this.imageUrl = imageUrl;
		this.fileName = fileName;
		this.blogs = blogs;
		this.category = category;
		this.slide = slide;
		this.user = user;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public List<Blog> getBlogs() {
		return blogs;
	}

	public void setBlogs(List<Blog> blogs) {
		this.blogs = blogs;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Slide getSlide() {
		return slide;
	}

	public void setSlide(Slide slide) {
		this.slide = slide;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	
}