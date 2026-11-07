<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hội viên - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 30px; }
        
        .membership-card { background: linear-gradient(135deg, #111424 0%, #0a0c16 100%); border: 1px solid var(--gold); border-radius: 15px; padding: 40px; box-shadow: 0 20px 40px rgba(0,0,0,0.5); max-width: 500px; margin: 0 auto; text-align: center; }
        
        .rank-badge { font-family: 'Playfair Display', serif; font-size: 24px; color: var(--gold); margin-bottom: 20px; }
        .info-row { display: flex; justify-content: space-between; padding: 15px 0; border-bottom: 1px solid rgba(212, 175, 55, 0.1); font-size: 16px; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 12px 30px; width: 100%; transition: 0.3s; margin-top: 20px; }
        .btn-gold:hover { background: #f3c63e; }
        .btn-outline-light { border: 1px solid #444; color: #888; text-transform: uppercase; padding: 10px 30px; margin-top: 10px; width: 100%; }
        
        .badge { font-weight: 500; padding: 6px 12px; border-radius: 20px; text-transform: uppercase; }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title text-center"><i class="fas fa-gem me-2"></i> Hội viên</h2>
    
    <div class="membership-card">
        <div class="rank-badge"><i class="fas fa-crown me-2"></i> Hạng: ${customer.rank}</div>
        
        <div class="info-row">
            <span>Họ tên:</span>
            <b class="text-white">${customer.fullName}</b>
        </div>
        
        <div class="info-row">
            <span>Trạng thái:</span>
            <c:choose>
                <c:when test="${customer.isMember}">
                    <span class="badge bg-success">Đã đăng ký</span>
                </c:when>
                <c:otherwise>
                    <span class="badge bg-danger">Chưa đăng ký</span>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${!customer.isMember}">
            <form method="post">
                <button class="btn btn-gold">
                    <i class="fas fa-star me-2"></i> Đăng ký hội viên
                </button>
            </form>
        </c:if>

        <a href="${pageContext.request.contextPath}/client/home" class="btn btn-outline-light">
            <i class="fas fa-arrow-left me-1"></i> Quay lại
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>