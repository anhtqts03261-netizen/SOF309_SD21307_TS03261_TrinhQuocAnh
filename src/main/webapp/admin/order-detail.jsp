<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt món - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2, h3 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; color: var(--text-light); padding: 20px; }
        .table { color: var(--text-light); vertical-align: middle; }
        .table thead { color: var(--gold); border-bottom: 1px solid var(--gold); }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: bold; }
        .btn-gold:hover { background: #b8962f; }
        .total-box { border-top: 2px solid var(--gold); padding-top: 15px; color: var(--gold); font-size: 1.5rem; }
    </style>
</head>
<body class="p-4">

<h2 class="mb-4">
    <i class="bi bi-shop"></i> Bàn: ${order.restaurantTable.tableName}
</h2>

<div class="row g-4">
    <!-- Menu -->
    <div class="col-lg-7">
        <div class="card h-100">
            <h3>Danh sách món</h3>
            <table class="table table-hover">
                <thead>
                    <tr><th>Món</th><th>Giá</th><th class="text-center">Thao tác</th></tr>
                </thead>
                <tbody>
                    <c:forEach items="${dishes}" var="d">
                        <tr>
                            <td>${d.dishName}</td>
                            <td>${d.price} đ</td>
                            <td class="text-center">
                                <!-- Lưu ý: Thay href="#" bằng controller xử lý add món của bạn -->
                                <a class="btn btn-sm btn-gold" href="?action=add&dishId=${d.dishId}">+</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Hóa đơn tạm tính -->
    <div class="col-lg-5">
        <div class="card h-100">
            <h3>Món đã gọi</h3>
            <table class="table">
                <thead>
                    <tr><th>Món</th><th>SL</th><th>Tiền</th></tr>
                </thead>
                <tbody>
                    <c:forEach items="${order.orderDetails}" var="od">
                        <tr>
                            <td>${od.dish.dishName}</td>
                            <td>${od.quantity}</td>
                            <td>${od.quantity * od.price} đ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="total-box mt-auto">
                <strong>Tổng: ${order.totalAmount} VNĐ</strong>
            </div>
            <a class="btn btn-outline-light mt-3" href="list">Hoàn tất / Quay lại</a>
        </div>
    </div>
</div>

</body>
</html>