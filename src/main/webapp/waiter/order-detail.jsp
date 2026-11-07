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
            min-height: 100vh;
            padding: 30px 0 60px 0;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            color: var(--gold);
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        hr {
            border-color: rgba(212, 175, 55, 0.3);
            margin-bottom: 30px;
        }

        /* --- CARDS TÙY CHỈNH --- */
        .custom-card {
            background-color: var(--card-bg);
            border: 1px solid rgba(212, 175, 55, 0.15);
            border-radius: 8px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.4);
            margin-bottom: 25px;
            overflow: hidden;
        }

        .custom-card .card-header {
            background-color: rgba(255, 255, 255, 0.02);
            border-bottom: 1px solid rgba(212, 175, 55, 0.15);
            color: var(--gold);
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            letter-spacing: 1px;
            padding: 15px 20px;
        }

        .custom-card .card-body {
            padding: 20px;
        }

        /* --- INFO TEXT --- */
        .info-text b {
            color: var(--gold);
            margin-right: 5px;
            font-weight: 600;
        }

        /* --- CUSTOM FORM ELEMENTS --- */
        .form-label {
            color: #b0b0b0;
            font-size: 13px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .custom-input {
            background-color: rgba(255, 255, 255, 0.05) !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            color: var(--text-light) !important;
            transition: all 0.3s ease;
        }

        .custom-input:focus {
            border-color: var(--gold) !important;
            box-shadow: 0 0 10px rgba(212, 175, 55, 0.2) !important;
        }
        
        .custom-input option {
            background-color: var(--card-bg);
            color: var(--text-light);
        }

        /* --- TABLE --- */
        .table-responsive {
            border-radius: 0 0 8px 8px;
        }

        .table-responsive::-webkit-scrollbar {
            height: 6px;
        }
        .table-responsive::-webkit-scrollbar-thumb {
            background: rgba(212, 175, 55, 0.5);
            border-radius: 4px;
        }

        .custom-table {
            margin-bottom: 0;
            color: var(--text-light);
            border-color: rgba(255, 255, 255, 0.05);
        }

        .custom-table thead th {
            background-color: rgba(10, 12, 22, 0.8) !important;
            color: var(--gold) !important;
            font-family: 'Montserrat', sans-serif;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 1px solid rgba(212, 175, 55, 0.3);
            white-space: nowrap;
        }

        .custom-table tbody td {
            background-color: transparent !important;
            vertical-align: middle;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            font-size: 14px;
        }

        .custom-table tbody tr:hover td {
            background-color: rgba(212, 175, 55, 0.05) !important;
        }

        /* --- BUTTONS --- */
        .btn-custom {
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 1px;
            font-weight: 600;
            padding: 10px 20px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-gold {
            background-color: var(--gold);
            color: var(--dark-bg);
            border: 1px solid var(--gold);
        }

        .btn-gold:hover {
            background-color: #f3c63e;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }

        .btn-outline-gold {
            background-color: transparent;
            color: var(--gold);
            border: 1px solid var(--gold);
        }

        .btn-outline-gold:hover {
            background-color: var(--gold);
            color: var(--dark-bg);
        }
        
        .badge {
            font-weight: 500;
            letter-spacing: 0.5px;
            padding: 6px 10px;
        }

        .total-amount {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            color: var(--text-light);
        }
        
        .total-amount span {
            color: var(--gold) !important;
            font-weight: 700;
        }
    </style>
</head>
<body>

<div class="container mt-4">

    <h2 class="page-title"><i class="fas fa-receipt me-2"></i> Order của ${order.restaurantTable.tableName}</h2>
    <hr>

    <div class="custom-card mb-4">
        <div class="card-body">
            <div class="row info-text g-3">
                <div class="col-md-4">
                    <b><i class="fas fa-hashtag"></i> Mã Order:</b>
                    ${order.orderId}
                </div>
                <div class="col-md-4">
                    <b><i class="fas fa-user-tie"></i> Phục vụ:</b>
                    ${order.user.fullName}
                </div>
                <div class="col-md-4">
                    <b><i class="fas fa-info-circle"></i> Trạng thái:</b>
                    <span class="badge bg-secondary">${order.status}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="custom-card mb-4">
        <div class="card-header">
            <i class="fas fa-plus-circle me-2"></i> Thêm món
        </div>
        <div class="card-body">
            <c:if test="${order.status=='UNPAID'}">
                <form method="post" action="${pageContext.request.contextPath}/waiter/add-dish">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Món ăn</label>
                            <select name="dishId" class="form-select custom-input">
                                <c:forEach items="${dishes}" var="d">
                                    <option value="${d.dishId}">
                                        ${d.dishName} - ${d.price} VNĐ
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Số lượng</label>
                            <input type="number" name="quantity" class="form-control custom-input" min="1" value="1">
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <button class="btn btn-gold btn-custom w-100">
                                <i class="fas fa-cart-plus me-2"></i> Thêm món
                            </button>
                        </div>
                    </div>
                </form>
            </c:if>

            <c:if test="${order.status!='UNPAID'}">
                <div class="alert alert-warning" style="background: rgba(255, 193, 7, 0.1); border-color: rgba(255, 193, 7, 0.3); color: #ffc107;">
                    <i class="fas fa-exclamation-triangle me-2"></i> Đơn hàng đã gửi yêu cầu thanh toán. Không thể thêm món.
                </div>
            </c:if>
        </div>
    </div>

    <div class="custom-card mb-4">
        <div class="card-header">
            <i class="fas fa-list-ul me-2"></i> Danh sách món
        </div>
        <div class="table-responsive">
            <table class="table custom-table table-hover">
                <thead>
                    <tr>
                        <th>Món</th>
                        <th>SL</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                        <th>Trạng thái</th>
                        <th width="170" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${details}" var="d">
                        <tr>
                            <td>${d.dish.dishName}</td>
                            <td>${d.quantity}</td>
                            <td>${d.price}</td>
                            <td>${d.quantity*d.price}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${d.itemStatus=='PENDING'}">
                                        <span class="badge bg-warning text-dark"><i class="fas fa-clock me-1"></i> Chờ bếp</span>
                                    </c:when>
                                    <c:when test="${d.itemStatus=='PREPARING'}">
                                        <span class="badge bg-primary"><i class="fas fa-fire me-1"></i> Đang chế biến</span>
                                    </c:when>
                                    <c:when test="${d.itemStatus=='COMPLETED'}">
                                        <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i> Đã nấu xong</span>
                                    </c:when>
                                    <c:when test="${d.itemStatus=='SERVED'}">
                                        <span class="badge bg-secondary"><i class="fas fa-utensils me-1"></i> Đã phục vụ</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${d.itemStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${d.itemStatus=='COMPLETED'}">
                                        <form method="post" action="${pageContext.request.contextPath}/waiter/serve">
                                            <input type="hidden" name="detailId" value="${d.orderDetailId}">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <button class="btn btn-outline-success btn-sm" style="font-size: 12px; font-weight: 600;">
                                                <i class="fas fa-hand-holding-water me-1"></i> Bưng món
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">-</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end mb-4 gap-3">
        
        <div class="d-flex flex-wrap gap-2 order-2 order-md-1">
            <a class="btn btn-outline-light btn-custom" href="${pageContext.request.contextPath}/waiter/tables">
                <i class="fas fa-arrow-left me-2"></i> Quay lại
            </a>
            
            <a class="btn btn-outline-gold btn-custom" href="${pageContext.request.contextPath}/waiter/move-table?orderId=${order.orderId}">
                <i class="fas fa-exchange-alt me-2"></i> Đổi bàn
            </a>

            <c:choose>
                <c:when test="${order.status=='UNPAID'}">
                    <form method="post" action="${pageContext.request.contextPath}/waiter/request-payment" class="m-0">
                        <input type="hidden" name="orderId" value="${order.orderId}">
                        <button class="btn btn-gold btn-custom">
                            <i class="fas fa-money-bill-wave me-2"></i> Yêu cầu thanh toán
                        </button>
                    </form>
                </c:when>
                <c:when test="${order.status=='WAITING_PAYMENT'}">
                    <button class="btn btn-outline-warning btn-custom" disabled>
                        <i class="fas fa-hourglass-half me-2"></i> Đã yêu cầu thanh toán
                    </button>
                </c:when>
                <c:when test="${order.status=='PAID'}">
                    <button class="btn btn-outline-success btn-custom" disabled>
                        <i class="fas fa-check-double me-2"></i> Đã thanh toán
                    </button>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-secondary btn-custom" disabled>Không khả dụng</button>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="text-start text-md-end order-1 order-md-2">
            <h3 class="total-amount m-0">
                Tổng tiền: <span>${order.totalAmount}</span> VNĐ
            </h3>
        </div>
        
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html><%@ page contentType="text/html;charset=UTF-8"%>
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
            min-height: 100vh;
            padding: 30px 0 60px 0;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            color: var(--gold);
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        hr {
            border-color: rgba(212, 175, 55, 0.3);
            margin-bottom: 30px;
        }

        /* --- CARDS TÙY CHỈNH --- */
        .custom-card {
            background-color: var(--card-bg);
            border: 1px solid rgba(212, 175, 55, 0.15);
            border-radius: 8px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.4);
            margin-bottom: 25px;
            overflow: hidden;
        }

        .custom-card .card-header {
            background-color: rgba(255, 255, 255, 0.02);
            border-bottom: 1px solid rgba(212, 175, 55, 0.15);
            color: var(--gold);
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            letter-spacing: 1px;
            padding: 15px 20px;
        }

        .custom-card .card-body {
            padding: 20px;
        }

        /* --- INFO TEXT --- */
        .info-text b {
            color: var(--gold);
            margin-right: 5px;
            font-weight: 600;
        }

        /* --- CUSTOM FORM ELEMENTS --- */
        .form-label {
            color: #b0b0b0;
            font-size: 13px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .custom-input {
            background-color: rgba(255, 255, 255, 0.05) !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
            color: var(--text-light) !important;
            transition: all 0.3s ease;
        }

        .custom-input:focus {
            border-color: var(--gold) !important;
            box-shadow: 0 0 10px rgba(212, 175, 55, 0.2) !important;
        }
        
        .custom-input option {
            background-color: var(--card-bg);
            color: var(--text-light);
        }

        /* --- TABLE --- */
        .table-responsive {
            border-radius: 0 0 8px 8px;
        }

        .table-responsive::-webkit-scrollbar {
            height: 6px;
        }
        .table-responsive::-webkit-scrollbar-thumb {
            background: rgba(212, 175, 55, 0.5);
            border-radius: 4px;
        }

        .custom-table {
            margin-bottom: 0;
            color: var(--text-light);
            border-color: rgba(255, 255, 255, 0.05);
        }

        .custom-table thead th {
            background-color: rgba(10, 12, 22, 0.8) !important;
            color: var(--gold) !important;
            font-family: 'Montserrat', sans-serif;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 1px solid rgba(212, 175, 55, 0.3);
            white-space: nowrap;
        }

        .custom-table tbody td {
            background-color: transparent !important;
            vertical-align: middle;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            font-size: 14px;
        }

        .custom-table tbody tr:hover td {
            background-color: rgba(212, 175, 55, 0.05) !important;
        }

        /* --- BUTTONS --- */
        .btn-custom {
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 1px;
            font-weight: 600;
            padding: 10px 20px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-gold {
            background-color: var(--gold);
            color: var(--dark-bg);
            border: 1px solid var(--gold);
        }

        .btn-gold:hover {
            background-color: #f3c63e;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }

        .btn-outline-gold {
            background-color: transparent;
            color: var(--gold);
            border: 1px solid var(--gold);
        }

        .btn-outline-gold:hover {
            background-color: var(--gold);
            color: var(--dark-bg);
        }
        
        .badge {
            font-weight: 500;
            letter-spacing: 0.5px;
            padding: 6px 10px;
        }

        .total-amount {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            color: var(--text-light);
        }
        
        .total-amount span {
            color: var(--gold) !important;
            font-weight: 700;
        }
    </style>
</head>
<body>

<div class="container mt-4">

    <h2 class="page-title"><i class="fas fa-receipt me-2"></i> Order của ${order.restaurantTable.tableName}</h2>
    <hr>

    <div class="custom-card mb-4">
        <div class="card-body">
            <div class="row info-text g-3">
                <div class="col-md-4">
                    <b><i class="fas fa-hashtag"></i> Mã Order:</b>
                    ${order.orderId}
                </div>
                <div class="col-md-4">
                    <b><i class="fas fa-user-tie"></i> Phục vụ:</b>
                    ${order.user.fullName}
                </div>
                <div class="col-md-4">
                    <b><i class="fas fa-info-circle"></i> Trạng thái:</b>
                    <span class="badge bg-secondary">${order.status}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="custom-card mb-4">
        <div class="card-header">
            <i class="fas fa-plus-circle me-2"></i> Thêm món
        </div>
        <div class="card-body">
            <c:if test="${order.status=='UNPAID'}">
                <form method="post" action="${pageContext.request.contextPath}/waiter/add-dish">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Món ăn</label>
                            <select name="dishId" class="form-select custom-input">
                                <c:forEach items="${dishes}" var="d">
                                    <option value="${d.dishId}">
                                        ${d.dishName} - ${d.price} VNĐ
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Số lượng</label>
                            <input type="number" name="quantity" class="form-control custom-input" min="1" value="1">
                        </div>
                        <div class="col-md-3 d-flex align-items-end">
                            <button class="btn btn-gold btn-custom w-100">
                                <i class="fas fa-cart-plus me-2"></i> Thêm món
                            </button>
                        </div>
                    </div>
                </form>
            </c:if>

            <c:if test="${order.status!='UNPAID'}">
                <div class="alert alert-warning" style="background: rgba(255, 193, 7, 0.1); border-color: rgba(255, 193, 7, 0.3); color: #ffc107;">
                    <i class="fas fa-exclamation-triangle me-2"></i> Đơn hàng đã gửi yêu cầu thanh toán. Không thể thêm món.
                </div>
            </c:if>
        </div>
    </div>

    <div class="custom-card mb-4">
        <div class="card-header">
            <i class="fas fa-list-ul me-2"></i> Danh sách món
        </div>
        <div class="table-responsive">
            <table class="table custom-table table-hover">
                <thead>
                    <tr>
                        <th>Món</th>
                        <th>SL</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                        <th>Trạng thái</th>
                        <th width="170" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${details}" var="d">
                        <tr>
                            <td>${d.dish.dishName}</td>
                            <td>${d.quantity}</td>
                            <td>${d.price}</td>
                            <td>${d.quantity*d.price}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${d.itemStatus=='PENDING'}">
                                        <span class="badge bg-warning text-dark"><i class="fas fa-clock me-1"></i> Chờ bếp</span>
                                    </c:when>
                                    <c:when test="${d.itemStatus=='PREPARING'}">
                                        <span class="badge bg-primary"><i class="fas fa-fire me-1"></i> Đang chế biến</span>
                                    </c:when>
                                    <c:when test="${d.itemStatus=='COMPLETED'}">
                                        <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i> Đã nấu xong</span>
                                    </c:when>
                                    <c:when test="${d.itemStatus=='SERVED'}">
                                        <span class="badge bg-secondary"><i class="fas fa-utensils me-1"></i> Đã phục vụ</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${d.itemStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${d.itemStatus=='COMPLETED'}">
                                        <form method="post" action="${pageContext.request.contextPath}/waiter/serve">
                                            <input type="hidden" name="detailId" value="${d.orderDetailId}">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <button class="btn btn-outline-success btn-sm" style="font-size: 12px; font-weight: 600;">
                                                <i class="fas fa-hand-holding-water me-1"></i> Bưng món
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">-</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end mb-4 gap-3">
        
        <div class="d-flex flex-wrap gap-2 order-2 order-md-1">
            <a class="btn btn-outline-light btn-custom" href="${pageContext.request.contextPath}/waiter/tables">
                <i class="fas fa-arrow-left me-2"></i> Quay lại
            </a>
            
            <a class="btn btn-outline-gold btn-custom" href="${pageContext.request.contextPath}/waiter/move-table?orderId=${order.orderId}">
                <i class="fas fa-exchange-alt me-2"></i> Đổi bàn
            </a>

            <c:choose>
                <c:when test="${order.status=='UNPAID'}">
                    <form method="post" action="${pageContext.request.contextPath}/waiter/request-payment" class="m-0">
                        <input type="hidden" name="orderId" value="${order.orderId}">
                        <button class="btn btn-gold btn-custom">
                            <i class="fas fa-money-bill-wave me-2"></i> Yêu cầu thanh toán
                        </button>
                    </form>
                </c:when>
                <c:when test="${order.status=='WAITING_PAYMENT'}">
                    <button class="btn btn-outline-warning btn-custom" disabled>
                        <i class="fas fa-hourglass-half me-2"></i> Đã yêu cầu thanh toán
                    </button>
                </c:when>
                <c:when test="${order.status=='PAID'}">
                    <button class="btn btn-outline-success btn-custom" disabled>
                        <i class="fas fa-check-double me-2"></i> Đã thanh toán
                    </button>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-secondary btn-custom" disabled>Không khả dụng</button>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="text-start text-md-end order-1 order-md-2">
            <h3 class="total-amount m-0">
                Tổng tiền: <span>${order.totalAmount}</span> VNĐ
            </h3>
        </div>
        
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>