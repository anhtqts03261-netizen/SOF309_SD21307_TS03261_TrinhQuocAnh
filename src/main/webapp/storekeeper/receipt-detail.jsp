<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết phiếu nhập - Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 30px; }
        
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; box-shadow: 0 10px 25px rgba(0,0,0,0.4); padding: 25px; margin-bottom: 25px; }
        
        .custom-input { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: var(--text-light); padding: 10px; }
        .custom-input:focus { background: rgba(255,255,255,0.08); border-color: var(--gold); color: white; }
        
        .custom-table { color: var(--text-light); margin-bottom: 0; }
        .custom-table thead th { background: rgba(10,12,22,0.9) !important; color: var(--gold) !important; text-transform: uppercase; font-size: 13px; }
        .custom-table tbody td { border-bottom: 1px solid rgba(255,255,255,0.05); vertical-align: middle; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; padding: 10px 20px; }
        .btn-warning-gold { background: transparent; border: 1px solid var(--gold); color: var(--gold); }
        .btn-warning-gold:hover { background: var(--gold); color: var(--dark-bg); }
    </style>
</head>
<body>

<div class="container">
    <h2 class="page-title"><i class="fas fa-file-import me-2"></i> Phiếu nhập #${receipt.receiptId}</h2>
    
    <div class="custom-card">
        <form method="post" action="${pageContext.request.contextPath}/storekeeper/receipt/add-item">
            <input type="hidden" name="receiptId" value="${receipt.receiptId}">
            <div class="row g-3">
                <div class="col-md-5">
                    <select name="ingredientId" class="form-select custom-input"><c:forEach items="${ingredients}" var="i"><option value="${i.ingredientId}">${i.ingredientName}</option></c:forEach></select>
                </div>
                <div class="col-md-2"><input class="form-control custom-input" type="number" step="0.1" name="quantity" placeholder="Số lượng"></div>
                <div class="col-md-2"><input class="form-control custom-input" type="number" step="1000" name="price" placeholder="Đơn giá"></div>
                <div class="col-md-3"><button class="btn btn-gold w-100"><i class="fas fa-plus me-1"></i> Thêm</button></div>
            </div>
        </form>
    </div>

    <div class="custom-card p-0">
        <div class="table-responsive">
            <table class="table custom-table table-hover align-middle">
                <thead><tr><th>Nguyên liệu</th><th>Số lượng</th><th>Đơn giá</th><th>Thành tiền</th><th>Thao tác</th></tr></thead>
                <tbody>
                    <c:forEach items="${details}" var="d">
                        <tr>
                            <td>${d.ingredient.ingredientName}</td>
                            <form method="post" action="${pageContext.request.contextPath}/storekeeper/receipt/update-item">
                                <td><input type="number" step="0.1" class="form-control custom-input form-control-sm" name="quantity" value="${d.quantity}"></td>
                                <td><input type="number" step="1000" class="form-control custom-input form-control-sm" name="price" value="${d.price}"></td>
                                <td>${d.quantity*d.price} VNĐ</td>
                                <td>
                                    <input type="hidden" name="detailId" value="${d.inventoryDetailId}">
                                    <button class="btn btn-warning-gold btn-sm"><i class="fas fa-save"></i></button>
                            </form>
                                    <form method="post" style="display:inline" action="${pageContext.request.contextPath}/storekeeper/receipt/delete-item">
                                        <input type="hidden" name="detailId" value="${d.inventoryDetailId}">
                                        <button class="btn btn-outline-danger btn-sm" onclick="return confirm('Xóa nguyên liệu này?')"><i class="fas fa-trash"></i></button>
                                    </form>
                                </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="custom-card d-flex justify-content-between align-items-center">
        <h4 class="m-0">Tổng tiền: <span style="color: var(--gold);">${receipt.totalAmount} VNĐ</span></h4>
        <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/storekeeper/receipt"><i class="fas fa-arrow-left me-1"></i> Quay lại</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>