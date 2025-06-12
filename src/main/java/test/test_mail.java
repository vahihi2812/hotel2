package test;

import java.io.File;
import java.util.Properties;

import controller.Booking_reportController;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

public class test_mail {
    public static void main(String[] args) {
    	final String senderEmail = "vietanhqv204@gmail.com";
		final String appPassword = "npqusbvazvjfwneq";
		final String recipientEmail = "hoangtudzz93@gmail.com";

		// SMTP Server Properties
		Properties prop = new Properties();
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.starttls.enable", "true");
		prop.put("mail.smtp.port", "587");

		// Create session with Authentication
		Session session = Session.getInstance(prop, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(senderEmail, appPassword);
			}
		});
		session.setDebug(true);

		try {
			// Create Email message
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(senderEmail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
			message.setSubject("Report for you");
			message.setText("Hello \n This is a test email from Java \n Regards,\nQA Team");

			// Email Body Part
			MimeBodyPart textPart = new MimeBodyPart();
			textPart.setText("Hello \n\n This is a test email from Java \n\n Regards,\nQA Team");
			
			// Attachment Part
			MimeBodyPart attachmentPart = new MimeBodyPart();
			String filePath = Booking_reportController.getPDFPath();
			System.out.println("Attachment path is - " + filePath);
			attachmentPart.attachFile(new File(filePath));
			
			// Combine body and attachment parts
			MimeMultipart multipart = new MimeMultipart();
			multipart.addBodyPart(textPart);
			multipart.addBodyPart(attachmentPart);
			message.setContent(multipart);
			
			// Send Email
			Transport.send(message);
			System.out.println("Email Sent Successfully ***");

		} catch (Exception e) {
			e.printStackTrace();
		}

    }
}
