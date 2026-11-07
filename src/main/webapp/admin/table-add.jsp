<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm bàn - Marcel Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; }
        
        .box { width: 500px; background: var(--card-bg); padding: 40px; border-radius: 20px; border: 1px solid #2b2f42; box-shadow: 0 15px 30px rgba(0,0,0,0.5); }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); margin-bottom: 30px; border-bottom: 1px solid #2b2f42; padding-bottom: 15px; }
        
        label { display: block; margin-top: 15px; color: var(--gold); font-size: 0.85em; font-weight: 600; }
        input, select { width: 100%; padding: 12px; margin-top: 5px; background: #1a1e33; border: 1px solid #2b2f42; color: var(--text-light); border-radius: 10px; box-sizing: border-box; }
        input:focus, select:focus { border-color: var(--gold); outline: none; }
        
        button { margin-top: 30px; background: var(--gold); color: var(--dark); border: none; padding: 12px 25px; border-radius: 10px; font-weight: 600; cursor: pointer; transition: 0.3s; width: 100%; }
        button:hover { background: #b8962f; }
        
        .back { display: block; text-align: center; margin-top: 15px; color: #888; text-decoration: none; font-size: 0.9em; }
        .back:hover { color: var(--gold); }
    </style>
</head>
<body>

<div class="box">
    <h2>➕ Thêm bàn mới</h2>
    <form method="post">
        <label>Tên bàn</label>
        <input name="tableName" placeholder="Ví dụ: Bàn 01 - View cửa sổ" required>

        <label>Sức chứa</label>
        <input type="number" name="capacity" placeholder="Số lượng khách tối đa" required>

        <label>Trạng thái</label>
        <select name="status">
            <option value="EMPTY">Trống</option>
            <option value="RESERVED">Đặt trước</option>
            <option value="SERVING">Có khách</option>
        </select>

        <button type="submit">Lưu thông tin</button>
        <a class="back" href="${pageContext.request.contextPath}/admin/table">Quay lại danh sách</a>
    </form>
</div>

</body>
</html>