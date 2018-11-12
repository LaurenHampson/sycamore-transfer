

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
 * Servlet implementation class SignInServlet
 */
@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignInServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("POST request: attempting to sign in user");
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
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/UserProfiles?user=root&password=root&useSSL=false");
			sqlStatement = conn.createStatement();
			
			//hash password
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
			
			//check if username and password combo is already in database
			rs = sqlStatement.executeQuery("SELECT * from Users where username='" + email + "'"
					+ "AND password='" + password_hash + "'");
			if (!rs.next()) {
				//user is not in database
				System.out.println("This username / password combo is not in the database");
				error_msg = "account_not_found";			
			}
			
		} catch (SQLException sqle) {
			System.out.println (sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println (cnfe.getMessage());
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
		if(error_msg.equals("no_error")) {
			String nextPage = "/about.jsp";
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
			dispatch.forward(request,response);
			return;
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(error_msg);
	}

}
