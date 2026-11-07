<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo phiếu nhập - Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 30px; }
        
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; box-shadow: 0 10px 25px rgba(0,0,0,0.4); padding: 30px; max-width: 600px; margin: 0 auto; }
        
        .form-label { color: #aaa; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; }
        .custom-select { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: var(--text-light); padding: 12px; }
        .custom-select:focus { border-color: var(--gold); background: rgba(255,255,255,0.08); box-shadow: none; color: var(--text-light); }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 10px 25px; transition: 0.3s; }
        .btn-gold:hover { background: #f3c63e; }
        .btn-outline-light { border: 1px solid #444; color: #aaa; text-transform: uppercase; padding: 10px 25px; }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title text-center"><i class="fas fa-file-import me-2"></i> Tạo phiếu nhập</h2>
    
    <div class="custom-card">
        <form method="post">
            <div class="mb-4">
                <label class="form-label">Loại phiếu</label>
                <select class="form-select custom-select" name="type">
                    <option value="IMPORT">Nhập kho</option>
                    <option value="RETURN">Hàng trả</option>
                    <option value="ADJUST">Điều chỉnh</option>
                </select>
            </div>
            
            <div class="d-flex gap-2">
                <button class="btn btn-gold flex-fill">
                    <i class="fas fa-save me-2"></i> Lưu phiếu
                </button>
                <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/storekeeper/receipt">
                    <i class="fas fa-times me-2"></i> Hủy
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>