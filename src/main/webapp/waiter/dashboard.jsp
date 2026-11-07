<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Waiter Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root {
            --gold: #d4af37;
            --dark-bg: #0a0c16;
            --card-bg: #111424;
            --text-light: #fcfbf7;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--dark-bg);
            color: var(--text-light);
            margin: 0;
            padding: 0;
        }

        /* --- SIDEBAR --- */
        .sidebar {
            width: 260px;
            height: 100vh;
            background: linear-gradient(180deg, rgba(17, 20, 36, 0.95) 0%, rgba(10, 12, 22, 1) 100%);
            position: fixed;
            left: 0;
            top: 0;
            border-right: 1px solid rgba(212, 175, 55, 0.15);
            z-index: 1000;
            overflow-y: auto;
        }

        .sidebar h4 {
            font-family: 'Playfair Display', serif;
            color: var(--gold);
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(212, 175, 55, 0.15);
            margin-bottom: 0;
            font-size: 22px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 18px 25px;
            color: #b0b0b0;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 14px;
            letter-spacing: 1px;
            border-left: 3px solid transparent;
        }

        .sidebar a i {
            margin-right: 15px;
            font-size: 18px;
            transition: 0.3s;
        }

        .sidebar a:hover {
            background: rgba(212, 175, 55, 0.05);
            color: var(--gold);
            border-left: 3px solid var(--gold);
        }

        .sidebar a:hover i {
            color: var(--gold);
        }

        /* --- MAIN CONTENT --- */
        .main {
            margin-left: 260px;
            padding: 40px;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            color: var(--gold);
            margin-bottom: 40px;
            letter-spacing: 1.5px;
            font-weight: 700;
        }

        /* --- DASHBOARD CARDS --- */
        .card {
            background-color: var(--card-bg);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 8px;
            transition: all 0.4s ease;
            height: 100%;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            border-color: rgba(212, 175, 55, 0.3);
        }

        .card-body h5 {
            color: #888;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .card-body h2 {
            font-family: 'Playfair Display', serif;
            font-size: 45px;
            font-weight: 700;
            margin: 0;
            text-shadow: 0 0 15px currentColor;
        }

        /* Tùy chỉnh màu sắc con số */
        .text-success { color: #28a745 !important; }
        .text-danger { color: #dc3545 !important; }
        .text-warning { color: #ffc107 !important; }
        .text-primary { color: #0d6efd !important; }

        /* Nút đăng xuất bottom */
        .btn-bottom-logout {
            margin-top: 50px;
            background: transparent;
            color: #666;
            border: 1px solid #444;
            padding: 10px 30px;
            font-size: 13px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: 0.3s;
        }
        
        .btn-bottom-logout:hover {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border-color: #dc3545;
        }

        /* --- RESPONSIVE CHO IPAD & IPHONE --- */
        @media (max-width: 991px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                display: flex;
                flex-wrap: nowrap;
                overflow-x: auto;
                border-right: none;
                border-bottom: 1px solid rgba(212, 175, 55, 0.15);
                -webkit-overflow-scrolling: touch; /* Hỗ trợ vuốt mượt trên iOS */
            }
            .sidebar h4 {
                display: none; /* Ẩn logo trên mobile để tiết kiệm diện tích */
            }
            .sidebar a {
                padding: 15px 20px;
                border-left: none;
                border-bottom: 3px solid transparent;
                white-space: nowrap;
            }
            .sidebar a:hover {
                border-left: none;
                border-bottom: 3px solid var(--gold);
            }
            .main {
                margin-left: 0;
                padding: 25px 15px;
            }
            .card {
                margin-bottom: 15px;
            }
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h4>
        <i class="bi bi-cup-hot-fill"></i> Marcel
    </h4>
    <a href="${pageContext.request.contextPath}/waiter/dashboard">
        <i class="bi bi-speedometer2"></i> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/profile">
        <i class="bi bi-person-circle"></i> Hồ sơ cá nhân
        </a>
    <a href="${pageContext.request.contextPath}/waiter/reservations">
        <i class="bi bi-calendar-check"></i> Reservation
    </a>
    <a href="${pageContext.request.contextPath}/waiter/tables">
        <i class="bi bi-grid"></i> Tables
    </a>
    <a href="${pageContext.request.contextPath}/logout">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>
</div>

<div class="main">
    <h2 class="page-title">
        <i class="bi bi-speedometer2 me-2"></i> Waiter Dashboard
    </h2>

    <div class="row g-4">
        <div class="col-6 col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h5>Available</h5>
                    <h2 class="text-success">
                        ${availableTables}
                    </h2>
                </div>
            </div>
        </div>
        
        <div class="col-6 col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h5>Occupied</h5>
                    <h2 class="text-danger">
                        ${occupiedTables}
                    </h2>
                </div>
            </div>
        </div>
        
        <div class="col-6 col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h5>Reserved</h5>
                    <h2 class="text-warning">
                        ${reservedTables}
                    </h2>
                </div>
            </div>
        </div>
        
        <div class="col-6 col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h5>Unpaid Orders</h5>
                    <h2 class="text-primary">
                        ${unpaidOrders}
                    </h2>
                </div>
            </div>
        </div>
    </div>

    <a class="btn btn-bottom-logout" href="${pageContext.request.contextPath}/logout">
        <i class="bi bi-power me-2"></i> Đăng xuất
    </a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>