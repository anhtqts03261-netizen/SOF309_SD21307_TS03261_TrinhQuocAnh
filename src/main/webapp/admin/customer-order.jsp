<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .card-header { background: linear-gradient(90deg, var(--gold), #b8962f); color: var(--dark); border-radius: 20px 20px 0 0 !important; font-family: 'Playfair Display', serif; }
        h3, h4 { font-family: 'Playfair Display', serif; }
        .info-label { color: var(--gold); font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; }
        .info-value { font-size: 1.1rem; font-weight: 600; margin-bottom: 15px; }
        .table { color: var(--text-light); }
        .table thead { background: rgba(212, 175, 55, 0.1); color: var(--gold); border-bottom: 2px solid var(--gold); }
        .btn-back { border: 1px solid var(--gold); color: var(--gold); }
        .btn-back:hover { background: var(--gold); color: var(--dark); }
    </style>
</head>
<body class="py-5">

<div class="container">
    <div class="card shadow-lg">
        <div class="card-header p-4">
            <h3 class="mb-0 text-dark">Đơn hàng #${order.orderId}</h3>
        </div>
        <div class="card-body p-4">
            <div class="row">
                <div class="col-md-4"><div class="info-label">Khách hàng</div><div class="info-value">${order.customer.fullName}</div></div>
                <div class="col-md-4"><div class="info-label">SĐT</div><div class="info-value">${order.customer.phone}</div></div>
                <div class="col-md-4"><div class="info-label">Hạng hội viên</div><div class="info-value text-warning">${order.customer.rank}</div></div>
            </div>
            <hr class="border-secondary">
            <div class="row">
                <div class="col-md-4"><div class="info-label">Bàn</div><div class="info-value">${order.restaurantTable.tableName}</div></div>
                <div class="col-md-4"><div class="info-label">Nhân viên phục vụ</div><div class="info-value">${order.user.fullName}</div></div>
                <div class="col-md-4"><div class="info-label">Ngày đặt</div><div class="info-value">${order.orderDate}</div></div>
            </div>
            <hr class="border-secondary">
            <div class="row mb-4">
                <div class="col-md-4"><div class="info-label">Trạng thái</div><div class="info-value">${order.status}</div></div>
                <div class="col-md-4"><div class="info-label">Tổng tiền</div><div class="info-value text-success">${order.totalAmount} VNĐ</div></div>
                <div class="col-md-4"><div class="info-label">Số lượng món</div><div class="info-value">${details.size()}</div></div>
            </div>

            <h4 class="mb-3 text-gold">Danh sách món ăn</h4>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr><th>#</th><th>Món ăn</th><th>SL</th><th>Đơn giá</th><th>Thành tiền</th><th>Trạng thái</th><th>Ghi chú</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${details}" var="d" varStatus="i">
                            <tr>
                                <td>${i.index+1}</td>
                                <td><strong>${d.dish.dishName}</strong></td>
                                <td>${d.quantity}</td>
                                <td>${d.price}</td>
                                <td>${d.quantity*d.price}</td>
                                <td><span class="badge bg-secondary">${d.itemStatus}</span></td>
                                <td><small class="text-muted">${d.note}</small></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="text-end mt-4">
                <h4 class="text-gold">Tổng cộng: ${order.totalAmount} VNĐ</h4>
            </div>
            <hr class="border-secondary">
            <a class="btn btn-back px-4" href="javascript:history.back()">← Quay lại</a>
        </div>
    </div>
</div>

</body>
</html>