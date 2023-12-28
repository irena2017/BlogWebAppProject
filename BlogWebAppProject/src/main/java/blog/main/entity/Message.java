package blog.main.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Table
@Entity
public class Message {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	@Column
	private String name;
	@ManyToOne(cascade = { CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH })
	@JoinColumn(name = "messageUsername")
	private User user;
	@Column
	private String email;
	@Column
	private String message;
	@Column
	private LocalDateTime date;
	@Column
	private boolean isRead;

	public Message() {

	}

	public Message(String name, User user, String email, String message, LocalDateTime date, boolean isRead) {
		super();
		this.name = name;
		this.user = user;
		this.email = email;
		this.message = message;
		this.date = date;
		this.isRead = isRead;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public LocalDateTime getDate() {
		return date;
	}

	public LocalDate getDateOnly() {
		return date.toLocalDate();
	}

	public void setDate(LocalDateTime date) {
		this.date = date;
	}

	public String getTimeAgo() {
		LocalDateTime currentTime = LocalDateTime.now();

		long hours = ChronoUnit.HOURS.between(date, currentTime);

		long minutes = ChronoUnit.MINUTES.between(date, currentTime);

		String timeAgo;

		if (hours >= 24) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd-yyyy");
			timeAgo = date.format(formatter);
		} else if (hours > 0) {
			timeAgo = hours + (hours == 1 ? " hour" : " hours") + " ago";
		} else if (minutes > 0) {
			timeAgo = minutes + (minutes == 1 ? " minute" : " minutes") + " ago";
		} else {
			timeAgo = "just now";
		}
		return timeAgo;
	}

	public boolean getIsRead() {
		return isRead;
	}

	public void setIsRead(boolean isRead) {
		this.isRead = isRead;
	}

}
