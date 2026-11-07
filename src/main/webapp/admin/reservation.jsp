<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đặt bàn - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; padding: 20px; }
        .form-control, .form-select { background: #1a1e33; border: 1px solid #2b2f42; color: var(--text-light); }
        .table { color: var(--text-light); vertical-align: middle; }
        .table thead { background: var(--gold); color: var(--dark); }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: 600; }
        .btn-gold:hover { background: #b8962f; }
        .badge { font-weight: 400; padding: 6px 12px; border-radius: 6px; }
    </style>
</head>
<body class="p-4">

<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Quản lý đặt bàn</h2>
        <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
    </div>

    <div class="card mb-4">
        <form method="get" action="${pageContext.request.contextPath}/admin/reservation">
            <div class="row g-3">
                <div class="col-md-5"><input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="Tên khách hoặc SĐT"></div>
                <div class="col-md-3">
                    <select name="status" class="form-select">
                        <option value="">Tất cả trạng thái</option>
                        <option value="PENDING" ${status=='PENDING'?'selected':''}>PENDING</option>
                        <option value="CONFIRMED" ${status=='CONFIRMED'?'selected':''}>CONFIRMED</option>
                        <option value="COMPLETED" ${status=='COMPLETED'?'selected':''}>COMPLETED</option>
                        <option value="CANCELLED" ${status=='CANCELLED'?'selected':''}>CANCELLED</option>
                    </select>
                </div>
                <div class="col-md-2"><button class="btn btn-gold w-100">Tìm kiếm</button></div>
                <div class="col-md-2"><a class="btn btn-outline-secondary w-100" href="${pageContext.request.contextPath}/admin/reservation">Làm mới</a></div>
            </div>
        </form>
    </div>

    <div class="card">
        <table class="table table-hover">
            <thead>
                <tr><th>ID</th><th>Khách hàng</th><th>SĐT</th><th>Thời gian</th><th>Bàn</th><th>Số khách</th><th>Trạng thái</th><th>Thao tác</th></tr>
            </thead>
            <tbody>
                <c:forEach items="${reservationList}" var="r">
                    <tr>
                        <td>#${r.reservationId}</td>
                        <td><strong>${r.customerName}</strong></td>
                        <td>${r.phone}</td>
                        <td>${r.reservationTime}</td>
                        <td>${r.restaurantTable != null ? r.restaurantTable.tableName : '--'}</td>
                        <td>${r.guestCount}</td>
                        <td>
                            <c:choose>
                                <c:when test="${r.status=='PENDING'}"><span class="badge bg-warning text-dark">PENDING</span></c:when>
                                <c:when test="${r.status=='CONFIRMED'}"><span class="badge bg-primary">CONFIRMED</span></c:when>
                                <c:when test="${r.status=='COMPLETED'}"><span class="badge bg-success">COMPLETED</span></c:when>
                                <c:otherwise><span class="badge bg-danger">CANCELLED</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a class="btn btn-sm btn-outline-info" href="${pageContext.request.contextPath}/admin/reservation-detail?id=${r.reservationId}">Chi tiết</a>
                            <a class="btn btn-sm btn-outline-warning" href="${pageContext.request.contextPath}/admin/reservation-edit?id=${r.reservationId}">Sửa</a>
                            <c:if test="${r.status=='PENDING'}">
                                <a class="btn btn-sm btn-gold" onclick="return confirm('Xác nhận đặt bàn này?')" href="${pageContext.request.contextPath}/admin/reservation-confirm?id=${r.reservationId}">Xác nhận</a>
                            </c:if>
                            <c:if test="${r.status!='CANCELLED'}">
                                <a class="btn btn-sm btn-outline-danger" onclick="return confirm('Hủy đặt bàn?')" href="${pageContext.request.contextPath}/admin/reservation-cancel?id=${r.reservationId}">Hủy</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>