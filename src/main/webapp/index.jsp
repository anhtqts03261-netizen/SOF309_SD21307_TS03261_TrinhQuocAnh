<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

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
            overflow-x: hidden;
        }

        h1, h2, h3, h4, h5, h6, .navbar-brand {
            font-family: 'Playfair Display', serif;
        }

        /* --- NAVBAR --- */
        .navbar {
            background-color: rgba(17, 20, 36, 0.98) !important;
            border-bottom: 1px solid rgba(212, 175, 55, 0.15);
            padding: 15px 0;
            backdrop-filter: blur(10px);
        }
        .navbar-brand {
            font-size: 26px;
            font-weight: 700;
            color: var(--gold) !important;
            letter-spacing: 3px;
            text-transform: uppercase;
        }
        .navbar-brand i {
            margin-right: 10px;
        }
        .btn-staff-login {
            color: var(--gold);
            border: 1px solid var(--gold);
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 1.5px;
            font-weight: 600;
            padding: 8px 20px;
            transition: all 0.3s ease;
        }
        .btn-staff-login:hover {
            background-color: var(--gold);
            color: var(--card-bg);
        }

        /* --- HERO BANNER --- */
        .hero {
            background: linear-gradient(rgba(10, 12, 22, 0.85), rgba(10, 12, 22, 0.85)),
                        url('https://images.unsplash.com/photo-1414235077428-338989a2e8c0?q=80&w=2000&auto=format&fit=crop') center/cover no-repeat fixed;
            padding: 160px 20px 120px;
            text-align: center;
            border-bottom: 1px solid rgba(212, 175, 55, 0.1);
        }
        .hero h1 {
            font-size: 4rem;
            font-weight: 700;
            color: var(--gold);
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 4px;
            animation: fadeInDown 1s ease-out;
        }
        .hero p {
            font-size: 1.3rem;
            font-style: italic;
            color: #d1d1d1;
            margin-bottom: 40px;
            letter-spacing: 1px;
            animation: fadeInUp 1s ease-out;
        }
        .btn-gold {
            background-color: var(--gold);
            color: var(--card-bg);
            border: 1px solid var(--gold);
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 2px;
            font-weight: 600;
            padding: 14px 35px;
            transition: all 0.4s ease;
            margin: 5px;
        }
        .btn-gold:hover {
            background: transparent;
            color: var(--gold);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(212, 175, 55, 0.2);
        }
        .btn-outline-light-custom {
            background: transparent;
            color: var(--text-light);
            border: 1px solid var(--text-light);
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 2px;
            font-weight: 600;
            padding: 14px 35px;
            transition: all 0.4s ease;
            margin: 5px;
        }
        .btn-outline-light-custom:hover {
            background: var(--text-light);
            color: var(--card-bg);
            transform: translateY(-3px);
        }

        /* --- SECTION TITLES --- */
        .section-title {
            color: var(--gold);
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 50px;
            font-weight: 700;
            font-size: 32px;
            position: relative;
            display: inline-block;
        }
        .section-title::after {
            content: '';
            position: absolute;
            width: 50px;
            height: 2px;
            background-color: var(--gold);
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
        }

        /* --- RESTAURANT SPACE IMAGE --- */
        .restaurant-img-container {
            border: 1px solid rgba(212, 175, 55, 0.2);
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
        }
        .restaurant-img {
            height: 500px;
            width: 100%;
            object-fit: cover;
            filter: brightness(0.7);
            transition: transform 0.8s ease, filter 0.8s ease;
        }
        .restaurant-img-container:hover .restaurant-img {
            transform: scale(1.05);
            filter: brightness(1);
        }

        /* --- SERVICES (DỊCH VỤ) --- */
        .service-box {
            padding: 40px 20px;
            background: rgba(17, 20, 36, 0.6);
            border: 1px solid rgba(255, 255, 255, 0.05);
            height: 100%;
            transition: all 0.3s ease;
        }
        .service-box:hover {
            border-color: var(--gold);
            background: rgba(212, 175, 55, 0.05);
            transform: translateY(-5px);
        }
        .service-icon {
            font-size: 45px;
            color: var(--gold);
            margin-bottom: 25px;
        }
        .service-title {
            font-size: 15px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--text-light);
        }

        /* --- FOOTER --- */
        footer {
            background-color: var(--card-bg);
            border-top: 1px solid rgba(212, 175, 55, 0.2);
            padding: 60px 0 40px;
            margin-top: 80px;
        }
        footer h4 {
            color: var(--gold);
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 25px;
        }
        footer p {
            color: #a0a0a0;
            font-size: 14px;
            margin-bottom: 12px;
            letter-spacing: 0.5px;
        }
        footer i {
            color: var(--gold);
            width: 25px;
        }

        /* Animations */
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-utensils"></i> Restaurant Management
            </a>
            <div>
                <a class="btn btn-staff-login" href="${pageContext.request.contextPath}/login">
                    <i class="fas fa-user-shield me-2"></i> Đăng nhập nhân viên
                </a>
            </div>
        </div>
    </nav>

    <section class="hero">
        <div class="container">
            <h1>Restaurant Management</h1>
            <p>Nơi hội tụ tinh hoa ẩm thực</p>
            <div class="mt-4">
                <a class="btn btn-gold" href="${pageContext.request.contextPath}/client/login">
                    Đăng nhập khách hàng
                </a>
                <a class="btn btn-outline-light-custom" href="${pageContext.request.contextPath}/client/register">
                    Đăng ký thẻ thành viên
                </a>
            </div>
        </div>
    </section>

    <div class="container mt-5 pt-5">
        <div class="text-center">
            <h2 class="section-title">Không Gian Nhà Hàng</h2>
        </div>
        
        <div class="row mt-4">
            <div class="col-12">
                <div class="restaurant-img-container">
                    <img src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=2000&auto=format&fit=crop" 
                         alt="Không gian nhà hàng Âu sang trọng" 
                         class="restaurant-img">
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-5 pt-5 mb-5">
        <div class="text-center">
            <h2 class="section-title">Dịch Vụ</h2>
        </div>
        
        <div class="row text-center mt-3 g-4">
            <div class="col-md-3 col-sm-6">
                <div class="service-box">
                    <div class="service-icon"><i class="far fa-calendar-check"></i></div>
                    <div class="service-title">Đặt bàn Online</div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="service-box">
                    <div class="service-icon"><i class="fas fa-gem"></i></div>
                    <div class="service-title">Hội viên tích điểm</div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="service-box">
                    <div class="service-icon"><i class="fas fa-credit-card"></i></div>
                    <div class="service-title">Thanh toán nhanh</div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="service-box">
                    <div class="service-icon"><i class="fas fa-concierge-bell"></i></div>
                    <div class="service-title">Phục vụ chuyên nghiệp</div>
                </div>
            </div>
        </div>
    </div>

    <footer class="text-center">
        <div class="container">
            <h4>Restaurant Management</h4>
            <p><i class="fas fa-map-marker-alt"></i> Địa chỉ: Hồ Chí Minh</p>
            <p><i class="fas fa-phone-alt"></i> Hotline: 0384 705 048</p>
            <p><i class="fas fa-envelope"></i> Email: restaurant@gmail.com</p>
            
            <div class="mt-4" style="color: #666; font-size: 12px; font-family: 'Montserrat', sans-serif;">
                &copy; 2026 Restaurant Management. All Rights Reserved.
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>