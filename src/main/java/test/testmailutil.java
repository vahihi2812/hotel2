package test;

import util.SendEmail;

public class testmailutil {
	public static void main(String[] args) {
		String recp = "pnhi28z12@gmail.com";
		SendEmail se = new SendEmail(recp, "ft_pdf");
		se.send_email();
	}
}
