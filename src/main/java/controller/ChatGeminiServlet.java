package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import okhttp3.*;
import org.json.*;

public class ChatGeminiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Lưu ý: KHÔNG để lộ API key thực trong code public
    private static final String API_KEY = "AIzaSyANFxpAwKxkhqjxGib2NpW4yP7w3kcuQaE";
    private static final String ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + API_KEY;

    private final OkHttpClient client = new OkHttpClient.Builder()
        .connectTimeout(30, java.util.concurrent.TimeUnit.SECONDS)
        .writeTimeout(30, java.util.concurrent.TimeUnit.SECONDS)
        .readTimeout(60, java.util.concurrent.TimeUnit.SECONDS)
        .build();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

        String question = req.getParameter("question");
        if (question == null || question.trim().isEmpty()) {
            resp.getWriter().write("Bạn chưa nhập câu hỏi.");
            return;
        }
        
//        String fullAnswer = "Ban da hoi " + question;
//        System.out.println(fullAnswer);
//        resp.getWriter().write(fullAnswer.toString());

        try {
            JSONObject json = new JSONObject();
            JSONArray parts = new JSONArray().put(new JSONObject().put("text", question));
            JSONArray contents = new JSONArray().put(new JSONObject().put("parts", parts));
            json.put("contents", contents);

            RequestBody body = RequestBody.create(json.toString(), MediaType.parse("application/json"));
            Request request = new Request.Builder().url(ENDPOINT).post(body).build();

            try (Response response = client.newCall(request).execute()) {
                if (response.isSuccessful() && response.body() != null) {
                    String responseBody = response.body().string();
                    JSONObject resJson = new JSONObject(responseBody);

                    if (!resJson.has("candidates")) {
                        resp.getWriter().write("Không có phản hồi từ AI.");
                        return;
                    }

                    JSONArray candidates = resJson.getJSONArray("candidates");
                    JSONObject content = candidates.getJSONObject(0).getJSONObject("content");
                    JSONArray answerParts = content.getJSONArray("parts");

                    StringBuilder fullAnswer = new StringBuilder();
                    for (int i = 0; i < answerParts.length(); i++) {
                        fullAnswer.append(answerParts.getJSONObject(i).getString("text"));
                    }

                    System.out.println("Gemini answered!");
                    //System.out.println(fullAnswer);
                    resp.getWriter().write(fullAnswer.toString());
                } else {
                    resp.getWriter().write("Lỗi API: " + response.code());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("Lỗi server: " + e.getMessage());
        }
    }

    // Nếu muốn load trang JSP mặc định khi GET:
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
    	
        req.getRequestDispatcher("/adjsp/chat.jsp").forward(req, resp);
    }
}
