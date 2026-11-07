<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; margin-bottom: 30px; text-transform: uppercase; letter-spacing: 1px; }
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; box-shadow: 0 10px 25px rgba(0,0,0,0.4); padding: 25px; }
        
        .custom-table { color: var(--text-light); }
        .custom-table thead th { background: rgba(10,12,22,0.9) !important; color: var(--gold) !important; text-transform: uppercase; font-size: 13px; }
        .custom-table tbody td { border-bottom: 1px solid rgba(255,255,255,0.05); vertical-align: middle; }
        
        .custom-input { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: var(--text-light); padding: 12px; }
        .custom-input:focus { background: rgba(255,255,255,0.08); border-color: var(--gold); box-shadow: none; color: white; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 12px 25px; }
        .btn-gold:hover { background: #f3c63e; }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title text-center"><i class="fas fa-file-invoice-dollar me-2"></i> Hóa đơn #${order.orderId}</h2>
    
    <div class="custom-card mb-4">
        <div class="row">
            <div class="col-md-6">
                <p><span class="text-secondary">Bàn:</span> <b class="text-white">${order.restaurantTable.tableName}</b></p>
                <p><span class="text-secondary">Thu ngân:</span> <b class="text-white">${sessionScope.user.fullName}</b></p>
            </div>
            <div class="col-md-6 text-md-end">
                <p class="text-secondary">Tổng tiền</p>
                <h3 class="text-gold" style="color: var(--gold);">${order.totalAmount} VNĐ</h3>
            </div>
        </div>
    </div>

    <div class="custom-card mb-4">
        <div class="table-responsive">
            <table class="table custom-table align-middle">
                <thead><tr><th>Món</th><th>SL</th><th>Đơn giá</th><th>Thành tiền</th></tr></thead>
                <tbody>
                    <c:forEach items="${details}" var="d">
                        <tr>
                            <td>${d.dish.dishName}</td>
                            <td>${d.quantity}</td>
                            <td>${d.price} VNĐ</td>
                            <td>${d.quantity * d.price} VNĐ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="custom-card">
        <form method="post" action="${pageContext.request.contextPath}/cashier/payment">
            <input type="hidden" name="orderId" value="${order.orderId}">
            <div class="mb-4">
                <label class="form-label text-gold" style="color: var(--gold);">Phương thức thanh toán</label>
                <select class="form-select custom-input" name="method">
                    <option value="Tiền mặt">Tiền mặt</option>
                    <option value="Chuyển khoản">Chuyển khoản</option>
                    <option value="Thẻ">Thẻ ngân hàng</option>
                </select>
            </div>
            <div class="d-flex gap-2">
                <button class="btn btn-gold flex-fill">Xác nhận thanh toán</button>
                <a href="${pageContext.request.contextPath}/cashier/orders" class="btn btn-outline-secondary px-4">Quay lại</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>