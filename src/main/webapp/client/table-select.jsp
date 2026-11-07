<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn bàn - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); text-align: center; margin-bottom: 40px; letter-spacing: 2px; text-transform: uppercase; }
        
        .table-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 12px; padding: 25px; transition: 0.3s; height: 100%; text-align: center; }
        .table-card:hover { border-color: var(--gold); transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.3); }
        .table-name { font-family: 'Playfair Display', serif; font-size: 24px; color: var(--gold); margin-bottom: 10px; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 10px 25px; width: 100%; transition: 0.3s; }
        .btn-gold:hover { background: #f3c63e; }
        .btn-outline-light { border: 1px solid #444; color: #888; text-transform: uppercase; padding: 10px 25px; }
    </style>
</head>
<body>

<c:if test="${sessionScope.customer == null}"><c:redirect url="/client/login"/></c:if>

<div class="container">
    <h2 class="page-title"><i class="fas fa-chair me-2"></i> Chọn bàn phù hợp</h2>

    <c:choose>
        <c:when test="${empty tables}">
            <div class="text-center mt-5">
                <h3 class="text-secondary">Hiện không có bàn trống</h3>
                <p class="mb-4">Xin lỗi, hệ thống không tìm thấy bàn phù hợp với yêu cầu của bạn.</p>
                <a href="${pageContext.request.contextPath}/client/reservation" class="btn btn-outline-light">← Quay lại</a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="row g-4">
                <c:forEach items="${tables}" var="table">
                    <div class="col-6 col-md-3">
                        <div class="table-card">
                            <div class="table-name">${table.tableName}</div>
                            <div class="text-muted mb-3"><i class="fas fa-users me-1"></i> Sức chứa: ${table.capacity} người</div>
                            
                            <form method="post" action="${pageContext.request.contextPath}/client/select-table">
                                <input type="hidden" name="tableId" value="${table.tableId}">
                                <input type="hidden" name="guestCount" value="${guestCount}">
                                <input type="hidden" name="reservationTime" value="${reservationTime}">
                                <button type="submit" class="btn btn-gold">Chọn bàn này</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="text-center mt-5">
        <a href="${pageContext.request.contextPath}/client/reservation" class="btn btn-outline-light">
            <i class="fas fa-arrow-left me-2"></i> Quay lại
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>