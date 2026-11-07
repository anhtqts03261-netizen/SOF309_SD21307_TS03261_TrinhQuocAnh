<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        
        .sidebar { width: 260px; height: 100vh; background: var(--card-bg); border-right: 1px solid var(--gold); padding: 20px; position: fixed; }
        .sidebar h3 { color: var(--gold); font-family: 'Playfair Display', serif; text-align: center; margin-bottom: 30px; }
        .sidebar a { display: block; color: var(--text-light); padding: 12px 15px; text-decoration: none; border-radius: 8px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar a:hover { background: rgba(212, 175, 55, 0.2); color: var(--gold); }
        .sidebar a i { margin-right: 10px; }
        
        .main-content { margin-left: 260px; padding: 40px; }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; padding: 30px; border-radius: 15px; color: var(--text-light); }
        .logout-btn { position: absolute; bottom: 20px; width: calc(100% - 40px); }
    </style>
</head>
<body>

    <div class="sidebar">
        <h3>MARCEL ADMIN</h3>
        <a href="dashboard"><i class="fas fa-th-large"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-circle"></i> Hồ sơ cá nhân</a>
        <a href="user"><i class="fas fa-users-cog"></i> Quản lý nhân viên</a>
        <a href="menu"><i class="fas fa-utensils"></i> Quản lý thực đơn</a>
        <a href="inventory"><i class="fas fa-boxes"></i> Quản lý kho</a>
        <a href="table"><i class="fas fa-chair"></i> Quản lý bàn</a>
        <a href="member"><i class="fas fa-crown"></i> Quản lý hội viên</a>
        <a href="customers"><i class="fas fa-user-friends"></i> Quản lý khách hàng</a>
        <a href="reservation"><i class="fas fa-calendar-check"></i> Quản lý đặt bàn</a>
        <a href="report"><i class="fas fa-chart-line"></i> Báo cáo</a>
        
        <a class="btn btn-outline-danger logout-btn" href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </a>
    </div>

    <div class="main-content">
        <h1 class="mb-4" style="font-family: 'Playfair Display'; color: var(--gold);">Chào mừng Admin!</h1>
        <div class="card shadow-lg">
            <h3><i class="fas fa-tachometer-alt" style="color: var(--gold);"></i> Thống kê hệ thống</h3>
            <p class="mt-3">Chào mừng bạn trở lại trang quản trị. Mọi dữ liệu nhà hàng đều nằm trong tầm kiểm soát của bạn.</p>
        </div>
    </div>

</body>
</html>