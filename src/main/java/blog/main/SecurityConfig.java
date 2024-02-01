package blog.main;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private DataSource myDataSource;


    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication().dataSource(myDataSource);
    }
    
    @Override
	protected void configure(HttpSecurity http) throws Exception {
	
		http
		.csrf()
        .ignoringAntMatchers("/administration/blog-save")
        .ignoringAntMatchers("/administration/category-save")
        .ignoringAntMatchers("/administration/slide-save")
        .ignoringAntMatchers("/administration/user-save")
        .ignoringAntMatchers("/administration/user-edit-profile-action")
        .ignoringAntMatchers("/administration/update-category-order")
        .ignoringAntMatchers("/logout")
        .and()
		.authorizeRequests()
		.antMatchers("/").permitAll()
		.antMatchers("/administration/update-category-order").permitAll()
		.antMatchers("/administration/blog-list").hasAnyRole("admin", "user")
		.antMatchers("/administration/upload").hasAnyRole("admin", "user")
		.antMatchers("/administration/blog-form").hasAnyRole("admin", "user")
		.antMatchers("/administration/blog-save").hasAnyRole("admin", "user")
		.antMatchers("/administration/category-list").hasRole("admin")
		.antMatchers("/administration/category-save").hasRole("admin")
		.antMatchers("/administration/category-form").hasRole("admin")
		.antMatchers("/administration/comment-list").hasRole("admin")
		.antMatchers("/administration/message-list").hasRole("admin")
		.antMatchers("/administration/slide-form").hasRole("admin")
		.antMatchers("/administration/slide-list").hasRole("admin")
		.antMatchers("/administration/slide-save").hasRole("admin")
		.antMatchers("/administration/tag-form").hasRole("admin")
		.antMatchers("/administration/tag-list").hasAnyRole("admin", "user")
		.antMatchers("/administration/user-form").hasRole("admin")
		.antMatchers("/administration/user-list").hasRole("admin")
		.antMatchers("/administration/user-save").hasRole("admin")
		.antMatchers("/administration/user-edit-profile").hasAnyRole("admin", "user")
		.antMatchers("/administration/user-edit-profile-action").hasAnyRole("admin", "user")
		.antMatchers("/administration/user-change-password").hasAnyRole("admin","user")
		.antMatchers("/administration/**").hasAnyRole("user", "admin")
		.and().formLogin()
		.loginPage("/loginPage")
		.loginProcessingUrl("/authenticateTheUser").permitAll()
		.and()
		.logout()
		    .logoutUrl("/logout")
		    .logoutSuccessUrl("/")
		    .invalidateHttpSession(true)
		    .deleteCookies("JSESSIONID")
		    .permitAll(); 
		}
  
}
