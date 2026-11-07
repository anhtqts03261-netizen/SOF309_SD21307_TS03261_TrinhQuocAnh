# Đặc tả Smart Restaurant
Trịnh Quốc Anh · TS03261 · SD21307

## Môi trường và đường dẫn
Java 21 theo pom.xml gốc, Maven WAR, Jakarta Servlet 6, JSP/JSTL, JPA/Hibernate và SQL Server. Dùng Tomcat 10.1 hoặc 11 với JDK 21.
URL dự kiến: http://localhost:8080/PRO230_Restaurant_Management. Kiểm tra context thực tế trong Eclipse.

| Chức năng | URL | Dữ liệu và hành vi theo mã nguồn |
|---|---|---|
| Đăng ký khách | /client/register | fullName, phone, email, password bắt buộc khác rỗng/trắng; confirmPassword phải trùng. Kiểm tra trùng phone trước email. Thành công tạo Customer hạng BRONZE và chuyển /client/login. |
| Đăng nhập khách | /client/login | phone và password được đối chiếu bằng CustomerDAO. Sai hiện lỗi trên trang; đúng lưu session customer và chuyển /client/home. |
| Đăng nhập nhân sự | /login | username, password. Tài khoản bị khóa bị chặn; ADMIN chuyển /admin/dashboard, lưu session user. |
| Danh sách bàn | /admin/table | ADMIN được LoginFilter cho phép. Hiển thị các bàn và thống kê EMPTY, SERVING, RESERVED. |
| Thêm bàn | /admin/table/add | tableName, capacity dạng số nguyên, status. Form bắt buộc tên và sức chứa. Tên lưu trong NVARCHAR(50). Trạng thái form đã đồng bộ EMPTY, SERVING, RESERVED. |
| Sửa bàn | /admin/table/edit?id=... | GET nạp bàn. POST tableId, tableName, capacity, position, status, isActive. Lưu rồi về danh sách. |
| Xóa bàn | /admin/table/delete?id=... | Bàn SERVING bị chặn với error=serving. Bàn thử chưa có tham chiếu được xóa vật lý. Mã không tồn tại quay về danh sách. |

## Ràng buộc thực tế cần phân biệt khi thiết kế ca
- Customers: Phone NVARCHAR(15), FullName NVARCHAR(100), Email NVARCHAR(100), Password NVARCHAR(256).
- Giao diện đăng ký dùng type=email. Controller chưa kiểm tra định dạng email, độ dài mật khẩu hay quy tắc điện thoại 10 chữ số.
- Capacity chưa có giới hạn dương trong form và controller. Các ca 0/-1 là thăm dò yêu cầu nghiệp vụ, cần xác nhận với giảng viên.
- DAO insert/update/delete hiện ghi lỗi ra console rồi bỏ qua ngoại lệ. Sau chuyển trang phải kiểm tra bản ghi thật trong database.
- POST thiếu tham số đăng ký có thể gây NullPointerException tại isBlank. ID/capacity sai định dạng có thể gây NumberFormatException. Ghi đây là lỗi cần xử lý khi kiểm thử.
