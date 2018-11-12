package python;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import email.EmailUser;

@WebServlet("/Python")
public class PythonServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String style = request.getParameter("style");
		String input = request.getParameter("input");
		input = "C:\\Users\\tommy\\Downloads" + input;
		String output = request.getParameter("output");
		System.out.println(style);
		System.out.println(input);
		System.out.println(output);
		//String email = (String)request.getSession().getAttribute("Email");
		
		//PythonThread p = new PythonThread(input, style, output, email);
		//p.start();
	}
	
	/*public static void main(String[] args) 
	{
		String input = "miller.jpg";
		String style = "picasso.jpg";
		String output = "output.jpg";
		PythonThread p = new PythonThread(input, style, output, "tommyacin@hotmail.com");
		p.start();
	}*/
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
			//ProcessBuilder pb = new ProcessBuilder("python", "main.py", input, style, output);
			//pb.directory(new File("C:\\Users\\tommy\\Desktop\\eclipse-workspace\\SycamoreTransfer"));
			Process p = Runtime.getRuntime().exec(command, null, null);
			//Process p = pb.start();
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
