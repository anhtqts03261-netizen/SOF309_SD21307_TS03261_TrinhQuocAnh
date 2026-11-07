<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khách đặt bàn - Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; }
        
        .custom-card { background-color: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.15); border-radius: 8px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.4); padding: 25px; }
        
        .custom-table { color: var(--text-light); border-color: rgba(255, 255, 255, 0.05); }
        .custom-table thead th { background: rgba(10,12,22,0.8) !important; color: var(--gold) !important; text-transform: uppercase; font-size: 13px; letter-spacing: 1px; }
        .custom-table tbody td { border-bottom: 1px solid rgba(255, 255, 255, 0.05); vertical-align: middle; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; font-size: 12px; text-transform: uppercase; padding: 6px 15px; }
        .btn-outline-light { border: 1px solid #444; color: #aaa; font-size: 13px; text-transform: uppercase; }
        
        .badge { font-weight: 500; padding: 6px 12px; border-radius: 20px; }
    </style>
</head>
<body>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="page-title"><i class="fas fa-calendar-check me-2"></i> Khách đặt bàn hôm nay</h3>
        <a href="${pageContext.request.contextPath}/waiter/dashboard" class="btn btn-outline-light">
            <i class="fas fa-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <c:choose>
        <c:when test="${empty reservations}">
            <div class="alert alert-warning" style="background: rgba(255,193,7,0.1); border-color: rgba(255,193,7,0.3); color: #ffc107;">
                <i class="fas fa-info-circle me-2"></i> Hôm nay chưa có khách đặt bàn.
            </div>
        </c:when>
        <c:otherwise>
            <div class="custom-card">
                <div class="table-responsive">
                    <table class="table custom-table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>ID</th><th>Giờ đặt</th><th>Khách hàng</th><th>SĐT</th>
                                <th>Bàn</th><th>Số khách</th><th>Trạng thái</th><th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${reservations}" var="r">
                                <tr>
                                    <td>${r.reservationId}</td>
                                    <td><fmt:formatDate value="${r.reservationTime}" pattern="HH:mm"/></td>
                                    <td>${r.customerName}</td>
                                    <td>${r.phone}</td>
                                    <td>Bàn ${r.restaurantTable.tableNumber}</td>
                                    <td>${r.guestCount}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.status=='CONFIRMED'}"><span class="badge bg-success text-dark">Đã xác nhận</span></c:when>
                                            <c:when test="${r.status=='COMPLETED'}"><span class="badge bg-primary">Đã nhận khách</span></c:when>
                                            <c:otherwise><span class="badge bg-secondary">${r.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a class="btn btn-sm btn-outline-light" href="${pageContext.request.contextPath}/waiter/reservation-detail?id=${r.reservationId}">Xem</a>
                                        <c:if test="${r.status=='CONFIRMED'}">
                                            <a class="btn btn-sm btn-gold" href="${pageContext.request.contextPath}/waiter/checkin-reservation?id=${r.reservationId}" onclick="return confirm('Khách đã đến?');">Nhận khách</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>