package util;

import java.net.*;
import java.util.Enumeration;

public class IPFetcher {

    private int lastByte;

    private IPFetcher() {
        fetchLastByte();
    }

    // Singleton: gọi getInstance() để lấy đối tượng
    public static IPFetcher getInstance() {
        return new IPFetcher();
    }

    public int getLastByte() {
        return lastByte;
    }

    private void fetchLastByte() {
        try {
            Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
            while (interfaces.hasMoreElements()) {
                NetworkInterface netInterface = interfaces.nextElement();

                if (netInterface.isLoopback() || !netInterface.isUp()) continue;

                String name = netInterface.getDisplayName().toLowerCase();
                if (!name.contains("wi-fi") && !name.contains("wlan")) continue;

                Enumeration<InetAddress> addresses = netInterface.getInetAddresses();
                while (addresses.hasMoreElements()) {
                    InetAddress address = addresses.nextElement();
                    if (address instanceof Inet4Address && !address.isLoopbackAddress()) {
                        String ip = address.getHostAddress(); // Ex: 192.168.1.105
                        String[] parts = ip.split("\\.");
                        lastByte = Integer.parseInt(parts[3]);
                        return;
                    }
                }
            }

            lastByte = -1; // Không tìm thấy
        } catch (Exception e) {
        	System.err.println("loi ip neeeeee");
            e.printStackTrace();
            lastByte = -1;
        }
    }
}
