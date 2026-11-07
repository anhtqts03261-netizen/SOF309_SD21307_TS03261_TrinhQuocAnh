<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hội viên - Nhà hàng Âu Marcel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .table-container { background: var(--card-bg); padding: 20px; border-radius: 15px; border: 1px solid #2b2f42; }
        .table { color: var(--text-light); }
        .table thead { background: var(--gold); color: var(--dark); }
        .form-control { background: #1a1e33; border: 1px solid #2b2f42; color: var(--text-light); }
        .btn-gold { background: var(--gold); color: var(--dark); font-weight: 600; }
        .btn-gold:hover { background: #b8962f; }
        .badge { font-size: 0.75rem; }
    </style>
</head>
<body class="p-4">

<div class="container">
    <h2 class="mb-4">Quản lý hội viên</h2>

    <div class="d-flex justify-content-between mb-4 flex-wrap gap-2">
        <form class="d-flex gap-2">
            <input class="form-control" name="keyword" placeholder="Tên hoặc SĐT...">
            <button class="btn btn-gold">Tìm kiếm</button>
        </form>
        <div class="d-flex gap-2">
            <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a class="btn btn-outline-warning" href="${pageContext.request.contextPath}/admin/customer-order">📋 Quản lý đơn bàn</a>
        </div>
    </div>

    <div class="table-container table-responsive">
        <table class="table table-hover align-middle">
            <thead class="text-uppercase">
                <tr>
                    <th>ID</th><th>Họ tên</th><th>SĐT</th><th>Email</th>
                    <th>Hội viên</th><th>Hạng</th><th>Tổng chi</th><th>Trạng thái</th><th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${customers}" var="c">
                    <tr>
                        <td>#${c.customerId}</td>
                        <td><strong>${c.fullName}</strong></td>
                        <td>${c.phone}</td>
                        <td>${c.email}</td>
                        <td>
                            <c:choose>
                                <c:when test="${c.isMember}"><span class="badge bg-success">Có</span></c:when>
                                <c:otherwise><span class="badge bg-secondary">Không</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-warning fw-bold">${c.rank}</td>
                        <td>${c.totalSpent}</td>
                        <td>
                            <c:choose>
                                <c:when test="${c.isActive}"><span class="badge bg-success">Hoạt động</span></c:when>
                                <c:otherwise><span class="badge bg-danger">Đã khóa</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a class="btn btn-sm btn-outline-light" href="${pageContext.request.contextPath}/admin/customer-edit?id=${c.customerId}">Chi tiết</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>