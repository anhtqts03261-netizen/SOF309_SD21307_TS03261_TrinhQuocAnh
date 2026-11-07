<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu - Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .custom-card { background-color: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; box-shadow: 0 15px 35px rgba(0,0,0,0.5); overflow: hidden; }
        .card-header { background: rgba(212, 175, 55, 0.1) !important; border-bottom: 1px solid rgba(212, 175, 55, 0.2) !important; padding: 20px; text-align: center; }
        .card-header h4 { font-family: 'Playfair Display', serif; color: var(--gold); margin: 0; letter-spacing: 1.5px; text-transform: uppercase; }
        
        .form-label { color: #aaa; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; }
        .custom-input { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: white; padding: 12px; }
        .custom-input:focus { background: rgba(255,255,255,0.08); border-color: var(--gold); box-shadow: none; color: white; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 10px 25px; transition: 0.3s; }
        .btn-gold:hover { background: #f3c63e; }
        .btn-outline-light { border: 1px solid #444; color: #aaa; text-transform: uppercase; padding: 10px 25px; }
        
        .alert { border-radius: 4px; font-size: 14px; }
    </style>
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="custom-card">
                <div class="card-header">
                    <h4><i class="fas fa-lock me-2"></i> Đổi mật khẩu</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/change-password">
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu cũ</label>
                            <input type="password" name="oldPassword" class="form-control custom-input" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu mới</label>
                            <input type="password" name="newPassword" class="form-control custom-input" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Nhập lại mật khẩu</label>
                            <input type="password" name="confirmPassword" class="form-control custom-input" required>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button class="btn btn-gold">Đổi mật khẩu</button>
                            <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-light">Quay lại</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>