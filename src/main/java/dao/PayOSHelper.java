package dao;

import java.io.*;
import java.net.*;
import java.util.Properties;
import java.util.stream.Collectors;

import org.json.JSONObject;

public class PayOSHelper {
    private static String clientId;
    private static String apiKey;

    static {
        try (InputStream input = PayOSHelper.class.getClassLoader().getResourceAsStream("payos-config.properties")) {
            Properties props = new Properties();
            props.load(input);
            clientId = props.getProperty("payos.client_id");
            apiKey = props.getProperty("payos.api_key");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String createPaymentLink(int amount, String orderCode, String returnUrl) throws IOException {
        URL url = new URL("https://api-merchant.payos.vn/v2/payment-requests");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json");
        con.setRequestProperty("x-client-id", clientId);
        con.setRequestProperty("x-api-key", apiKey);
        con.setDoOutput(true);

        JSONObject requestBody = new JSONObject();
        requestBody.put("orderCode", orderCode); // Có thể chỉ là số, thử đổi thành "12345"
        requestBody.put("amount", amount); // VD: 100000
        requestBody.put("description", "Thanh toán đơn hàng #" + orderCode);
        requestBody.put("returnUrl", returnUrl); // VD: http://localhost:8080/hotel2/return.jsp
        requestBody.put("cancelUrl", "http://localhost:8080/hotel2/cancel.jsp"); // 👈 BẮT BUỘC nếu dùng returnUrl

        long expiredAt = System.currentTimeMillis() + 15 * 60 * 1000; // 15 phút sau
        requestBody.put("expiredAt", expiredAt);

        System.out.println("Sending JSON to PayOS: " + requestBody.toString(2));

        try (OutputStream os = con.getOutputStream()) {
            byte[] input = requestBody.toString().getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        int status = con.getResponseCode();
        InputStream responseStream = (status >= 200 && status < 300)
                ? con.getInputStream()
                : con.getErrorStream();

        String responseBody = new BufferedReader(new InputStreamReader(responseStream))
                .lines()
                .collect(Collectors.joining("\n"));

        System.out.println("PayOS response: " + responseBody); // 👈 In log

        JSONObject jsonResponse = new JSONObject(responseBody);

        if (!jsonResponse.has("data") || jsonResponse.isNull("data")) {
            throw new IOException("Lỗi từ PayOS: " + jsonResponse.toString());
        }

        JSONObject data = jsonResponse.getJSONObject("data");
        return data.getString("checkoutUrl");
    }
}

