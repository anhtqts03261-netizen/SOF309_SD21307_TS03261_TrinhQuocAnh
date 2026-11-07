<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo tổng quan - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .report-header { margin-bottom: 40px; border-bottom: 1px solid #2b2f42; padding-bottom: 20px; }
        
        .stats-container { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; }
        
        .stat-card { 
            background: var(--card-bg); 
            padding: 40px; 
            border-radius: 20px; 
            border: 1px solid #2b2f42;
            text-align: center;
            transition: all 0.3s ease;
        }
        .stat-card:hover { border-color: var(--gold); transform: translateY(-10px); }
        
        .stat-value { font-size: 2.8em; color: var(--text-light); font-weight: 700; margin-bottom: 10px; font-family: 'Playfair Display', serif; }
        .stat-label { color: var(--gold); font-size: 0.9em; text-transform: uppercase; letter-spacing: 2px; font-weight: 600; }
        
        .back-link { color: #888; text-decoration: none; transition: 0.3s; }
        .back-link:hover { color: var(--gold); }
    </style>
</head>
<body>

    <div class="container py-5">
        <div class="report-header">
            <h2>BÁO CÁO TỔNG QUAN</h2>
            <a href="dashboard" class="back-link">&larr; Quay lại Dashboard</a>
        </div>
        
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-value"><fmt:formatNumber value="${totalRevenue}" type="number"/> đ</div>
                <div class="stat-label">Doanh thu tổng</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-value">${totalOrders}</div>
                <div class="stat-label">Đơn hàng hoàn tất</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-value" style="color: #d9534f;">${lowStockCount}</div>
                <div class="stat-label">Nguyên liệu cần nhập</div>
            </div>
        </div>
    </div>

</body>
</html>