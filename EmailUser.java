package email;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUser {
  private String email, URL;
  private Session session;
  private final String usernameSMTP = "sycamoretransfer@gmail.com", passwordSMTP = "thisisasecurepassword";

  public EmailUser(String email, String URL) {
    this.email = email;
    this.URL = URL;
    connectToServer(); // Connects us
  }

  private void connectToServer() {
    Properties props = new Properties();
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");

    session = Session.getInstance(props, new javax.mail.Authenticator() {
      protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(usernameSMTP, passwordSMTP);
      }
    });
  }
  
  public void sendStartMessage() {
	  try {
	  Message message = new MimeMessage(session);
      message.setFrom(new InternetAddress("sycamoretransfer@gmail.com"));
      message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
      message.setSubject("Image is Processing");
      message.setText("Your image has started processing.");

      Transport.send(message);

      System.out.println("Finished sending start email");

    } catch (MessagingException e) {
      throw new RuntimeException(e);
    }
  }

  public void sendComplete() {
    try {
      Message message = new MimeMessage(session);
      message.setFrom(new InternetAddress("sycamoretransfer@gmail.com"));
      message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
      message.setSubject("Image is Ready");
      message.setText("Your image is done processing.\nPlease access at " + URL);

      Transport.send(message);

      System.out.println("Finished sending complete email");

    } catch (MessagingException e) {
      throw new RuntimeException(e);
    }
  }

//  public static void main(String[] args) {
//    new EmailUser("acinched@usc.edu", "dickbutt.com");
//  }
}