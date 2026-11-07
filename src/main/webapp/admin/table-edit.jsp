<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa bàn - Marcel Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; }
        
        .box { width: 550px; background: var(--card-bg); padding: 40px; border-radius: 20px; border: 1px solid #2b2f42; box-shadow: 0 15px 30px rgba(0,0,0,0.5); }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); margin-bottom: 30px; border-bottom: 1px solid #2b2f42; padding-bottom: 15px; }
        
        label { display: block; margin-top: 15px; color: var(--gold); font-size: 0.85em; font-weight: 600; }
        input, select { width: 100%; padding: 12px; margin-top: 5px; background: #1a1e33; border: 1px solid #2b2f42; color: var(--text-light); border-radius: 10px; box-sizing: border-box; }
        input:focus, select:focus { border-color: var(--gold); outline: none; }
        
        .actions { margin-top: 30px; display: flex; gap: 10px; }
        button { background: var(--gold); color: var(--dark); border: none; padding: 12px 25px; border-radius: 10px; font-weight: 600; cursor: pointer; transition: 0.3s; flex: 1; }
        button:hover { background: #b8962f; }
        
        .btn-back { background: #1a1e33; color: var(--text-light); text-decoration: none; padding: 12px 25px; border-radius: 10px; font-weight: 600; text-align: center; border: 1px solid #2b2f42; }
        .btn-back:hover { border-color: var(--gold); color: var(--gold); }
    </style>
</head>
<body>

<div class="box">
    <h2>✏️ Sửa thông tin bàn #${table.tableId}</h2>
    <form method="post">
        <input type="hidden" name="tableId" value="${table.tableId}">

        <label>Tên bàn</label>
        <input name="tableName" value="${table.tableName}" required>

        <label>Sức chứa</label>
        <input type="number" name="capacity" value="${table.capacity}" required>

        <label>Vị trí</label>
        <input name="position" value="${table.position}">

        <label>Trạng thái</label>
        <select name="status">
            <option value="EMPTY" ${table.status=='EMPTY'?'selected':''}>Trống</option>
            <option value="SERVING" ${table.status=='SERVING'?'selected':''}>Đang phục vụ</option>
            <option value="RESERVED" ${table.status=='RESERVED'?'selected':''}>Đặt trước</option>
        </select>

        <label>Hoạt động</label>
        <select name="isActive">
            <option value="true" ${table.isActive?'selected':''}>Đang sử dụng</option>
            <option value="false" ${!table.isActive?'selected':''}>Ngưng sử dụng</option>
        </select>

        <div class="actions">
            <button type="submit">💾 Lưu thay đổi</button>
            <a class="btn-back" href="${pageContext.request.contextPath}/admin/table">Quay lại</a>
        </div>
    </form>
</div>

</body>
</html>