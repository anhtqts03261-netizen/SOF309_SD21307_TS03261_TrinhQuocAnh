package util;

import java.util.Properties;

public class EmailUtil {
    // Hàm khung dùng để cấu hình gửi mail cơ bản
    public static void sendEmail(String toEmail, String subject, String body) {
        // Bạn có thể bổ sung cấu hình SMTP của Gmail tại đây khi cần chạy thực tế
        System.out.println("--- Giả lập gửi Email thành công ---");
        System.out.println("To: " + toEmail);
        System.out.println("Subject: " + subject);
        System.out.println("Body: " + body);
    }
}