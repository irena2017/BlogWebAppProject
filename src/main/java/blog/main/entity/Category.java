package blog.main.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

@Entity
@Table
public class Category {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private Integer id;
	@Column
	@Size(max = 20, message = "Name must not contain over 20 characters.")
	private String name;
	@Column
	private String description;
	@OneToOne(cascade = {CascadeType.ALL})
	@JoinColumn(name = "image_id", nullable = true)
	private Image image;
	@Column
	private int position;
	@Transient
	private List<Category> categoryList;

	public Category() {
	}

	public Category(String name, String description, Image image, int position, List<Category> categoryList) {
		super();
		this.name = name;
		this.description = description;
		this.image = image;
		this.position = position;
		this.categoryList = categoryList;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSeoName() {

		String seoName = this.name.replaceAll(" ", "-").toLowerCase();

		return seoName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Image getImage() {
		return image;
	}

	public void setImage(Image image) {
		this.image = image;
	}

	public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}

	public List<Category> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<Category> categoryList) {
		this.categoryList = categoryList;
	}

}
