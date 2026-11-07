<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 30px; }
        
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.4); padding: 25px; }
        
        .custom-table { color: var(--text-light); }
        .custom-table thead th { background: rgba(10,12,22,0.9) !important; color: var(--gold) !important; text-transform: uppercase; font-size: 13px; letter-spacing: 1px; }
        .custom-table tbody td { border-bottom: 1px solid rgba(255,255,255,0.05); vertical-align: middle; }
        
        .total-amount { font-family: 'Playfair Display', serif; font-size: 24px; color: var(--gold); font-weight: 700; }
        .btn-back { border: 1px solid #444; color: #888; text-transform: uppercase; padding: 10px 25px; margin-top: 20px; }
        .btn-back:hover { color: var(--gold); border-color: var(--gold); }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title text-center"><i class="fas fa-file-invoice me-2"></i> Chi tiết đơn hàng #${order.orderId}</h2>
    
    <div class="custom-card">
        <div class="table-responsive">
            <table class="table custom-table table-hover align-middle">
                <thead>
                    <tr>
                        <th>Món</th>
                        <th>Số lượng</th>
                        <th>Giá</th>
                        <th>Thành tiền</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${details}" var="d">
                        <tr>
                            <td class="fw-semibold">${d.dish.dishName}</td>
                            <td>${d.quantity}</td>
                            <td>${d.price} VNĐ</td>
                            <td>${d.quantity * d.price} VNĐ</td>
                            <td><span class="badge bg-secondary">${d.itemStatus}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div class="text-end mt-4">
            <h4 class="total-amount">Tổng tiền: ${order.totalAmount} VNĐ</h4>
        </div>
    </div>

    <div class="text-center">
        <a href="${pageContext.request.contextPath}/client/orders" class="btn btn-back">
            <i class="fas fa-arrow-left me-2"></i> Quay lại lịch sử
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>