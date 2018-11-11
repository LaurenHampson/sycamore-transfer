

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.annotation.adapters.HexBinaryAdapter;

/**
 * Servlet implementation class SignUpServlet
 */
@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUpServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("POST request: attempting to add user to database");
		//get username, email, and password
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String error_msg = "no_error";
		
		//interact with database
		Connection conn = null;
		Statement sqlStatement = null;
		ResultSet rs = null;
		try {
			System.out.println("heyo");
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/UserProfiles?user=root&password=password&useSSL=false");
			sqlStatement = conn.createStatement();
			
			//check is email is already in database
			rs = sqlStatement.executeQuery("SELECT * from Users where email='" + email + "'");
			if (rs.next()) {
				//user is already in database
				System.out.println("This email is already in the database");
				error_msg = "email_taken";			
			}
			System.out.println("heyo");	
			//check if username is taken
			rs = sqlStatement.executeQuery("SELECT * from Users where username='" + username + "'");
			if (rs.next()) {
				//username is taken
				System.out.println("This username is already in the database");
				if (error_msg.equals("email_taken")) {
					error_msg = "email_username_taken";
				} else {
					error_msg = "username_taken";	
				}			
			}
			System.out.println(error_msg);
			System.out.println(email + username);
			//if no error, proceed in creating user
			if (error_msg.equals("no_error")) {
				//salt the password for extra security
				String salt = "fhtsg736%hefbI623#kjdbfgtuqi1!0&*ertvb";
				password = password.concat(salt);
				//hash the password
				String password_hash = "";
				try {
					MessageDigest md5_instance = MessageDigest.getInstance("MD5");
					byte[] bytes = password.getBytes("UTF8");
					byte[] hashed_bytes = md5_instance.digest(bytes);
					HexBinaryAdapter hex = new HexBinaryAdapter();
					password_hash = hex.marshal(hashed_bytes);
				} catch (NoSuchAlgorithmException e) {
					System.out.println(e.getMessage());
				}
				//store all info in database
				String query = "INSERT INTO Users "
						+ "(email, username, password) "
						+ "VALUES ('"
						+ email + "', '"
						+ username + "', '"
						+ password_hash + "');";
				System.out.println(query);
				sqlStatement.executeUpdate(query);
			}
			
		} catch (SQLException sqle) {
			System.out.println ("sqle: " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println ("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if (rs != null) { 
					rs.close(); 
				}
				if (sqlStatement != null) { 
					sqlStatement.close(); 
				}
				if (conn != null) { 
					conn.close(); 
				} 
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}

		//return the error message
		//if no error, string returned is "no_error"
		//else, errors are "email_taken", "username_taken", or "email_username_taken"
		String nextPage = "/about.jsp";
		if(!error_msg.equals("no_error")) {
			request.setAttribute("error", error_msg);
		}
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
		dispatch.forward(request,response);
	}

}
