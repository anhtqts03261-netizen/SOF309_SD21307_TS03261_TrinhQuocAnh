<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đặt bàn - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h3, h5 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .card-header { background: #1a1e33 !important; border-bottom: 1px solid var(--gold); border-radius: 20px 20px 0 0 !important; padding: 20px; }
        .table { color: var(--text-light); border-color: #2b2f42; }
        .table th { color: var(--gold); width: 40%; }
        .badge { font-weight: 400; padding: 6px 12px; }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: 600; }
        .btn-gold:hover { background: #b8962f; }
        .btn-outline-gold { border: 1px solid var(--gold); color: var(--gold); }
        .btn-outline-gold:hover { background: var(--gold); color: var(--dark); }
    </style>
</head>
<body class="p-4">

<div class="container">
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0">Chi tiết đặt bàn #${reservation.reservationId}</h3>
        </div>
        <div class="card-body p-4">
            <div class="row">
                <!-- Thông tin khách -->
                <div class="col-md-6 mb-4">
                    <h5>Thông tin khách hàng</h5>
                    <table class="table table-bordered mt-3">
                        <tr><th>Tên khách</th><td>${reservation.customerName}</td></tr>
                        <tr><th>Số điện thoại</th><td>${reservation.phone}</td></tr>
                        <tr><th>Số khách</th><td>${reservation.guestCount} người</td></tr>
                        <tr><th>Thời gian</th><td><fmt:formatDate value="${reservation.reservationTime}" pattern="dd/MM/yyyy HH:mm"/></td></tr>
                        <tr><th>Thời lượng</th><td>${reservation.duration} phút</td></tr>
                        <tr><th>Trạng thái</th><td>
                            <c:choose>
                                <c:when test="${reservation.status=='PENDING'}"><span class="badge bg-warning text-dark">PENDING</span></c:when>
                                <c:when test="${reservation.status=='CONFIRMED'}"><span class="badge bg-primary">CONFIRMED</span></c:when>
                                <c:when test="${reservation.status=='COMPLETED'}"><span class="badge bg-success">COMPLETED</span></c:when>
                                <c:otherwise><span class="badge bg-danger">CANCELLED</span></c:otherwise>
                            </c:choose>
                        </td></tr>
                    </table>
                </div>

                <!-- Thông tin bàn -->
                <div class="col-md-6 mb-4">
                    <h5>Thông tin bàn</h5>
                    <table class="table table-bordered mt-3">
                        <tr><th>Mã bàn</th><td>${reservation.restaurantTable.tableId}</td></tr>
                        <tr><th>Tên bàn</th><td><strong>${reservation.restaurantTable.tableName}</strong></td></tr>
                        <tr><th>Sức chứa</th><td>${reservation.restaurantTable.capacity} khách</td></tr>
                        <tr><th>Trạng thái bàn</th><td>${reservation.restaurantTable.status}</td></tr>
                    </table>
                </div>
            </div>

            <!-- Hóa đơn -->
            <h5 class="mt-3">Thông tin hóa đơn</h5>
            <c:choose>
                <c:when test="${order != null}">
                    <table class="table table-bordered mt-3">
                        <tr><th>Order ID</th><td>${order.orderId}</td></tr>
                        <tr><th>Ngày tạo</th><td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td></tr>
                        <tr><th>Nhân viên</th><td>${order.user.fullName}</td></tr>
                        <tr><th>Tổng tiền</th><td class="text-warning fw-bold"><fmt:formatNumber value="${order.totalAmount}" type="number"/> VNĐ</td></tr>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-secondary mt-3" style="background:#1a1e33; border:none; color:#aaa;">Chưa có hóa đơn cho đặt bàn này.</div>
                </c:otherwise>
            </c:choose>

            <div class="d-flex gap-2 mt-4">
                <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/admin/reservation">Quay lại</a>
                <a class="btn btn-outline-warning" href="${pageContext.request.contextPath}/admin/reservation-edit?id=${reservation.reservationId}">Chỉnh sửa</a>
                <c:if test="${reservation.status=='PENDING'}">
                    <a class="btn btn-gold" href="${pageContext.request.contextPath}/admin/reservation-confirm?id=${reservation.reservationId}">Xác nhận</a>
                </c:if>
                <c:if test="${reservation.status!='CANCELLED'}">
                    <a class="btn btn-outline-danger" onclick="return confirm('Bạn có chắc muốn hủy?')" href="${pageContext.request.contextPath}/admin/reservation-cancel?id=${reservation.reservationId}">Hủy</a>
                </c:if>
                <c:if test="${order != null}">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/cashier/order-detail?id=${order.orderId}">Mở Order</a>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>