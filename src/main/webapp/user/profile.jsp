<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .profile-card { background-color: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 12px; box-shadow: 0 20px 40px rgba(0,0,0,0.6); overflow: hidden; }
        .card-header { background: rgba(212, 175, 55, 0.1) !important; border-bottom: 1px solid rgba(212, 175, 55, 0.2) !important; padding: 25px; text-align: center; }
        .card-header h4 { font-family: 'Playfair Display', serif; color: var(--gold); margin: 0; letter-spacing: 2px; text-transform: uppercase; }
        
        .avatar-preview { width: 160px; height: 160px; border-radius: 50%; object-fit: cover; border: 4px solid var(--gold); margin-bottom: 15px; transition: 0.3s; }
        .avatar-box { text-align: center; margin-bottom: 30px; position: relative; }
        
        .form-label { color: #aaa; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; }
        .custom-input { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: white; padding: 12px; border-radius: 4px; }
        .custom-input:focus { background: rgba(255,255,255,0.08); border-color: var(--gold); box-shadow: none; color: white; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 10px 20px; transition: 0.3s; }
        .btn-gold:hover { background: #f3c63e; }
        .btn-outline-gold { border: 1px solid var(--gold); color: var(--gold); text-transform: uppercase; padding: 10px 20px; }
        .btn-outline-gold:hover { background: var(--gold); color: var(--dark-bg); }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="profile-card">
                <div class="card-header"><h4><i class="fas fa-user-circle me-2"></i> Thông tin cá nhân</h4></div>
                <div class="card-body p-4">
                    <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/profile">
                        <div class="avatar-box">
                            <c:choose>
                                <c:when test="${not empty user.avatar}"><img class="avatar-preview" src="${pageContext.request.contextPath}/assets/images/users/${user.avatar}"></c:when>
                                <c:otherwise><img class="avatar-preview" src="https://cdn-icons-png.flaticon.com/512/149/149071.png"></c:otherwise>
                            </c:choose>
                            <input type="file" name="avatar" class="form-control custom-input mt-2" accept="image/*">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control custom-input" value="${user.username}" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" class="form-control custom-input" name="fullName" value="${user.fullName}" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control custom-input" name="email" value="${user.email}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control custom-input" name="phone" value="${user.phone}">
                            </div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="text-muted small">Chức vụ: <b>${user.role}</b></span>
                            <c:choose>
                                <c:when test="${user.isActive}"><span class="badge bg-success">Đang hoạt động</span></c:when>
                                <c:otherwise><span class="badge bg-danger">Đã khóa</span></c:otherwise>
                            </c:choose>
                        </div>

                        <c:if test="${not empty success}"><div class="alert alert-success p-2 small">${success}</div></c:if>
                        <c:if test="${not empty error}"><div class="alert alert-danger p-2 small">${error}</div></c:if>

                        <div class="d-grid gap-2">
                            <button class="btn btn-gold"><i class="fas fa-save me-1"></i> Lưu thay đổi</button>
                            <a href="${pageContext.request.contextPath}/change-password" class="btn btn-outline-gold"><i class="fas fa-key me-1"></i> Đổi mật khẩu</a>
                            <a href="${backUrl}" class="btn btn-outline-secondary btn-sm mt-2"><i class="fas fa-arrow-left me-1"></i> Quay về Dashboard</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.querySelector("input[name='avatar']").addEventListener("change", function(){
        if(this.files.length===0) return;
        const reader = new FileReader();
        reader.onload = e => document.querySelector(".avatar-preview").src = e.target.result;
        reader.readAsDataURL(this.files[0]);
    });
</script>
</body>
</html><%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .profile-card { background-color: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 12px; box-shadow: 0 20px 40px rgba(0,0,0,0.6); overflow: hidden; }
        .card-header { background: rgba(212, 175, 55, 0.1) !important; border-bottom: 1px solid rgba(212, 175, 55, 0.2) !important; padding: 25px; text-align: center; }
        .card-header h4 { font-family: 'Playfair Display', serif; color: var(--gold); margin: 0; letter-spacing: 2px; text-transform: uppercase; }
        
        .avatar-preview { width: 160px; height: 160px; border-radius: 50%; object-fit: cover; border: 4px solid var(--gold); margin-bottom: 15px; transition: 0.3s; }
        .avatar-box { text-align: center; margin-bottom: 30px; position: relative; }
        
        .form-label { color: #aaa; font-size: 12px; text-transform: uppercase; letter-spacing: 1px; }
        .custom-input { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: white; padding: 12px; border-radius: 4px; }
        .custom-input:focus { background: rgba(255,255,255,0.08); border-color: var(--gold); box-shadow: none; color: white; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 10px 20px; transition: 0.3s; }
        .btn-gold:hover { background: #f3c63e; }
        .btn-outline-gold { border: 1px solid var(--gold); color: var(--gold); text-transform: uppercase; padding: 10px 20px; }
        .btn-outline-gold:hover { background: var(--gold); color: var(--dark-bg); }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="profile-card">
                <div class="card-header"><h4><i class="fas fa-user-circle me-2"></i> Thông tin cá nhân</h4></div>
                <div class="card-body p-4">
                    <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/profile">
                        <div class="avatar-box">
                            <c:choose>
                                <c:when test="${not empty user.avatar}"><img class="avatar-preview" src="${pageContext.request.contextPath}/assets/images/users/${user.avatar}"></c:when>
                                <c:otherwise><img class="avatar-preview" src="https://cdn-icons-png.flaticon.com/512/149/149071.png"></c:otherwise>
                            </c:choose>
                            <input type="file" name="avatar" class="form-control custom-input mt-2" accept="image/*">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control custom-input" value="${user.username}" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" class="form-control custom-input" name="fullName" value="${user.fullName}" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control custom-input" name="email" value="${user.email}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control custom-input" name="phone" value="${user.phone}">
                            </div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="text-muted small">Chức vụ: <b>${user.role}</b></span>
                            <c:choose>
                                <c:when test="${user.isActive}"><span class="badge bg-success">Đang hoạt động</span></c:when>
                                <c:otherwise><span class="badge bg-danger">Đã khóa</span></c:otherwise>
                            </c:choose>
                        </div>

                        <c:if test="${not empty success}"><div class="alert alert-success p-2 small">${success}</div></c:if>
                        <c:if test="${not empty error}"><div class="alert alert-danger p-2 small">${error}</div></c:if>

                        <div class="d-grid gap-2">
                            <button class="btn btn-gold"><i class="fas fa-save me-1"></i> Lưu thay đổi</button>
                            <a href="${pageContext.request.contextPath}/change-password" class="btn btn-outline-gold"><i class="fas fa-key me-1"></i> Đổi mật khẩu</a>
                            <a href="${backUrl}" class="btn btn-outline-secondary btn-sm mt-2"><i class="fas fa-arrow-left me-1"></i> Quay về Dashboard</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.querySelector("input[name='avatar']").addEventListener("change", function(){
        if(this.files.length===0) return;
        const reader = new FileReader();
        reader.onload = e => document.querySelector(".avatar-preview").src = e.target.result;
        reader.readAsDataURL(this.files[0]);
    });
</script>
</body>
</html>