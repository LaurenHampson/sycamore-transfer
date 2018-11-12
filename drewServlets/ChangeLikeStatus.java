

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChangeLikeStatus
 */
@WebServlet("/ChangeLikeStatus")
public class ChangeLikeStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeLikeStatus() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("POST Request Received: Changing like status");
		//get email of current user
		String username = (String) request.getSession().getAttribute("UserName");
		String imageIdStr = (String) request.getAttribute("imageID");
		int imageID = -1;
		try {
			imageID = Integer.parseInt(imageIdStr);
		} catch (NumberFormatException e) {
			System.out.println(e.getMessage());
		}
		
		//interact with database
		Connection conn = null;
		Statement sqlStatement = null;
		ResultSet rs = null;
		int likeCount = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/UserProfiles?user=root&password=root&useSSL=false");
			sqlStatement = conn.createStatement();
			
			//get count from 
			rs = sqlStatement.executeQuery("SELECT * from ImageLikes where imageID='" + imageID + "'");
			boolean likedByCurrUser = false;
			while (rs.next()) {
				likeCount++;
				if (rs.getString(2).equals(username)) {
					//current user liked the image
					likedByCurrUser = true;
				}
			}
			if (likedByCurrUser) {
				//user likes the image, so unlike the image
				String query = "DELETE FROM ImageLikes WHERE imageID='" + imageID 
						+ "' AND userWhoLikedImage='" + username + "'";
				sqlStatement.executeUpdate(query);
				likeCount--;
			} else {
				//user does not currently like the photo, so like the image
				String query = "INSERT INTO ImageLikes (imageID, userWhoLikedImage) VALUES ('"
						+ imageID + "', '" + username + "');";
				sqlStatement.executeUpdate(query);
				likeCount++;
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
		
		//send the JSON to the page
		String response_str = "" + likeCount;
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(response_str);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
