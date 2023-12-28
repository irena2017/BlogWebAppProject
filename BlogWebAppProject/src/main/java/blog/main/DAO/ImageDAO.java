package blog.main.DAO;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import blog.main.entity.Blog;
import blog.main.entity.Category;
import blog.main.entity.Image;
import blog.main.entity.Slide;
import blog.main.entity.User;

public interface ImageDAO {

	public List<Image> saveBlogImages(MultipartFile[] fileImages, int id, Blog blog) throws IOException;
	
	public String saveCategoryImage(MultipartFile fileImage, int id, Category category) throws IOException;
	
	public String saveSlideImage(MultipartFile fileImage, int id, Slide slide) throws IOException;
	
	public String saveUserImage(MultipartFile fileImage, User user) throws IOException;
	
	public void saveImage(Image image);

	

	

	
}
