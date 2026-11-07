# Kế hoạch kiểm thử tuần 1
Trịnh Quốc Anh · TS03261 · SD21307

## Mục tiêu và phạm vi
Xác nhận web khởi động, khách đăng ký và đăng nhập được, ADMIN thực hiện CRUD bàn ăn. Thiết kế ca cho controller và UI. Thanh toán, kho, bếp và đặt bàn chuyên sâu ngoài phạm vi tuần 1.

## Chuẩn bị
Eclipse Enterprise Java, JDK 21, Tomcat 10.1/11, SQL Server có database QLNHAHANG_SmartRestaurant. Cấu hình persistence.xml theo máy. Bộ SQL kèm theo dành cho khởi tạo database mới. Dùng dữ liệu thử, mỗi ca đăng ký chọn phone/email duy nhất.
ADMIN mẫu trong SQL mới: admin / 123456. Bàn thử QA-TS03261 phải chưa có đơn hoặc đặt bàn liên quan.

## Kỹ thuật
Phân vùng hợp lệ, rỗng/trắng, trùng và sai xác nhận. Phân tích biên cột SQL bằng 14/15/16 ký tự điện thoại và 49/50/51 ký tự tên bàn. Với sức chứa 0/-1, đánh dấu khảo sát nghiệp vụ. Đối chiếu controller, DAO, entity, JSP và SQL để tránh áp quy tắc chưa có.

## Thực hiện và tiêu chí
Chạy ca thủ công trên giao diện; các ca POST sai tham số phục vụ controller ở tuần 2 hoặc gửi request có session bằng công cụ HTTP. Ghi trạng thái thực tế, ảnh hoặc log khi lỗi. Y1 đạt khi khởi động thành công, đăng ký, đăng nhập và CRUD thành công. Tất cả ca trong bản giao đang Chưa chạy.
