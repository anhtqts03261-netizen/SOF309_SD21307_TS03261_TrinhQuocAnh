<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đơn hàng - Nhà hàng Marcel</title>
    
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
        
        .badge { font-weight: 500; padding: 6px 10px; border-radius: 4px; text-transform: uppercase; font-size: 11px; }
        .btn-gold-outline { border: 1px solid var(--gold); color: var(--gold); padding: 5px 15px; font-size: 12px; transition: 0.3s; }
        .btn-gold-outline:hover { background: var(--gold); color: var(--dark-bg); }
        
        .btn-back { border: 1px solid #444; color: #888; text-transform: uppercase; padding: 10px 25px; margin-top: 25px; }
        .btn-back:hover { color: var(--gold); border-color: var(--gold); }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title text-center"><i class="fas fa-history me-2"></i> Lịch sử đơn hàng</h2>
    
    <div class="custom-card">
        <div class="table-responsive">
            <table class="table custom-table table-hover align-middle">
                <thead>
                    <tr>
                        <th>Mã</th>
                        <th>Ngày</th>
                        <th>Bàn</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orders}" var="o">
                        <tr>
                            <td class="fw-bold">#${o.orderId}</td>
                            <td>${o.orderDate}</td>
                            <td>${o.restaurantTable.tableName}</td>
                            <td style="color: var(--gold);">${o.totalAmount} VNĐ</td>
                            <td><span class="badge bg-secondary">${o.status}</span></td>
                            <td>
                                <a class="btn btn-gold-outline" href="${pageContext.request.contextPath}/client/order-detail?orderId=${o.orderId}">
                                    <i class="fas fa-eye me-1"></i> Chi tiết
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="text-center">
        <a href="${pageContext.request.contextPath}/client/home" class="btn btn-back">
            <i class="fas fa-arrow-left me-2"></i> Quay lại
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>