package blog.main.DAO;

import java.util.List;

import javax.transaction.Transactional;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import blog.main.entity.Slide;

@Repository
public class SlideDAOImpl implements SlideDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	@Override
	public List<Slide> getSlideList() {

		Session session = sessionFactory.getCurrentSession();

		Query<Slide> query = session.createQuery("from Slide", Slide.class);

		List<Slide> slideList = query.getResultList();

		return slideList;
	}

	@Transactional
	@Override
	public void deleteSlide(int id) {

		Session session = sessionFactory.getCurrentSession();

		Slide slide = session.get(Slide.class, id);

		session.delete(slide);
	}

	@Transactional
	@Override
	public Slide getSlide(int id) {

		Session session = sessionFactory.getCurrentSession();

		Slide slide = session.get(Slide.class, id);

		return slide;
	}

	@Transactional
	@Override
	public void enableSlide(int id) {

		Session session = sessionFactory.getCurrentSession();

		Slide slide = session.get(Slide.class, id);

		slide.setEnabled(!slide.getEnabled());

		session.saveOrUpdate(slide);
	}

	@Transactional
	@Override
	public List<Slide> getSlidesByPosition(int position) {

		Session session = sessionFactory.getCurrentSession();

		Query<Slide> query = session
				.createQuery("from Slide slide WHERE slide.enabled = true ORDER BY slide.position ASC", Slide.class);

		List<Slide> slideListByPosition = query.getResultList();

		return slideListByPosition;
	}

	@Transactional
	@Override
	public void saveSlide(Slide slide) {

		Session session = sessionFactory.getCurrentSession();

		session.saveOrUpdate(slide);
	}

}
