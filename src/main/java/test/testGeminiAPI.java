package test;

import okhttp3.*;
import org.json.JSONArray;
import org.json.JSONObject;

public class testGeminiAPI {
    // 👉 Thay thế bằng API key hợp lệ của bạn
    private static final String API_KEY = "AIzaSyANFxpAwKxkhqjxGib2NpW4yP7w3kcuQaE";
    private static final String ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + API_KEY;

    public static void main(String[] args) {
    	OkHttpClient client = new OkHttpClient.Builder()
    	        .connectTimeout(30, java.util.concurrent.TimeUnit.SECONDS)
    	        .writeTimeout(30, java.util.concurrent.TimeUnit.SECONDS)
    	        .readTimeout(60, java.util.concurrent.TimeUnit.SECONDS)
    	        .build();

        // Câu hỏi muốn gửi đến Gemini
        String prompt = "CLB vô địch C1 năm ngoái là?";

        // Tạo JSON body gửi đi
        JSONObject json = new JSONObject();
        JSONArray parts = new JSONArray().put(new JSONObject().put("text", prompt));
        JSONArray contents = new JSONArray().put(new JSONObject().put("parts", parts));
        json.put("contents", contents);

        // Gửi request
        RequestBody body = RequestBody.create(json.toString(), MediaType.parse("application/json"));
        Request request = new Request.Builder().url(ENDPOINT).post(body).build();

        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful()) {
                String responseBody = response.body().string();

                // 👉 Phân tích JSON để lấy phần text trả lời
                JSONObject resJson = new JSONObject(responseBody);
                JSONArray candidates = resJson.getJSONArray("candidates");
                JSONObject content = candidates.getJSONObject(0).getJSONObject("content");
                JSONArray answerParts = content.getJSONArray("parts");

                StringBuilder fullAnswer = new StringBuilder();
                for (int i = 0; i < answerParts.length(); i++) {
                    fullAnswer.append(answerParts.getJSONObject(i).getString("text"));
                }

                // In ra câu trả lời
                System.out.println("🧠 Trả lời từ Gemini:");
                System.out.println(fullAnswer.toString());
            } else {
                System.out.println("❌ Lỗi gọi API: " + response.code());
                System.out.println(response.body().string());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
