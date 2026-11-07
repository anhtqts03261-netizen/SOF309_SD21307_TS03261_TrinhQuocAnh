<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - StoreKeeper</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 30px; }
        
        .stat-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; padding: 25px; text-align: center; transition: 0.3s; }
        .stat-card:hover { border-color: var(--gold); transform: translateY(-5px); }
        .stat-number { font-size: 40px; font-weight: 700; color: var(--gold); margin-top: 10px; }
        
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; overflow: hidden; margin-top: 30px; }
        .custom-card .card-header { background: rgba(220, 53, 69, 0.1); border-bottom: 1px solid rgba(220, 53, 69, 0.3); color: #ff4d4d; padding: 15px 20px; font-weight: 600; }
        
        .custom-table { color: var(--text-light); margin-bottom: 0; }
        .custom-table thead th { background: rgba(10, 12, 22, 0.9) !important; color: var(--gold) !important; text-transform: uppercase; font-size: 13px; }
        .custom-table tbody td { border-bottom: 1px solid rgba(255,255,255,0.05); }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 8px 20px; }
        .btn-outline-gold { border: 1px solid var(--gold); color: var(--gold); text-transform: uppercase; padding: 8px 20px; }
    </style>
</head>
<body>
<div class="container">
    <h2 class="page-title"><i class="fas fa-boxes me-2"></i> Dashboard Nhân viên kho</h2>
    
    <div class="row g-4">
        <div class="col-md-4"><div class="stat-card"><h5>Tổng nguyên liệu</h5><div class="stat-number">${totalIngredient}</div></div></div>
        <div class="col-md-4"><div class="stat-card"><h5>Sắp hết</h5><div class="stat-number" style="color: #ff4d4d;">${lowStock}</div></div></div>
        <div class="col-md-4"><div class="stat-card"><h5>Phiếu nhập</h5><div class="stat-number" style="color: #28a745;">${totalReceipt}</div></div></div>
    </div>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/storekeeper/inventory" class="btn btn-gold">Quản lý kho</a>
        <a href="${pageContext.request.contextPath}/storekeeper/receipt" class="btn btn-outline-gold">Phiếu nhập</a>
    </div>

    <div class="custom-card">
        <div class="card-header"><i class="fas fa-exclamation-triangle me-2"></i> Cảnh báo nguyên liệu sắp hết</div>
        <div class="card-body p-0">
            <c:choose>
                <c:when test="${empty lowStockList}">
                    <div class="p-4 text-success"><i class="fas fa-check-circle me-2"></i> Tất cả nguyên liệu đều đủ số lượng.</div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table custom-table table-hover">
                            <thead><tr><th>STT</th><th>Tên nguyên liệu</th><th>Tồn kho</th><th>Mức tối thiểu</th><th>Đơn vị</th><th>Trạng thái</th></tr></thead>
                            <tbody>
                                <c:forEach items="${lowStockList}" var="i" varStatus="st">
                                    <tr>
                                        <td>${st.index+1}</td>
                                        <td>${i.ingredientName}</td>
                                        <td class="text-danger fw-bold">${i.quantity}</td>
                                        <td>${i.minQuantity}</td>
                                        <td>${i.unit}</td>
                                        <td><span class="badge bg-danger">Cần nhập thêm</span></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="mt-4">
        <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
    </div>
</div>
</body>
</html>