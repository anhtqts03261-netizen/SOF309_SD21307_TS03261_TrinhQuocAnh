<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập khách hàng - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        
        .login-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; box-shadow: 0 15px 35px rgba(0,0,0,0.5); padding: 40px; width: 100%; max-width: 450px; }
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); text-align: center; margin-bottom: 30px; letter-spacing: 2px; text-transform: uppercase; }
        
        .form-label { color: #aaa; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; }
        .custom-input { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: var(--text-light); padding: 12px; }
        .custom-input:focus { background: rgba(255,255,255,0.08); border-color: var(--gold); box-shadow: none; color: white; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 12px; width: 100%; transition: 0.3s; }
        .btn-gold:hover { background: #f3c63e; }
        .alert { font-size: 14px; }
    </style>
</head>
<body>

<div class="login-card">
    <h2 class="page-title"><i class="fas fa-sign-in-alt me-2"></i> Đăng nhập</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" style="background: rgba(220,53,69,0.1); border-color: rgba(220,53,69,0.3); color: #ff6b6b;">
            <i class="fas fa-exclamation-circle me-2"></i> ${error}
        </div>
    </c:if>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">Số điện thoại</label>
            <input type="text" class="form-control custom-input" name="phone" required placeholder="Nhập SĐT của bạn">
        </div>
        <div class="mb-4">
            <label class="form-label">Mật khẩu</label>
            <input type="password" class="form-control custom-input" name="password" required placeholder="Nhập mật khẩu">
        </div>
        
        <button class="btn btn-gold">
            <i class="fas fa-arrow-right me-2"></i> Đăng nhập
        </button>
        
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/" style="color: #666; text-decoration: none; font-size: 13px;">
                <i class="fas fa-home me-1"></i> Quay về trang chủ
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>