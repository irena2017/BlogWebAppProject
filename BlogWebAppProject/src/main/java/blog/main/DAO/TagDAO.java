package blog.main.DAO;

import java.util.List;

import blog.main.entity.Tag;

public interface TagDAO {

	public List<Tag> getTagList();

	public Tag getTag(int id);

	public void saveTag(Tag tag);

	public void deleteTag(int id);

	public List<Tag> getTagsById(List<Integer> ids);

	public List<Tag> getSortedTags();

	public List<Tag> getTagsByBlog(int id);

}
