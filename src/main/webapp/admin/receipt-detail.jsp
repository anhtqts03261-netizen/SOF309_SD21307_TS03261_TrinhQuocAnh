<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết phiếu nhập - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; padding: 25px; }
        .info-label { color: var(--gold); font-weight: 600; }
        .table { color: var(--text-light); vertical-align: middle; }
        .table thead { background: var(--gold); color: var(--dark); }
        .btn-gold-outline { border: 1px solid var(--gold); color: var(--gold); }
        .btn-gold-outline:hover { background: var(--gold); color: var(--dark); }
    </style>
</head>
<body class="p-4">

<div class="container">
    <h2 class="mb-4">Chi tiết phiếu nhập #<span style="color:var(--gold)">${receipt.receiptId}</span></h2>

    <div class="card mb-4">
        <div class="row">
            <div class="col-md-4 mb-2"><span class="info-label">Ngày nhập:</span> ${receipt.receiptDate}</div>
            <div class="col-md-4 mb-2"><span class="info-label">Người nhập:</span> ${receipt.user.fullName}</div>
            <div class="col-md-4 mb-2"><span class="info-label">Tổng tiền:</span> <fmt:formatNumber value="${receipt.totalAmount}" type="number"/> VNĐ</div>
        </div>
    </div>

    <div class="card">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Nguyên liệu</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${details}" var="d">
                    <tr>
                        <td><strong>${d.ingredient.ingredientName}</strong></td>
                        <td>${d.quantity}</td>
                        <td><fmt:formatNumber value="${d.price}" type="number"/></td>
                        <td><fmt:formatNumber value="${d.quantity * d.price}" type="number"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="mt-4">
        <a class="btn btn-gold-outline" href="${pageContext.request.contextPath}/admin/receipt/history">← Quay lại lịch sử</a>
    </div>
</div>

</body>
</html>