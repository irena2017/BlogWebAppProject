package blog.main.DAO;

import java.util.List;

import blog.main.entity.Slide;

public interface SlideDAO {

	public List<Slide> getSlideList();

	public void deleteSlide(int id);

	public Slide getSlide(int id);

	public void enableSlide(int id);

	public void saveSlide(Slide slide);

	public List<Slide> getSlidesByPosition(int position);

}
