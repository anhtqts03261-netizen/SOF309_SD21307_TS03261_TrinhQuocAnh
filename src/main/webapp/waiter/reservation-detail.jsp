<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Order - Restaurant Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 30px 0; }
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase; }
        .custom-card { background-color: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.15); border-radius: 8px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.4); margin-bottom: 25px; }
        .custom-card .card-header { background: rgba(255,255,255,0.03); border-bottom: 1px solid rgba(212,175,55,0.15); color: var(--gold); font-family: 'Playfair Display', serif; padding: 15px 20px; }
        .custom-input { background: rgba(255,255,255,0.05) !important; border: 1px solid rgba(255,255,255,0.1) !important; color: var(--text-light) !important; }
        .custom-input:focus { border-color: var(--gold) !important; box-shadow: 0 0 10px rgba(212,175,55,0.2) !important; }
        .custom-table { color: var(--text-light); border-color: rgba(255,255,255,0.05); }
        .custom-table thead th { background: rgba(10,12,22,0.8) !important; color: var(--gold) !important; text-transform: uppercase; font-size: 13px; }
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; text-transform: uppercase; }
        .total-amount { font-family: 'Playfair Display', serif; font-size: 28px; color: var(--gold); font-weight: 700; }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="page-title"><i class="fas fa-receipt me-2"></i> Order: ${order.restaurantTable.tableName}</h2>
    
    <div class="custom-card p-3">
        <div class="row g-3">
            <div class="col-md-4"><b>Mã Order:</b> ${order.orderId}</div>
            <div class="col-md-4"><b>Phục vụ:</b> ${order.user.fullName}</div>
            <div class="col-md-4"><b>Trạng thái:</b> <span class="badge bg-secondary">${order.status}</span></div>
        </div>
    </div>

    <c:if test="${order.status=='UNPAID'}">
        <div class="custom-card">
            <div class="card-header"><i class="fas fa-plus-circle me-2"></i> Thêm món</div>
            <div class="card-body">
                <form method="post" action="${pageContext.request.contextPath}/waiter/add-dish">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <div class="row g-3">
                        <div class="col-md-6"><select name="dishId" class="form-select custom-input"><c:forEach items="${dishes}" var="d"><option value="${d.dishId}">${d.dishName} - ${d.price} VNĐ</option></c:forEach></select></div>
                        <div class="col-md-3"><input type="number" name="quantity" class="form-control custom-input" min="1" value="1"></div>
                        <div class="col-md-3"><button class="btn btn-gold w-100">Thêm</button></div>
                    </div>
                </form>
            </div>
        </div>
    </c:if>

    <div class="custom-card">
        <div class="card-header"><i class="fas fa-list-ul me-2"></i> Danh sách món</div>
        <div class="table-responsive">
            <table class="table custom-table">
                <thead><tr><th>Món</th><th>SL</th><th>Đơn giá</th><th>Thành tiền</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
                <tbody>
                    <c:forEach items="${details}" var="d">
                        <tr>
                            <td>${d.dish.dishName}</td><td>${d.quantity}</td><td>${d.price}</td><td>${d.quantity*d.price}</td>
                            <td><span class="badge bg-dark">${d.itemStatus}</span></td>
                            <td><c:if test="${d.itemStatus=='COMPLETED'}"><form method="post" action="${pageContext.request.contextPath}/waiter/serve"><input type="hidden" name="detailId" value="${d.orderDetailId}"><input type="hidden" name="orderId" value="${order.orderId}"><button class="btn btn-sm btn-outline-success">Bưng</button></form></c:if></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="d-flex justify-content-between align-items-center mt-4">
        <div class="gap-2 d-flex">
            <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/waiter/tables">Quay lại</a>
            <a class="btn btn-outline-warning" href="${pageContext.request.contextPath}/waiter/move-table?orderId=${order.orderId}">Đổi bàn</a>
        </div>
        <h3 class="total-amount">Tổng: ${order.totalAmount} VNĐ</h3>
    </div>
</div>
</body>
</html>