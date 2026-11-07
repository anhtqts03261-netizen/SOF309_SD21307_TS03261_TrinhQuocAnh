<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 30px; }
        
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 12px; box-shadow: 0 15px 35px rgba(0,0,0,0.5); padding: 30px; max-width: 500px; margin: 0 auto; }
        
        .form-label { color: #aaa; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; }
        .custom-input { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: var(--text-light); padding: 12px; }
        .custom-input:focus { background: rgba(255,255,255,0.08); border-color: var(--gold); box-shadow: none; color: white; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 12px 25px; transition: 0.3s; width: 100%; }
        .btn-gold:hover { background: #f3c63e; }
        .btn-outline-light { border: 1px solid #444; color: #888; text-transform: uppercase; padding: 12px 25px; width: 100%; }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title text-center"><i class="fas fa-user-edit me-2"></i> Thông tin cá nhân</h2>
    
    <div class="custom-card">
        <form method="post" action="${pageContext.request.contextPath}/client/update-profile">
            <div class="mb-3">
                <label class="form-label">Họ tên</label>
                <input class="form-control custom-input" name="fullName" value="${customer.fullName}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <input class="form-control custom-input" name="phone" value="${customer.phone}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" class="form-control custom-input" name="email" value="${customer.email}">
            </div>
            <div class="mb-4">
                <label class="form-label">Mật khẩu mới (để trống nếu không đổi)</label>
                <input type="password" class="form-control custom-input" name="password" placeholder="••••••••">
            </div>

            <div class="d-grid gap-2">
                <button class="btn btn-gold">
                    <i class="fas fa-save me-2"></i> Cập nhật thông tin
                </button>
                <a href="${pageContext.request.contextPath}/client/home" class="btn btn-outline-light">
                    <i class="fas fa-arrow-left me-2"></i> Quay lại
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>