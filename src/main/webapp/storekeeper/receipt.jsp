<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phiếu nhập kho - Restaurant Management</title>
    
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
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 10px 20px; transition: 0.3s; }
        .btn-gold:hover { background: #f3c63e; }
        .btn-outline-gold { border: 1px solid var(--gold); color: var(--gold); text-transform: uppercase; padding: 8px 15px; font-size: 13px; }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title"><i class="fas fa-file-invoice-dollar me-2"></i> Phiếu nhập kho</h2>
    
    <div class="mb-4">
        <a class="btn btn-gold" href="${pageContext.request.contextPath}/storekeeper/receipt/add">
            <i class="fas fa-plus me-2"></i> Tạo phiếu nhập
        </a>
    </div>

    <div class="custom-card">
        <div class="table-responsive">
            <table class="table custom-table table-hover align-middle">
                <thead>
                    <tr>
                        <th>Mã phiếu</th>
                        <th>Ngày</th>
                        <th>Nhân viên</th>
                        <th>Loại</th>
                        <th>Tổng tiền</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${receipts}" var="r">
                        <tr>
                            <td>#${r.receiptId}</td>
                            <td>${r.receiptDate}</td>
                            <td>${r.user.fullName}</td>
                            <td><span class="badge bg-secondary">${r.type}</span></td>
                            <td class="text-gold fw-bold" style="color: var(--gold);">${r.totalAmount} VNĐ</td>
                            <td>
                                <a class="btn btn-outline-gold btn-sm" href="${pageContext.request.contextPath}/storekeeper/receipt/detail?id=${r.receiptId}">
                                    <i class="fas fa-eye me-1"></i> Chi tiết
                                </a>
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