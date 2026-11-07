<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết hội viên - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2, h3 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; padding: 25px; color: var(--text-light); }
        .form-control, .form-select { background: #1a1e33; border: 1px solid #2b2f42; color: var(--text-light); }
        .form-control:focus, .form-select:focus { background: #1a1e33; border-color: var(--gold); color: var(--text-light); box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25); }
        label { color: var(--gold); font-weight: 600; margin-bottom: 5px; display: block; }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: bold; }
        .btn-gold:hover { background: #b8962f; }
        .table { color: var(--text-light); border-color: #2b2f42; }
        .table thead { background: var(--gold); color: var(--dark); }
    </style>
</head>
<body class="p-4">

<div class="container">
    <h2 class="mb-4">Thông tin hội viên</h2>
    
    <form method="post" class="card shadow-lg mb-5">
        <input type="hidden" name="customerId" value="${customer.customerId}">
        
        <div class="row g-3">
            <div class="col-md-6"><label>Họ tên</label><input class="form-control" name="fullName" value="${customer.fullName}"></div>
            <div class="col-md-6"><label>Số điện thoại</label><input class="form-control" name="phone" value="${customer.phone}"></div>
            <div class="col-md-6"><label>Email</label><input class="form-control" name="email" value="${customer.email}"></div>
            <div class="col-md-6"><label>Ngày đăng ký</label><input class="form-control" value="${customer.createdDate}" readonly style="opacity: 0.6;"></div>
            
            <div class="col-md-4"><label>Hạng</label>
                <select class="form-select" name="rank">
                    <option value="BRONZE" <c:if test="${customer.rank=='BRONZE'}">selected</c:if>>BRONZE</option>
                    <option value="SILVER" <c:if test="${customer.rank=='SILVER'}">selected</c:if>>SILVER</option>
                    <option value="GOLD" <c:if test="${customer.rank=='GOLD'}">selected</c:if>>GOLD</option>
                    <option value="DIAMOND" <c:if test="${customer.rank=='DIAMOND'}">selected</c:if>>DIAMOND</option>
                </select>
            </div>
            <div class="col-md-4"><label>Hội viên</label>
                <select class="form-select" name="isMember">
                    <option value="true" <c:if test="${customer.isMember}">selected</c:if>>Có</option>
                    <option value="false" <c:if test="${!customer.isMember}">selected</c:if>>Không</option>
                </select>
            </div>
            <div class="col-md-4"><label>Trạng thái</label>
                <select class="form-select" name="isActive">
                    <option value="true" <c:if test="${customer.isActive}">selected</c:if>>Hoạt động</option>
                    <option value="false" <c:if test="${!customer.isActive}">selected</c:if>>Khóa</option>
                </select>
            </div>
            
            <div class="col-md-4"><label>Tổng chi tiêu</label><input class="form-control" value="${customer.totalSpent}" readonly></div>
            <div class="col-md-4"><label>Tổng số đơn</label><input class="form-control" value="${totalOrders}" readonly></div>
            <div class="col-md-4"><label>Đơn gần nhất</label><input class="form-control" value="${latestOrder != null ? latestOrder.orderDate : ''}" readonly></div>
        </div>

        <div class="mt-4">
            <button class="btn btn-gold px-4">Lưu thay đổi</button>
            <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/admin/customers">Quay lại</a>
        </div>
    </form>

    <h3 class="mb-3">Lịch sử đơn hàng</h3>
    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead>
                <tr><th>Mã đơn</th><th>Ngày</th><th>Bàn</th><th>Tổng tiền</th><th>Trạng thái</th><th></th></tr>
            </thead>
            <tbody>
                <c:forEach items="${orders}" var="o">
                    <tr>
                        <td>${o.orderId}</td>
                        <td>${o.orderDate}</td>
                        <td>${o.restaurantTable.tableName}</td>
                        <td>${o.totalAmount}</td>
                        <td>${o.status}</td>
                        <td><a class="btn btn-sm btn-outline-warning" href="${pageContext.request.contextPath}/admin/customer-order?id=${o.orderId}">Xem</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>