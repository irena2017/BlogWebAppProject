package blog.main.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table
public class Slide {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	@OneToOne(cascade = {CascadeType.ALL})
	@JoinColumn(name = "image_id", nullable = true)
    private Image image;
	@Column
	private String name;
	@Column
	private String buttonUrl;
	@Column
	private String buttonName;
	@Column
	private boolean enabled;
	@Column
	private int position;

	public Slide() {

	}

	public Slide(Image image, String name, String buttonUrl, String buttonName, boolean enabled, int position) {
		super();
		this.image = image;
		this.name = name;
		this.buttonUrl = buttonUrl;
		this.buttonName = buttonName;
		this.enabled = enabled;
		this.position = position;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Image getImage() {
		return image;
	}

	public void setImage(Image image) {
		this.image = image;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getButtonName() {
		return buttonName;
	}

	public void setButtonName(String buttonName) {
		this.buttonName = buttonName;
	}

	public String getButtonUrl() {
		return buttonUrl;
	}

	public void setButtonUrl(String buttonUrl) {
		this.buttonUrl = buttonUrl;
	}

	public boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}

}
