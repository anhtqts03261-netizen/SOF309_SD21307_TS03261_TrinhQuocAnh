<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý kho - Nhà hàng Âu Marcel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card-stat { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; padding: 20px; text-align: center; }
        .card-stat h2 { font-size: 2.5rem; }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: 600; }
        .btn-gold:hover { background: #b8962f; }
        .table { color: var(--text-light); }
        .table thead { background: var(--gold); color: var(--dark); }
        .table-box { background: var(--card-bg); border-radius: 15px; padding: 20px; border: 1px solid #2b2f42; }
    </style>
</head>
<body class="p-4">

<div class="container">
    <h2 class="mb-4"><i class="fas fa-boxes"></i> Quản lý kho nguyên liệu</h2>

    <div class="row g-3 mb-4">
        <div class="col-md-4"><div class="card-stat"><h2>${totalIngredient}</h2><p>Tổng nguyên liệu</p></div></div>
        <div class="col-md-4"><div class="card-stat"><h2 class="text-warning">${lowStock}</h2><p>Sắp hết</p></div></div>
        <div class="col-md-4"><div class="card-stat"><h2 class="text-danger">${outStock}</h2><p>Hết hàng</p></div></div>
    </div>

    <div class="d-flex flex-wrap gap-2 mb-4">
        <input class="form-control w-auto" placeholder="🔍 Tìm nguyên liệu...">
        <a class="btn btn-success" href="${pageContext.request.contextPath}/admin/receipt/add"><i class="fas fa-file-import"></i> Nhập kho</a>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/receipt/history"><i class="fas fa-history"></i> Lịch sử nhập</a>
        <a class="btn btn-gold" href="${pageContext.request.contextPath}/admin/ingredient/add"><i class="fas fa-plus"></i> Thêm mới</a>
        <a class="btn btn-danger" href="${pageContext.request.contextPath}/admin/export-receipt"><i class="fas fa-file-export"></i> Xuất kho</a>
    </div>

    <div class="table-box table-responsive">
        <table class="table table-hover align-middle">
            <thead class="text-uppercase">
                <tr><th>ID</th><th>Tên nguyên liệu</th><th>Số lượng</th><th>Đơn vị</th><th>Tồn tối thiểu</th><th>Trạng thái</th><th>Thao tác</th></tr>
            </thead>
            <tbody>
                <c:forEach items="${ingredients}" var="i">
                    <tr>
                        <td>#${i.ingredientId}</td>
                        <td><strong>${i.ingredientName}</strong></td>
                        <td>${i.quantity}</td>
                        <td>${i.unit}</td>
                        <td>${i.minQuantity}</td>
                        <td>
                            <c:choose>
                                <c:when test="${i.quantity==0}"><span class="badge bg-danger">🔴 Hết hàng</span></c:when>
                                <c:when test="${i.quantity<=i.minQuantity}"><span class="badge bg-warning text-dark">🟡 Sắp hết</span></c:when>
                                <c:otherwise><span class="badge bg-success">🟢 Bình thường</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a class="btn btn-sm btn-outline-warning" href="${pageContext.request.contextPath}/admin/ingredient/edit?id=${i.ingredientId}">Sửa</a>
                            <a class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn chắc chắn muốn xóa?')" href="${pageContext.request.contextPath}/admin/ingredient/delete?id=${i.ingredientId}">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="mt-4"><a href="dashboard" class="text-secondary text-decoration-none">← Quay lại Dashboard</a></div>
</div>

</body>
</html>