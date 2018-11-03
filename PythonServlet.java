package python;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Python")
public class PythonServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String style = request.getParameter("style");
		String input = request.getParameter("input");
		String output = request.getParameter("output");
		String email = request.getParameter("email");
		String command = "python main.py " + input + " " + style + " " + output;
		
		Process p = Runtime.getRuntime().exec(command, null, null);
		try {
			p.waitFor();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		p.destroy();
	}
}
