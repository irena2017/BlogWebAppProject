package blog.main.entity;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table
public class Blog {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(name = "Blog_Image", joinColumns = @JoinColumn(name = "blog_id"), inverseJoinColumns = @JoinColumn(name = "image_id"))
    private List<Image> images = new ArrayList<>();
	private LocalDate date;
	@JoinColumn(name = "idCategory", nullable = true)
	@ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH })
	private Category category;
	@Column
	@Size(min = 20, max = 255, message = "Min 20, max 255 characters.")
	private String name;
	@JoinColumn(name = "userUsername")
	@ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH })
	private User user;
	@Column 
	@Size(min = 50, max = 500, message = "Min 50, max 500 characters.")
	private String description;
	@Column
	private String text;
	@Column
	private long views;
	@Column
	private boolean important;
	@Column
	private boolean enabled;
	@ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH })
	@JoinTable(name = "Blog_Tag", joinColumns = @JoinColumn(name = "id_blog"), inverseJoinColumns = @JoinColumn(name = "id_tag"))
	private List<Tag> tags;
	@Transient
	private List<Integer> tagIds;
	@OneToMany(mappedBy = "blog", fetch = FetchType.EAGER)
	@Fetch(FetchMode.JOIN)
	private Set<Comment> comments;

	public Blog() {
	}

	public Blog(List<Image> images, LocalDate date, Category category,
			@Size(min = 20, max = 255, message = "Min 20, max 255 characters.") String name, User user,
			@Size(min = 50, max = 500, message = "Min 50, max 500 characters.") String description, String text,
			long views, boolean important, boolean enabled, List<Tag> tags, List<Integer> tagIds,
			Set<Comment> comments) {
		super();
		this.images = images;
		this.date = date;
		this.category = category;
		this.name = name;
		this.user = user;
		this.description = description;
		this.text = text;
		this.views = views;
		this.important = important;
		this.enabled = enabled;
		this.tags = tags;
		this.tagIds = tagIds;
		this.comments = comments;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<Image> getImages() {
		return images;
	}

	public void setImages(List<Image> images) {
		this.images = images;
	}

	public LocalDate getDate() {
		return date;
	}

	public void setDate(LocalDate date) {
		this.date = date;
	}

	public String getFormattedDateMonth() {
		if (this.date == null) {
			return "Unavailable";
		}

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM | yyyy", Locale.getDefault());
		return this.date.format(formatter);
	}

	public String getFormattedDateWithComma() {
		if (this.date == null) {
			return "Unavailable";
		}

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd, yyyy", Locale.getDefault());
		return this.date.format(formatter);
	}

	public String getFormattedDateMY() {
		if (this.date == null) {
			return "Unavailable";
		}
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM yyyy");
		return this.date.format(formatter);
	}

	public String getFormattedDateMA() {
		if (this.date == null) {
			return "Unavailable";
		}

		LocalDate currentDate = LocalDate.now();
		Period period = Period.between(this.date, currentDate);
		int monthsDifference = period.getMonths();

		if (monthsDifference <= 0) {
			return "This month";
		} else {
			return monthsDifference + (monthsDifference == 1 ? " month" : " months") + " ago";
		}
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public long getViews() {
		return views;
	}

	public void setViews(long views) {
		this.views = views;
	}

	public boolean getImportant() {
		return important;
	}

	public void setImportant(boolean important) {
		this.important = important;
	}

	public boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public List<Tag> getTags() {
		return tags;
	}

	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}

	public List<Integer> getTagIds() {
		return tagIds;
	}

	public void setTagIds(List<Integer> tagIds) {
		this.tagIds = tagIds;
	}

	public Set<Comment> getComments() {
		return comments;
	}

	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}

	
	
}
