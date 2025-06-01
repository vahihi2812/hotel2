package test;

import java.io.*;
import java.net.*;
import javax.net.ssl.HttpsURLConnection;

public class testmodel {
	public static void main(String[] args) {
		try {
			URL url = new URL("https://7a5a-35-188-143-37.ngrok-free.app/forecast");
			HttpsURLConnection con = (HttpsURLConnection) url.openConnection();

			// Bắt buộc set method POST
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json; utf-8");
			con.setRequestProperty("Accept", "application/json");
			con.setDoOutput(true);

			// JSON payload
			String jsonInputString = "{\"floor_1\":5, \"floor_2\":7, \"floor_3\":4, \"floor_4\":6, \"floor_5\":8, \"day_of_year\":123}";

			// Gửi JSON vào body
			try (OutputStream os = con.getOutputStream()) {
				byte[] input = jsonInputString.getBytes("utf-8");
				os.write(input, 0, input.length);
			}

			// Đọc phản hồi
			int code = con.getResponseCode();
			System.out.println("HTTP Response Code: " + code);

			InputStream is;
			if (code >= 200 && code < 300) {
				is = con.getInputStream();
			} else {
				// Đọc lỗi nếu không phải 2xx
				is = con.getErrorStream();
			}

			try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "utf-8"))) {
				StringBuilder response = new StringBuilder();
				String line;
				while ((line = br.readLine()) != null) {
					response.append(line.trim());
				}
				System.out.println("Response: " + response.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
