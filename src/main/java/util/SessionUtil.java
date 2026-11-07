package util;

import jakarta.servlet.http.HttpServletRequest;

public class SessionUtil {
    
    public static void addAttribute(HttpServletRequest request, String name, Object value) {
        request.getSession().setAttribute(name, value);
    }

    public static Object getAttribute(HttpServletRequest request, String name) {
        return request.getSession().getAttribute(name);
    }

    public static void removeAttribute(HttpServletRequest request, String name) {
        request.getSession().removeAttribute(name);
    }

    public static void invalidate(HttpServletRequest request) {
        request.getSession().invalidate();
    }
}