<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý bàn - Marcel Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; padding: 30px; }
        
        .title { font-family: 'Playfair Display', serif; color: var(--gold); font-size: 32px; margin-bottom: 30px; }
        
        /* Dashboard Stats */
        .dashboard { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 40px; }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; padding: 20px; text-align: center; }
        .card h2 { color: var(--text-light); font-size: 2.5em; margin: 0; }
        .card p { color: var(--gold); text-transform: uppercase; font-size: 0.8em; letter-spacing: 1px; margin-top: 5px; }

        /* Grid & Table Cards */
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 20px; }
        .table-card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; padding: 20px; text-align: center; transition: 0.3s; }
        .table-card:hover { border-color: var(--gold); }
        .table-number { font-size: 24px; font-weight: bold; color: var(--gold); margin-bottom: 10px; }
        .info { color: #aaa; font-size: 0.9em; margin: 5px 0; }
        
        /* Status Badges */
        .status { font-size: 0.7em; padding: 4px 12px; border-radius: 12px; color: var(--dark); font-weight: 600; text-transform: uppercase; }
        .empty { background: #2ecc71; }
        .serving { background: #e74c3c; }
        .reserved { background: #3498db; }
        
        /* Buttons */
        .btn { padding: 8px 15px; border-radius: 5px; text-decoration: none; font-size: 12px; font-weight: 600; transition: 0.3s; }
        .btn-gold { background: var(--gold); color: var(--dark); }
        .btn-gold:hover { background: #b8962f; }
        .btn-outline { border: 1px solid #2b2f42; color: #888; }
        .btn-outline:hover { border-color: var(--gold); color: var(--gold); }
    </style>
</head>
<body>

<div class="container">
    <div class="title">🪑 Quản lý bàn</div>

    <div class="dashboard">
        <div class="card"><h2>${totalTable}</h2><p>Tổng số bàn</p></div>
        <div class="card"><h2>${available}</h2><p>Bàn trống</p></div>
        <div class="card"><h2>${occupied}</h2><p>Đang phục vụ</p></div>
        <div class="card"><h2>${reserved}</h2><p>Đặt trước</p></div>
    </div>

    <div class="d-flex justify-content-between mb-4">
        <a href="dashboard" class="btn btn-outline">&larr; Quay lại</a>
        <a class="btn btn-gold" href="${pageContext.request.contextPath}/admin/table/add">➕ Thêm bàn</a>
    </div>

    <div class="grid">
        <c:forEach items="${tables}" var="t">
            <div class="table-card">
                <div class="table-number">${t.tableName}</div>
                <div class="info">👥 ${t.capacity} người</div>
                <div class="info">📍 ${t.position}</div>
                
                <div class="mt-2 mb-3">
                    <c:choose>
                        <c:when test="${t.status=='EMPTY'}"><span class="status empty">Trống</span></c:when>
                        <c:when test="${t.status=='SERVING'}"><span class="status serving">Đang phục vụ</span></c:when>
                        <c:when test="${t.status=='RESERVED'}"><span class="status reserved">Đặt trước</span></c:when>
                    </c:choose>
                    <c:if test="${!t.isActive}"><br><small style="color:red">Ngưng sử dụng</small></c:if>
                </div>

                <div class="d-flex justify-content-center gap-2">
                    <a class="btn btn-outline" href="${pageContext.request.contextPath}/admin/table/detail?id=${t.tableId}">Xem</a>
                    <a class="btn btn-outline" href="${pageContext.request.contextPath}/admin/table/edit?id=${t.tableId}">Sửa</a>
                    <a class="btn btn-outline" style="color:#e74c3c" onclick="return confirm('Xóa bàn?')" href="${pageContext.request.contextPath}/admin/table/delete?id=${t.tableId}">Xóa</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>