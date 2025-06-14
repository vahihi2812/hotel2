package util;

public class NgrokLink {
	private static final String link = "https://513a-34-42-28-175.ngrok-free.app" + "/forecast";
		
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
