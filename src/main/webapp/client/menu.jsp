<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thực đơn - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 40px; }
        
        .menu-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 12px; overflow: hidden; transition: 0.4s; height: 100%; }
        .menu-card:hover { transform: translateY(-10px); box-shadow: 0 15px 30px rgba(0,0,0,0.5); border-color: var(--gold); }
        .menu-img { width: 100%; height: 200px; object-fit: cover; }
        .menu-content { padding: 20px; }
        
        .dish-name { font-family: 'Playfair Display', serif; font-size: 20px; color: var(--text-light); margin-bottom: 5px; }
        .dish-price { color: var(--gold); font-weight: 700; font-size: 16px; }
        .dish-category { color: #888; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; }
        
        .btn-back { border: 1px solid #444; color: #888; text-transform: uppercase; padding: 10px 25px; margin-top: 30px; }
        .btn-back:hover { color: var(--gold); border-color: var(--gold); }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title text-center"><i class="fas fa-utensils me-2"></i> Thực đơn</h2>

    <div class="row g-4">
        <c:forEach items="${dishes}" var="d">
            <div class="col-6 col-md-4 col-lg-3">
                <div class="menu-card">
                    <c:choose>
                        <c:when test="${not empty d.image}">
                            <img src="${pageContext.request.contextPath}/assets/images/menu/${d.image}" class="menu-img" alt="${d.dishName}">
                        </c:when>
                        <c:otherwise>
                            <div class="menu-img d-flex align-items-center justify-content-center" style="background: #1a1e30; color: #444;">
                                <i class="fas fa-image fa-3x"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="menu-content">
                        <div class="dish-category">${d.category}</div>
                        <h5 class="dish-name">${d.dishName}</h5>
                        <div class="dish-price">${d.price} VNĐ</div>
                    </div>
                </div>
            </div>
        </c:forEach>
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