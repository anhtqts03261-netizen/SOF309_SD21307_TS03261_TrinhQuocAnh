<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Phiếu nhập kho - Nhà hàng Âu Marcel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; padding: 20px; }
        .form-control, .form-select { background: #1a1e33; border: 1px solid #2b2f42; color: var(--text-light); }
        .table { color: var(--text-light); vertical-align: middle; }
        .table thead { background: var(--gold); color: var(--dark); }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: 600; }
        .btn-gold:hover { background: #b8962f; }
        .total-box { color: var(--gold); font-size: 1.5rem; font-weight: 600; }
    </style>
</head>
<body class="p-4">

<div class="container">
    <h2 class="mb-4">Phiếu nhập kho</h2>

    <!-- Form Thêm -->
    <div class="card mb-4">
        <form method="post">
            <div class="row align-items-end g-3">
                <div class="col-md-4">
                    <label>Nguyên liệu</label>
                    <select name="ingredientId" class="form-select">
                        <c:forEach items="${ingredients}" var="i">
                            <option value="${i.ingredientId}">${i.ingredientName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <label>Số lượng</label>
                    <input name="quantity" type="number" step="0.1" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label>Đơn giá</label>
                    <input name="price" type="number" step="1000" class="form-control" required>
                </div>
                <div class="col-md-2">
                    <button class="btn btn-gold w-100">Thêm</button>
                </div>
            </div>
        </form>
    </div>

    <!-- Bảng danh sách -->
    <div class="card mb-4">
        <table class="table table-hover">
            <thead>
                <tr><th>Tên nguyên liệu</th><th>SL</th><th>Đơn giá</th><th>Thành tiền</th><th>Xóa</th></tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty cart}">
                        <tr><td colspan="5" class="text-center text-muted">Chưa có nguyên liệu</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${cart}" var="d" varStatus="status">
                            <tr>
                                <td>${d.ingredient.ingredientName}</td>
                                <td>${d.quantity}</td>
                                <td><fmt:formatNumber value="${d.price}" type="number"/></td>
                                <td><fmt:formatNumber value="${d.quantity * d.price}" type="number"/></td>
                                <td>
                                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/receipt/deleteItem?index=${status.index}">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="d-flex justify-content-between align-items-center">
        <div class="total-box">
            Tổng tiền: <fmt:formatNumber value="${total}" type="number"/> VNĐ
        </div>
        <form action="${pageContext.request.contextPath}/admin/receipt/save" method="post">
            <button class="btn btn-lg btn-gold">Lưu phiếu nhập</button>
        </form>
    </div>
</div>

</body>
</html>