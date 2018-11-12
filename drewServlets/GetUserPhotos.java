

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class GetUserPhotos
 */
@WebServlet("/GetUserPhotos")
public class GetUserPhotos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetUserPhotos() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET Request Received: Retrieving user's photos)");
		//get email of current user
		//String username = (String) request.getSession().getAttribute("UserName");
		String username = "Kousheyo";
		
		//interact with database
		Connection conn = null;
		Statement sqlStatement = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		PhotoStream stream = new PhotoStream();
		stream.streamArray = new ArrayList<PhotoPair>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/UserProfiles?user=root&password=password&useSSL=false");
			sqlStatement = conn.createStatement();
			
			//check is email is already in database
			rs = sqlStatement.executeQuery("SELECT * from Images where username='" + username + "'");
			while (rs.next()) {
				//for each image, count number of likes
				int imageID = rs.getInt(1);
				String imageUsername = rs.getString(2);
				String oldImagePath = rs.getString(3);
				String newImagePath = rs.getString(4);
				Timestamp imageTimeStamp = rs.getTimestamp(5);
				rs2 = sqlStatement.executeQuery("SELECT * from ImageLikes where imageID='" + imageID + "'");
				boolean likedByCurrUser = false;
				int likeCount = 0;
				while (rs2.next()) {
					likeCount++;
					if (rs2.getString(2).equals(username)) {
						//current user liked the image
						likedByCurrUser = true;
					}
				}
				
				System.out.println(imageUsername);
				System.out.println(oldImagePath);
				System.out.println(newImagePath);
				PhotoPair pair = new PhotoPair();
				pair.imageID = imageID;
				pair.user = imageUsername;
				pair.originalPhotoPath = oldImagePath;
				pair.newPhotoPath = newImagePath;
				pair.numLikes = likeCount;
				pair.likedByCurrUser = likedByCurrUser;
				//pair.timeStamp = imageTimeStamp;
				stream.streamArray.add(pair);
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
		
		//send the JSON to the front end
		
		Gson gson = new Gson();
		String json = gson.toJson(stream);
			
		//send the JSON to the page
		System.out.println("Sending the JSON: " + json);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
