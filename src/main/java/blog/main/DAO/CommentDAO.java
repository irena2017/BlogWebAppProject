package blog.main.DAO;

import java.util.Set;

import blog.main.entity.Comment;

public interface CommentDAO {

	public Comment getComment(int id);

	public void save(Comment comment);

	public Set<Comment> getCommentList();

	public void enableComments(int id);

	public Set<Comment> getCommentsByBlogId(int blogId);
	
}
