<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách thanh toán - Nhà hàng Marcel</title>
    
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
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; font-size: 13px; text-transform: uppercase; padding: 6px 15px; }
        .btn-gold:hover { background: #f3c63e; }
        .btn-logout { border: 1px solid #dc3545; color: #dc3545; text-transform: uppercase; font-size: 13px; }
        .btn-logout:hover { background: #dc3545; color: white; }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title text-center"><i class="fas fa-receipt me-2"></i> Danh sách yêu cầu thanh toán</h2>
    
    <div class="custom-card">
        <div class="table-responsive">
            <table class="table custom-table table-hover align-middle">
                <thead>
                    <tr>
                        <th>Order</th>
                        <th>Bàn</th>
                        <th>Khách</th>
                        <th>Ngày</th>
                        <th>Tổng tiền</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orders}" var="o">
                        <tr>
                            <td class="fw-bold">#${o.orderId}</td>
                            <td>${o.restaurantTable.tableName}</td>
                            <td>${o.customer != null ? o.customer.fullName : 'Khách lẻ'}</td>
                            <td>${o.orderDate}</td>
                            <td style="color: var(--gold); font-weight: 600;">${o.totalAmount} VNĐ</td>
                            <td>
                                <a class="btn btn-gold btn-sm" href="${pageContext.request.contextPath}/cashier/order-detail?orderId=${o.orderId}">
                                    <i class="fas fa-eye me-1"></i> Xem hóa đơn
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-4 text-center">
        <a class="btn btn-logout" href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt me-1"></i> Đăng xuất
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>