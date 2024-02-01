package blog.main.backend;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import blog.main.DAO.UserDAO;

@Controller
public class AuthController {

	@Autowired UserDAO userDAO;
	
	    @RequestMapping("/loginPage")
	    public String getLoginPage() {
			return "/loginPage";
	    }    
}
