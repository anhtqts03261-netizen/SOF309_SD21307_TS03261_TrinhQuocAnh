<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Restaurant Management</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --gold: #d4af37;
            --dark-bg: #0a0c16;
            --card-bg: rgba(17, 20, 36, 0.85);
            --text-light: #fcfbf7;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(rgba(10, 12, 22, 0.8), rgba(10, 12, 22, 0.9)),
                        url('https://images.unsplash.com/photo-1514933651103-005eec06c04b?q=80&w=1934&auto=format&fit=crop') center/cover no-repeat fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: var(--text-light);
            backdrop-filter: blur(5px);
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            background-color: var(--card-bg);
            padding: 50px 40px;
            border-radius: 4px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.6);
            text-align: center;
            border: 1px solid rgba(212, 175, 55, 0.2);
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(15px);
        }

        /* Hiệu ứng viền vàng trang trí ở trên cùng card */
        .login-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--gold);
        }

        .brand-icon {
            font-size: 32px;
            color: var(--gold);
            margin-bottom: 10px;
        }

        h2 { 
            font-family: 'Playfair Display', serif;
            color: var(--gold); 
            margin-bottom: 35px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .input-group-custom {
            position: relative;
            margin-bottom: 25px;
        }

        .input-group-custom i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            transition: 0.3s;
        }

        .input-group-custom input {
            width: 100%;
            padding: 14px 15px 14px 45px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: white;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .input-group-custom input::placeholder {
            color: #888;
            font-weight: 300;
        }

        .input-group-custom input:focus {
            outline: none;
            border-color: var(--gold);
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 10px rgba(212, 175, 55, 0.1);
        }

        .input-group-custom input:focus + i,
        .input-group-custom input:valid + i {
            color: var(--gold);
        }

        .btn-login {
            background-color: var(--gold);
            color: #111;
            border: none;
            width: 100%;
            padding: 14px;
            margin-top: 10px;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            border-radius: 4px;
            transition: all 0.4s ease;
            font-size: 14px;
        }

        .btn-login:hover {
            background-color: #f3c63e;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(212, 175, 55, 0.3);
        }

        .back-link {
            display: block;
            margin-top: 25px;
            color: #888;
            font-size: 13px;
            text-decoration: none;
            transition: 0.3s;
        }

        .back-link:hover {
            color: var(--gold);
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="brand-icon">
            <i class="fas fa-utensils"></i>
        </div>
        <h2>ĐĂNG NHẬP</h2>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="input-group-custom">
                <input type="text" name="username" placeholder="Tên đăng nhập" required>
                <i class="fas fa-user"></i>
            </div>
            
            <div class="input-group-custom">
                <input type="password" name="password" placeholder="Mật khẩu" required>
                <i class="fas fa-lock"></i>
            </div>
            
            <button type="submit" class="btn-login">ĐĂNG NHẬP</button>
        </form>
        
        <a href="${pageContext.request.contextPath}/" class="back-link">
            <i class="fas fa-arrow-left me-1"></i> Quay lại Trang chủ
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>