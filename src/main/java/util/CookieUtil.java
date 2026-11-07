package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;

public class CookieUtil {

    // Tạo và gửi cookie về client
    public static void create(HttpServletResponse response, String name, String value, int maxAgeInSeconds) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAgeInSeconds);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    // Đọc giá trị từ cookie bằng tên
    public static String read(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    return cookie.getValue();
                }
            }
        }
        return "";
    }

    // Xóa cookie khỏi client
    public static void delete(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}