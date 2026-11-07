<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cashier Dashboard - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); }
        
        /* Sidebar */
        .sidebar { width: 250px; height: 100vh; background: linear-gradient(180deg, #111424 0%, #0a0c16 100%); position: fixed; border-right: 1px solid rgba(212,175,55,0.2); }
        .sidebar h3 { font-family: 'Playfair Display', serif; color: var(--gold); padding: 25px; letter-spacing: 2px; }
        .sidebar a { color: #aaa; text-decoration: none; display: block; padding: 18px 25px; transition: 0.3s; font-size: 14px; }
        .sidebar a:hover { color: var(--gold); background: rgba(212,175,55,0.05); border-left: 3px solid var(--gold); }
        
        .content { margin-left: 250px; padding: 40px; }
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; margin-bottom: 30px; }
        
        /* Stats */
        .stat-card { background: var(--card-bg); border: 1px solid rgba(212,175,55,0.15); border-radius: 8px; padding: 25px; transition: 0.3s; }
        .stat-val { font-size: 28px; font-weight: 700; color: var(--gold); margin-top: 5px; }
        
        /* Table */
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212,175,55,0.15); border-radius: 8px; }
        .custom-table { color: var(--text-light); }
        .custom-table thead th { background: rgba(10,12,22,0.9) !important; color: var(--gold) !important; text-transform: uppercase; font-size: 13px; }
        .custom-table tbody td { border-bottom: 1px solid rgba(255,255,255,0.05); vertical-align: middle; }
        
        .btn-gold-sm { background: var(--gold); color: var(--dark-bg); font-weight: 600; padding: 5px 15px; font-size: 13px; }
    </style>
</head>
<body>

<div class="sidebar">
    <h3>CASHIER</h3>
    <a href="${pageContext.request.contextPath}/cashier/dashboard"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-circle me-2"></i> Hồ sơ cá nhân</a>
    <a href="${pageContext.request.contextPath}/cashier/order-detail"><i class="fas fa-receipt me-2"></i> Thanh toán</a>
    <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Đăng xuất</a>
</div>

<div class="content">
    <h2 class="page-title"><i class="fas fa-cash-register me-2"></i> Cashier Dashboard</h2>

    <div class="row g-4 mb-4">
        <div class="col-md-6"><div class="stat-card"><h5>Doanh thu hôm nay</h5><div class="stat-val">${todayRevenue} VNĐ</div></div></div>
        <div class="col-md-6"><div class="stat-card"><h5>Hóa đơn chờ</h5><div class="stat-val" style="color: #ff4d4d;">${unpaidCount}</div></div></div>
    </div>

    <div class="custom-card">
        <div class="card-header p-3 border-bottom border-gold" style="border-color: rgba(212,175,55,0.2) !important;">
            <h5 class="m-0 text-gold" style="color: var(--gold);">Danh sách hóa đơn chờ thanh toán</h5>
        </div>
        <div class="table-responsive">
            <table class="table custom-table table-hover align-middle mb-0">
                <thead><tr><th>Mã HD</th><th>Bàn</th><th>Khách hàng</th><th>Ngày</th><th>Tổng tiền</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
                <tbody>
                    <c:forEach items="${orders}" var="o">
                        <tr>
                            <td class="fw-bold">#${o.orderId}</td>
                            <td>${o.restaurantTable.tableName}</td>
                            <td>${o.customer != null ? o.customer.fullName : 'Khách lẻ'}</td>
                            <td>${o.orderDate}</td>
                            <td>${o.totalAmount} VNĐ</td>
                            <td><span class="badge bg-warning text-dark">${o.status}</span></td>
                            <td><a class="btn btn-gold-sm" href="${pageContext.request.contextPath}/cashier/payment?orderId=${o.orderId}">Thanh toán</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>