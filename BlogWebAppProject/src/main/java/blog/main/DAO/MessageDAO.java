package blog.main.DAO;

import java.util.List;

import blog.main.entity.Message;

public interface MessageDAO {

	public void saveMessage(Message message);

	public List<Message> getAllMessages();

	public long getUnreadMessagesCount();

	public Message getMessage(int id);

	public void deleteMessage(int id);
}
