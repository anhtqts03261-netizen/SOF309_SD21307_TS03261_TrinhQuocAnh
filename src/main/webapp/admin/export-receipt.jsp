<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử xuất kho - Nhà hàng Âu Marcel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); border-bottom: 2px solid var(--gold); display: inline-block; padding-bottom: 10px; }
        .table-container { background: var(--card-bg); padding: 25px; border-radius: 15px; border: 1px solid #2b2f42; }
        .table { color: var(--text-light); border-color: #2b2f42; }
        .table thead { background: var(--gold); color: var(--dark); }
        .table tbody tr:hover { background: rgba(212, 175, 55, 0.05); }
        .badge-id { font-weight: bold; color: var(--gold); }
    </style>
</head>
<body class="p-4">

<div class="container">
    <h2 class="mb-4">📤 Lịch sử xuất kho</h2>

    <div class="table-container table-responsive">
        <table class="table table-hover align-middle">
            <thead class="text-uppercase">
                <tr>
                    <th>Mã</th>
                    <th>Ngày xuất</th>
                    <th>Order</th>
                    <th>Nguyên liệu</th>
                    <th>Số lượng</th>
                    <th>Ghi chú</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="e">
                    <tr>
                        <td class="badge-id">#${e.exportId}</td>
                        <td>${e.exportDate}</td>
                        <td><span class="text-info">#${e.order.orderId}</span></td>
                        <td><strong>${e.ingredient.ingredientName}</strong></td>
                        <td>${e.quantity} <small>${e.ingredient.unit}</small></td>
                        <td class="text-muted">${e.note}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>