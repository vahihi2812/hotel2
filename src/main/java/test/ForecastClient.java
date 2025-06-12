package test;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import org.json.JSONObject;

import model.forecast_result;

public class ForecastClient {

    public static void main(String[] args) {
        try {
            // URL endpoint Flask server
            String endpoint = "https://aee2-104-198-6-54.ngrok-free.app/forecast";

            String d, n, f;
            
            // JSON body (ví dụ: dự đoán 5 ngày từ 2025-06-01)
            d = "2025-06-08";
            n = "5";
            f = "day";

            String jsonInput = "{"
                    + "\"d\": \"" + d + "\","
                    + "\"n\": " + n + ","
                    + "\"f\": \"" + f + "\""
                    + "}";

            System.out.println(jsonInput);

            // Gửi yêu cầu POST
            URL url = new URL(endpoint);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; utf-8");
            conn.setRequestProperty("Accept", "application/json");
            conn.setDoOutput(true);

            // Gửi nội dung JSON
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonInput.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // Đọc phản hồi trả về
            int code = conn.getResponseCode();
            InputStream responseStream = (code == 200) ? conn.getInputStream() : conn.getErrorStream();

            try (BufferedReader br = new BufferedReader(new InputStreamReader(responseStream, "utf-8"))) {
                StringBuilder response = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line.trim());
                }

                System.out.println("Server response:");
                System.out.println(response.toString());
                
                JSONObject jsonObject = new JSONObject(response.toString());
                ArrayList<forecast_result> list = new ArrayList<>();
                
                for (String key : jsonObject.keySet()) {
                    double value = jsonObject.getDouble(key);
                    list.add(new forecast_result(key, value));
                }
                
                for(forecast_result fr : list) {
                	System.out.println(fr.getFr_id() + ": " + fr.getFr_amount());
                }
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}