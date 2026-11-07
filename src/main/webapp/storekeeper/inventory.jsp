<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách tồn kho - Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 30px; }
        
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; box-shadow: 0 10px 25px rgba(0,0,0,0.4); padding: 20px; }
        
        .custom-table { color: var(--text-light); border-color: rgba(255,255,255,0.05); }
        .custom-table thead th { background: rgba(10,12,22,0.9) !important; color: var(--gold) !important; text-transform: uppercase; font-size: 13px; letter-spacing: 1px; }
        .custom-table tbody td { border-bottom: 1px solid rgba(255,255,255,0.05); vertical-align: middle; }
        
        .badge { font-weight: 500; padding: 6px 12px; border-radius: 20px; font-size: 12px; }
        .bg-danger-soft { background: rgba(220, 53, 69, 0.15); color: #ff6b6b; }
        .bg-success-soft { background: rgba(40, 167, 69, 0.15); color: #51cf66; }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title"><i class="fas fa-boxes me-2"></i> Danh sách tồn kho</h2>
    
    <div class="custom-card">
        <div class="table-responsive">
            <table class="table custom-table table-hover align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nguyên liệu</th>
                        <th>Số lượng</th>
                        <th>Đơn vị</th>
                        <th>Mức tối thiểu</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${ingredients}" var="i">
                        <tr>
                            <td>${i.ingredientId}</td>
                            <td class="fw-semibold">${i.ingredientName}</td>
                            <td>${i.quantity}</td>
                            <td>${i.unit}</td>
                            <td>${i.minQuantity}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${i.quantity <= i.minQuantity}">
                                        <span class="badge bg-danger-soft"><i class="fas fa-exclamation-circle me-1"></i> Sắp hết</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success-soft"><i class="fas fa-check-circle me-1"></i> Đủ</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
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