<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        
        .register-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 12px; box-shadow: 0 20px 40px rgba(0,0,0,0.6); padding: 40px; width: 100%; max-width: 500px; }
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); text-align: center; margin-bottom: 30px; letter-spacing: 2px; text-transform: uppercase; }
        
        .form-label { color: #aaa; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; }
        .custom-input { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: var(--text-light); padding: 12px; }
        .custom-input:focus { background: rgba(255,255,255,0.08); border-color: var(--gold); box-shadow: none; color: white; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 12px; width: 100%; transition: 0.3s; }
        .btn-gold:hover { background: #f3c63e; }
    </style>
</head>
<body>

<div class="register-card">
    <h2 class="page-title"><i class="fas fa-user-plus me-2"></i> Đăng ký</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" style="background: rgba(220,53,69,0.1); border-color: rgba(220,53,69,0.3); color: #ff6b6b;">
            <i class="fas fa-exclamation-triangle me-2"></i> ${error}
        </div>
    </c:if>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">Họ tên</label>
            <input type="text" class="form-control custom-input" name="fullName" required placeholder="Họ và tên của bạn">
        </div>
        <div class="mb-3">
            <label class="form-label">Số điện thoại</label>
            <input type="text" class="form-control custom-input" name="phone" required placeholder="Số điện thoại">
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control custom-input" name="email" required placeholder="Địa chỉ email">
        </div>
        <div class="mb-3">
            <label class="form-label">Mật khẩu</label>
            <input type="password" class="form-control custom-input" name="password" required placeholder="Mật khẩu">
        </div>
        <div class="mb-4">
            <label class="form-label">Xác nhận mật khẩu</label>
            <input type="password" class="form-control custom-input" name="confirmPassword" required placeholder="Nhập lại mật khẩu">
        </div>

        <button class="btn btn-gold">
            <i class="fas fa-check-circle me-2"></i> Đăng ký tài khoản
        </button>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/login" style="color: #666; text-decoration: none; font-size: 13px;">
                Đã có tài khoản? Đăng nhập ngay
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>