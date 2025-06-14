package util;

public class NgrokLink {
	private static final String link = "https://5dcf-34-23-32-81.ngrok-free.app" + "/forecast";
		
    private NgrokLink() {
    }

    // Singleton: gọi getInstance() để lấy đối tượng
    public static NgrokLink getInstance() {
        return new NgrokLink();
    }

    public String getLink() {
        return link;
    }
}
