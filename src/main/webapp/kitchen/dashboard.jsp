<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kitchen Dashboard - Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); }
        
        /* Sidebar */
        .sidebar { width: 250px; height: 100vh; background: linear-gradient(180deg, #111424 0%, #0a0c16 100%); position: fixed; border-right: 1px solid rgba(212,175,55,0.2); }
        .sidebar h4 { font-family: 'Playfair Display', serif; color: var(--gold); padding: 25px; letter-spacing: 2px; }
        .sidebar a { color: #aaa; text-decoration: none; display: block; padding: 18px 25px; transition: 0.3s; font-size: 14px; }
        .sidebar a:hover { color: var(--gold); background: rgba(212,175,55,0.05); border-left: 3px solid var(--gold); }
        
        .content { margin-left: 250px; padding: 40px; }
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; margin-bottom: 30px; }
        
        /* Stat Cards */
        .stat-card { background: var(--card-bg); border: 1px solid rgba(212,175,55,0.15); border-radius: 8px; padding: 20px; text-align: center; }
        .stat-val { font-size: 32px; font-weight: 700; margin-top: 10px; }
        
        /* Table */
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212,175,55,0.15); border-radius: 8px; }
        .custom-table { color: var(--text-light); }
        .custom-table thead th { background: rgba(10,12,22,0.9) !important; color: var(--gold) !important; text-transform: uppercase; font-size: 13px; }
        .custom-table tbody td { border-bottom: 1px solid rgba(255,255,255,0.05); vertical-align: middle; }
    </style>
</head>
<body>

<div class="sidebar">
    <h4><i class="fas fa-fire me-2"></i> KITCHEN</h4>
    <a href="${pageContext.request.contextPath}/kitchen/dashboard"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/profile"><i class="bi bi-person-circle me-2"></i> Hồ sơ cá nhân</a>
    <a href="${pageContext.request.contextPath}/kitchen/index"><i class="bi bi-fire me-2"></i> Món đang chế biến</a>
    <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
</div>

<div class="content">
    <h2 class="page-title"><i class="bi bi-speedometer2 me-2"></i> Kitchen Dashboard</h2>

    <div class="row g-4">
        <div class="col-md-4"><div class="stat-card" style="color: #ffc107;"><h5>Pending</h5><div class="stat-val">${pending}</div></div></div>
        <div class="col-md-4"><div class="stat-card" style="color: #0d6efd;"><h5>Preparing</h5><div class="stat-val">${preparing}</div></div></div>
        <div class="col-md-4"><div class="stat-card" style="color: #28a745;"><h5>Completed</h5><div class="stat-val">${completed}</div></div></div>
    </div>

    <div class="custom-card mt-4">
        <div class="card-header p-3 border-bottom border-gold" style="border-color: rgba(212,175,55,0.2) !important;">
            <h5 class="m-0 text-gold" style="color: var(--gold);">Danh sách món cần chế biến</h5>
        </div>
        <div class="table-responsive">
            <table class="table custom-table table-hover align-middle mb-0">
                <thead><tr><th>Order</th><th>Bàn</th><th>Món</th><th>SL</th><th>Ghi chú</th><th>Trạng thái</th></tr></thead>
                <tbody>
                    <c:forEach items="${items}" var="i">
                        <tr>
                            <td>#${i.order.orderId}</td>
                            <td>${i.order.restaurantTable.tableName}</td>
                            <td>${i.dish.dishName}</td>
                            <td>${i.quantity}</td>
                            <td>${i.note}</td>
                            <td><span class="badge bg-warning text-dark">${i.itemStatus}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>