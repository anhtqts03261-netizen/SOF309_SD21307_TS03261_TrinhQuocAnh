<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử nhập kho - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; padding: 20px; }
        .table { color: var(--text-light); vertical-align: middle; }
        .table thead { background: var(--gold); color: var(--dark); }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: 600; padding: 5px 15px; }
        .btn-gold:hover { background: #b8962f; }
    </style>
</head>
<body class="p-4">

<div class="container">
    <h2 class="mb-4">Lịch sử nhập kho</h2>

    <div class="card">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Mã phiếu</th>
                    <th>Ngày nhập</th>
                    <th>Người nhập</th>
                    <th>Tổng tiền</th>
                    <th>Chi tiết</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${receipts}" var="r">
                    <tr>
                        <td><strong>PN${r.receiptId}</strong></td>
                        <td><fmt:formatDate value="${r.receiptDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td>${r.user.fullName}</td>
                        <td class="text-warning">
                            <fmt:formatNumber value="${r.totalAmount}" type="number"/> VNĐ
                        </td>
                        <td>
                            <a class="btn btn-sm btn-gold" href="${pageContext.request.contextPath}/admin/receipt/detail?id=${r.receiptId}">
                                Xem
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="mt-4">
        <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/admin/dashboard">← Quay lại Dashboard</a>
    </div>
</div>

</body>
</html>