package blog.main.DAO;

import java.util.List;

import blog.main.entity.Category;

public interface CategoryDAO {

	public List<Category> getCategoryList();

	public void deleteCategory(int id);

	public void saveCategory(Category category);

	public Category getCategory(int id);

	public List<Category> getCategoryListByOrder(int position, int maxResults);
	
	public String updateCategoryOrder(Category category, String direction, int newPosition);
	
	public Category getCategoryByPosition(int position);

}
