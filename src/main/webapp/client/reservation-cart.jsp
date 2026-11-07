<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ món - Nhà hàng Marcel</title>
    
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
        
        .total-box { font-family: 'Playfair Display', serif; font-size: 28px; color: var(--gold); border-top: 1px solid rgba(212,175,55,0.2); padding-top: 20px; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 12px 25px; transition: 0.3s; }
        .btn-gold:hover { background: #f3c63e; }
        .btn-outline-gold { border: 1px solid var(--gold); color: var(--gold); text-transform: uppercase; padding: 12px 25px; }
        .btn-outline-gold:hover { background: var(--gold); color: var(--dark-bg); }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title text-center"><i class="fas fa-shopping-basket me-2"></i> Giỏ món</h2>
    
    <div class="custom-card">
        <div class="table-responsive">
            <table class="table custom-table table-hover align-middle">
                <thead>
                    <tr>
                        <th>Món</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="total" value="0"/>
                    <c:forEach items="${sessionScope.reservationCart}" var="item">
                        <tr>
                            <td class="fw-semibold">${item.dish.dishName}</td>
                            <td>${item.quantity}</td>
                            <td>${item.dish.price} VNĐ</td>
                            <td style="color: var(--gold); font-weight: 600;">${item.total} VNĐ</td>
                        </tr>
                        <c:set var="total" value="${total + item.total}"/>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="total-box text-end mt-3">
            Tổng tiền: ${total} VNĐ
        </div>
    </div>

    <div class="d-grid gap-3 mt-4 text-center">
        <a class="btn btn-outline-gold" href="${pageContext.request.contextPath}/client/reservation-menu">
            <i class="fas fa-plus me-2"></i> Thêm món khác
        </a>
        <form method="post"
		      action="${pageContext.request.contextPath}/client/reservation-confirm">
		
		    <button type="submit"
		            class="btn btn-gold w-100">
		
		        <i class="fas fa-check-circle me-2"></i>
		
		        Xác nhận đặt bàn
		
		    </button>
		
		</form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>