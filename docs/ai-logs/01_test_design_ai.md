# Minh chứng thiết kế với AI
Người nhận bài: Trịnh Quốc Anh · TS03261 · SD21307.

## Ngữ cảnh
Yêu cầu trong cuộc trao đổi: đóng gói dự án PRO230_Restaurant_Management cho repo SOF309_SD21307_TS03261_TrinhQuocAnh, tương tự bộ tuần 1 đã làm trước. AI đã đọc ClientRegisterController, ClientLoginController, LoginController, LoginFilter, TableController, TableAddController, TableEditController, TableDeleteController, các DAO, form và SQL.

## Prompt thiết kế có thể tái sử dụng
Bạn là QA Lead. Dùng docs/SPECIFICATIONS.md của Smart Restaurant làm ngữ cảnh. Áp dụng phân vùng tương đương và giá trị biên để lập Test Plan và Test Cases cho đăng ký, đăng nhập và CRUD bàn. Tách quy tắc có trong mã với đề xuất cần xác nhận. Mỗi ca có bước, dữ liệu, kết quả mong đợi và trạng thái Chưa chạy.

## Kết quả và đối chiếu
Tạo SPECIFICATIONS.md, TEST_PLAN.md, TEST_CASES.md. Kiểm tra đăng nhập khách bằng phone; ADMIN đăng nhập bằng username; giới hạn cột phone 15 và tên bàn 50. Ghi rõ các thiếu sót validation cùng khả năng DAO bỏ qua lỗi.
Sửa SQL thiếu dấu phẩy, bỏ lần thêm trùng IsActive và đoạn reset dữ liệu thử cuối file. Đồng bộ trạng thái form thêm bàn với controller/thống kê.
Việc thực thi test, kiểm tra DB và rà soát kết quả của sinh viên còn cần thực hiện trên máy thật.
