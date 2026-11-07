<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang khách hàng - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .header-section { margin-bottom: 40px; text-align: center; }
        .hero-img { width: 100%; height: 250px; object-fit: cover; border-radius: 8px; border: 1px solid var(--gold); margin-bottom: 25px; filter: brightness(0.8); }
        .welcome-text { font-family: 'Playfair Display', serif; color: var(--gold); font-size: 28px; }
        
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; box-shadow: 0 10px 25px rgba(0,0,0,0.4); max-width: 500px; margin: 0 auto; overflow: hidden; }
        
        .list-group-item { background: transparent; border: none; border-bottom: 1px solid rgba(255,255,255,0.05); color: var(--text-light); padding: 18px 25px; transition: 0.3s; font-size: 15px; }
        .list-group-item:hover { background: rgba(212, 175, 55, 0.1); color: var(--gold); padding-left: 35px; }
        .text-danger:hover { color: #dc3545 !important; }
    </style>
</head>
<body>

<div class="container">
    <div class="custom-card">
        <img src="https://images.unsplash.com/photo-1552566626-52f8b828add9?q=80&w=2000&auto=format&fit=crop" 
             alt="Nhà hàng Marcel" class="hero-img">

        <div class="header-section p-3">
            <h2 class="welcome-text">Xin chào, ${sessionScope.customer.fullName}</h2>
            <hr style="border-color: var(--gold); opacity: 0.5;">
        </div>

        <div class="list-group list-group-flush">
            <a class="list-group-item" href="${pageContext.request.contextPath}/client/profile">
                <i class="fas fa-user-circle me-2 text-gold"></i> Hồ sơ cá nhân
            </a>
            <a class="list-group-item" href="${pageContext.request.contextPath}/client/menu">
                <i class="fas fa-utensils me-2 text-gold"></i> Xem Menu
            </a>
            <a class="list-group-item" href="${pageContext.request.contextPath}/client/reservation">
                <i class="fas fa-calendar-alt me-2 text-gold"></i> Đặt bàn
            </a>
            <a class="list-group-item" href="${pageContext.request.contextPath}/client/orders">
                <i class="fas fa-history me-2 text-gold"></i> Lịch sử đơn hàng
            </a>
            <a class="list-group-item" href="${pageContext.request.contextPath}/client/reservations">
                <i class="fas fa-history me-2 text-gold"></i> Lịch sử đặt bàn
            </a>
            <a class="list-group-item" href="${pageContext.request.contextPath}/client/membership">
                <i class="fas fa-gem me-2 text-gold"></i> Hội viên
            </a>
            <a class="list-group-item text-danger" href="${pageContext.request.contextPath}/client/logout">
                <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>