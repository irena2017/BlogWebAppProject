package blog.main.DAO;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import blog.main.entity.Blog;
import blog.main.entity.Category;
import blog.main.entity.Const;
import blog.main.entity.Image;
import blog.main.entity.Slide;
import blog.main.entity.User;

@Repository
public class ImageDAOImpl implements ImageDAO {
	
	@Autowired 
	private SessionFactory sessionFactory;
	
	@Transactional
	@Override
	public List<Image> saveBlogImages(MultipartFile[] fileImages, int id, Blog blog) throws IOException {
	    List<Image> images = new ArrayList<>();

	    for (MultipartFile multipartFile : fileImages) {
	        if (multipartFile != null && !multipartFile.isEmpty()) {
	            String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
	             
	            String uploadDir = Const.FOLDER_PATH + "blog/" + id + File.separator;
	            Path uploadPath = Paths.get(uploadDir);

	            if (!Files.exists(uploadPath)) {
	                Files.createDirectories(uploadPath);
	            }

	            try (InputStream inputStream = multipartFile.getInputStream()) {
	                Path filePath = uploadPath.resolve(fileName);
	                Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);

	                Image image = new Image();
	                image.setFileName(fileName);
	                
	                Path correctedPath = null;
	                Path imageFile = Paths.get("/images/" + "blog/" + id + "/" + fileName);
	    	        correctedPath = Paths.get(imageFile.toString().replaceAll("\\\\", "/"));
	                image.setImageUrl(correctedPath.toString());

	                image.setBlogs(Arrays.asList(blog));

	                saveImage(image);
	                images.add(image);
	            } catch (IOException e) {
	                throw new IOException("Could not save uploaded file: " + fileName);
	            }
	        }
	    }

	    return images;
	}

	@Transactional
	@Override
	public void saveImage(Image image) {
	    Session session = sessionFactory.getCurrentSession();
	    session.saveOrUpdate(image);
	}
	
	@Transactional
	@Override
	public String saveCategoryImage(MultipartFile fileImage, int id, Category category) throws IOException {
		String imageUrl = null;

	    if (fileImage != null && !fileImage.isEmpty()) {
	        String fileName = StringUtils.cleanPath(fileImage.getOriginalFilename());

	        String uploadDir = Const.FOLDER_PATH + "category/" + id + "/";
	        Path uploadPath = Paths.get(uploadDir);

	        if (!Files.exists(uploadPath)) {
	            Files.createDirectories(uploadPath);
	        }

	        try (InputStream inputStream = fileImage.getInputStream()) {
	            Path filePath = uploadPath.resolve(fileName);
	            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);

	            Image image = new Image();
	            
	            imageUrl = "/images/" + "category/" + id + "/" + fileName;
	            		
	            image.setImageUrl(imageUrl);
	    
	            category.setImage(image);
	        } 
	        catch (IOException e) {
	            throw new IOException("Could not save uploaded file: " + fileName);
	        }
	    }

	    return imageUrl;
	}
	
	@Transactional
	@Override
	public String saveSlideImage(MultipartFile fileImage, int id, Slide slide) throws IOException {
		String imageUrl = null;

	    if (fileImage != null && !fileImage.isEmpty()) {
	        String fileName = StringUtils.cleanPath(fileImage.getOriginalFilename());

	        String uploadDir = Const.FOLDER_PATH + "slide/" + id + "/";
	        Path uploadPath = Paths.get(uploadDir);

	        if (!Files.exists(uploadPath)) {
	            Files.createDirectories(uploadPath);
	        }

	        try (InputStream inputStream = fileImage.getInputStream()) {
	            Path filePath = uploadPath.resolve(fileName);
	            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);

	            Image image = new Image();
	            
	            imageUrl = "/images/" + "slide/" + id + "/" + fileName;
	            		
	            image.setImageUrl(imageUrl);

	            slide.setImage(image);
	        } 
	        catch (IOException e) {
	            throw new IOException("Could not save uploaded file: " + fileName);
	        }
	    }

	    return imageUrl;
	}
	
	@Transactional
	@Override
	public String saveUserImage(MultipartFile fileImage, User user) throws IOException {

	    String username = user.getUsername();
	    String imageUrl = null;

	    if (fileImage != null && !fileImage.isEmpty()) {
	        String fileName = StringUtils.cleanPath(fileImage.getOriginalFilename());

	        String uploadDir = Const.FOLDER_PATH + "users/" + username + File.separator;
	        Path uploadPath = Paths.get(uploadDir);

	        if (!Files.exists(uploadPath)) {
	            Files.createDirectories(uploadPath);
	        }

	        try (InputStream inputStream = fileImage.getInputStream()) {
	            Path filePath = uploadPath.resolve(fileName);
	            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);

	            Image image = new Image();
	            
	            imageUrl = "/images/" + "users/" + username + File.separator + fileName;
	            		
	            image.setImageUrl(imageUrl);

	            user.setImage(image);
	        } 
	        catch (IOException e) {
	            throw new IOException("Could not save uploaded file: " + fileName);
	        }
	    }

	    return imageUrl;
	}


}
