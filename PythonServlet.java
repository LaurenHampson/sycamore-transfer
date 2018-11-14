package python;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import email.EmailUser;

@WebServlet("/PythonServlet")
public class PythonServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String style = request.getParameter("style");
		style = "WebContent/" + style.substring(2);
		String input = request.getParameter("input");
		//input = "C:\\Users\\tommy\\Downloads\\" + input; //CHANGE FOR PRESENTATION
		String output = request.getParameter("output");
		System.out.println(style);
		System.out.println(input);
		System.out.println(output);
		String email = (String)request.getSession().getAttribute("Email");
		System.out.println("email: " + email);
		PythonThread p = new PythonThread("./WebContent/" + input, style, "./WebContent/" + output, email);
		p.start();
		
		input = "./" + input;
		output = "./" + output;
		String username = (String)request.getSession().getAttribute("UserName");
		if (email.equals("guest"))
		{
			ArrayList<String> guestImages = (ArrayList<String>) request.getSession().getAttribute("GuestList");
			guestImages.add(input);
			guestImages.add(output);
		}
		else
			insertDB(username, input, output);
	}
	
	public void insertDB (String username, String input, String output)
	{
		Connection conn = null;
		PreparedStatement ps = null;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/UserProfiles?user=root&password=root&useSSL=false");
			ps = conn.prepareStatement("INSERT IGNORE INTO Images (username, old_image, new_image, creationTime) values (?, ?, ?, ?);");
			ps.setString(1, username);
			ps.setString(2, input);
			ps.setString(3, output);
			ps.setTimestamp(4, new java.sql.Timestamp(Calendar.getInstance().getTime().getTime()));
			ps.execute();
		}
		catch(SQLException sqle)
		{
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe)
		{
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally
		{
			try
			{
				if (conn != null)
					conn.close();
			}
			catch(SQLException sqle)
			{
				System.out.println("sqle closing conn: " + sqle.getMessage());
			}
		}
	}
}

class PythonThread extends Thread
{
	String input, style, output, email;
	public PythonThread(String input, String style, String output, String email)
	{
		this.input = input;
		this.style = style;
		this.output = output;
		this.email = email;
	}
	public void run()
	{
		String command = "python main.py " + input + " " + style + " " + output + " --iter 1";
		System.out.println(command);
		EmailUser user = new EmailUser(email, output);
		user.sendStartMessage();
		try {
			ProcessBuilder pb = new ProcessBuilder("python", "main.py", input, style, output);
			pb.directory(new File("C:\\Users\\tommy\\Desktop\\eclipse-workspace\\SycamoreTransfer"));
			//Process p = Runtime.getRuntime().exec("pwd", null, null);
			Process p = pb.start();
			BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
			String s = "";
			while((s = stdInput.readLine()) != null) {
				System.out.println(s);
			}
			stdInput = new BufferedReader(new InputStreamReader(p.getErrorStream()));
			while((s = stdInput.readLine()) != null) {
				System.out.println(s);
			}
			p.waitFor();
			//p.destroy();
			System.out.println("FINISHED");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		user.sendComplete();
	}
}
