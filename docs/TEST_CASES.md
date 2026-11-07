# Bộ ca kiểm thử Smart Restaurant
Trịnh Quốc Anh · TS03261 · SD21307

Dùng phone/email mới cho mỗi ca đăng ký hợp lệ. Chuỗi CRUD thực hiện theo thứ tự trên bàn riêng. Các kết quả ghi dưới đây là mong đợi hoặc điểm cần xác minh, chưa được thực thi.

| ID | Chức năng | Tầng | Kỹ thuật | Các bước | Dữ liệu | Kết quả mong đợi | Trạng thái |
|---|---|---|---|---|---|---|---|
| TC001 | Đăng ký | UI | Hợp lệ | Mở /client/register, điền form, gửi | QA Anh; 0988032610; qa03261@example.com; Abc123!; xác nhận trùng | Chuyển login; Customer được tạo và hạng BRONZE | Chưa chạy |
| TC002 | Đăng ký | Controller | Không hợp lệ | POST /client/register với các ô còn lại hợp lệ | fullName rỗng hoặc toàn khoảng trắng | Hiện Vui lòng nhập đầy đủ thông tin; không tạo bản ghi | Chưa chạy |
| TC003 | Đăng ký | Controller | Không hợp lệ | POST /client/register với các ô còn lại hợp lệ | phone rỗng hoặc toàn khoảng trắng | Hiện Vui lòng nhập đầy đủ thông tin; không tạo bản ghi | Chưa chạy |
| TC004 | Đăng ký | Controller | Không hợp lệ | POST /client/register với các ô còn lại hợp lệ | email rỗng hoặc toàn khoảng trắng | Hiện Vui lòng nhập đầy đủ thông tin; không tạo bản ghi | Chưa chạy |
| TC005 | Đăng ký | Controller | Không hợp lệ | POST /client/register với các ô còn lại hợp lệ | password rỗng hoặc toàn khoảng trắng | Hiện Vui lòng nhập đầy đủ thông tin; không tạo bản ghi | Chưa chạy |
| TC006 | Đăng ký | UI | Không hợp lệ | Gửi form có xác nhận sai | password=Abc123!, confirmPassword=Abc123? | Báo mật khẩu xác nhận không khớp | Chưa chạy |
| TC007 | Đăng ký | Controller/UI | Trùng | Gửi dữ liệu với phone đã có; ô còn lại hợp lệ | phone của khách mẫu | Báo Số điện thoại đã tồn tại | Chưa chạy |
| TC008 | Đăng ký | Controller/UI | Trùng | Gửi dữ liệu với email đã có; ô còn lại hợp lệ | email của khách mẫu | Báo Email đã tồn tại | Chưa chạy |
| TC009 | Đăng ký | UI | Định dạng | Nhập email sai rồi gửi | email=abc | Trình duyệt chặn email không hợp lệ | Chưa chạy |
| TC010 | Đăng ký | Controller | Biên SQL | POST với phone mới dài n, email mới và các ô hợp lệ | 14 chữ số | 14/15 có thể lưu theo ràng buộc hiện tại; 16 vượt cột SQL, không lưu. Kiểm tra DB vì DAO nuốt lỗi | Chưa chạy |
| TC011 | Đăng ký | Controller | Biên SQL | POST với phone mới dài n, email mới và các ô hợp lệ | 15 chữ số | 14/15 có thể lưu theo ràng buộc hiện tại; 16 vượt cột SQL, không lưu. Kiểm tra DB vì DAO nuốt lỗi | Chưa chạy |
| TC012 | Đăng ký | Controller | Biên SQL | POST với phone mới dài n, email mới và các ô hợp lệ | 16 chữ số | 14/15 có thể lưu theo ràng buộc hiện tại; 16 vượt cột SQL, không lưu. Kiểm tra DB vì DAO nuốt lỗi | Chưa chạy |
| TC013 | Đăng ký | Controller | Thiếu tham số | POST bỏ hẳn fullName | không gửi fullName | Yêu cầu chất lượng: xử lý lỗi đầu vào; mã hiện tại có nguy cơ NPE, ghi lỗi thực tế | Chưa chạy |
| TC014 | Đăng nhập khách | UI | Hợp lệ | Đăng nhập sau khi tạo khách | phone và password vừa tạo | Session customer; chuyển /client/home | Chưa chạy |
| TC015 | Đăng nhập khách | UI | Sai mật khẩu | Đăng nhập bằng phone đã có | password sai | Hiện Sai số điện thoại hoặc mật khẩu | Chưa chạy |
| TC016 | Đăng nhập khách | UI | Chưa tồn tại | Đăng nhập phone mới | phone chưa có | Hiện thông báo sai thông tin | Chưa chạy |
| TC017 | ADMIN | UI | Hợp lệ | Mở /login và đăng nhập | admin / 123456 trong database mới | Chuyển /admin/dashboard | Chưa chạy |
| TC018 | Phân quyền | Controller/UI | Không được phép | Mở /admin/table bằng khách hoặc chưa login | session không có ADMIN | Chuyển /login | Chưa chạy |
| TC019 | Thêm bàn | UI | Hợp lệ | ADMIN mở /admin/table/add, lưu | QA-TS03261; 4; EMPTY | Bàn xuất hiện, tăng thống kê bàn trống | Chưa chạy |
| TC020 | Xem bàn | UI | Hợp lệ | Tải lại /admin/table | Bàn vừa thêm | Tên, sức chứa và trạng thái đúng | Chưa chạy |
| TC021 | Sửa bàn | UI | Hợp lệ | Chọn sửa bàn vừa tạo, lưu | QA-TS03261-B; 6; vị trí QA; EMPTY; active=true | Cùng ID cập nhật, dữ liệu tồn tại sau tải lại | Chưa chạy |
| TC022 | Thêm bàn | Controller | Biên SQL | POST /admin/table/add dưới session ADMIN | tableName=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA; capacity=4; status=EMPTY | 49/50 lưu; 51 vượt cột, không tạo bàn; kiểm tra DB và console | Chưa chạy |
| TC023 | Thêm bàn | Controller | Biên SQL | POST /admin/table/add dưới session ADMIN | tableName=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA; capacity=4; status=EMPTY | 49/50 lưu; 51 vượt cột, không tạo bàn; kiểm tra DB và console | Chưa chạy |
| TC024 | Thêm bàn | Controller | Biên SQL | POST /admin/table/add dưới session ADMIN | tableName=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA; capacity=4; status=EMPTY | 49/50 lưu; 51 vượt cột, không tạo bàn; kiểm tra DB và console | Chưa chạy |
| TC025 | Thêm bàn | Controller | Biên khảo sát | Gửi bàn thử mới | capacity=-1 | Ghi hiện trạng; cần xác nhận yêu cầu sức chứa >0. Mã hiện tại chưa chặn số không dương | Chưa chạy |
| TC026 | Thêm bàn | Controller | Biên khảo sát | Gửi bàn thử mới | capacity=0 | Ghi hiện trạng; cần xác nhận yêu cầu sức chứa >0. Mã hiện tại chưa chặn số không dương | Chưa chạy |
| TC027 | Thêm bàn | Controller | Biên khảo sát | Gửi bàn thử mới | capacity=1 | Ghi hiện trạng; cần xác nhận yêu cầu sức chứa >0. Mã hiện tại chưa chặn số không dương | Chưa chạy |
| TC028 | Thêm bàn | UI | Bắt buộc | Bỏ tên rồi bấm lưu | tableName rỗng | Trình duyệt yêu cầu nhập | Chưa chạy |
| TC029 | Thêm bàn | Controller | Sai kiểu | POST capacity không phải số | capacity=abc | Mong đợi xử lý lỗi thân thiện; hiện có nguy cơ NumberFormatException | Chưa chạy |
| TC030 | Xóa bàn | UI | Bị chặn | Đổi bàn thử sang SERVING, yêu cầu xóa | ID bàn thử | Chuyển ?error=serving; bàn vẫn còn | Chưa chạy |
| TC031 | Xóa bàn | UI | Hợp lệ | Đổi bàn thử sang EMPTY, xóa rồi tải lại | Bàn thử không có liên kết | Bàn bị xóa khỏi database và danh sách | Chưa chạy |
| TC032 | Xóa bàn | Controller | Không tồn tại | Gọi delete với ID không tồn tại | ID xác minh chưa có | Quay danh sách | Chưa chạy |
