package test;

import util.SendEmail;

public class testmailutil {
	public static void main(String[] args) {
		SendEmail se = new SendEmail("hoangtudzz93@gmail.com", "ft_pdf");
		se.send_email();
	}
}
