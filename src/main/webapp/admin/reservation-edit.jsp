<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa đặt bàn - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h3 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .card-header { background: #1a1e33 !important; border-bottom: 1px solid var(--gold); border-radius: 20px 20px 0 0 !important; padding: 20px; }
        .form-label { color: var(--gold); font-weight: 600; font-size: 0.9em; }
        .form-control, .form-select { background: #1a1e33; border: 1px solid #2b2f42; color: var(--text-light); border-radius: 10px; }
        .form-control:focus, .form-select:focus { background: #1a1e33; border-color: var(--gold); color: var(--text-light); box-shadow: none; }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: 600; }
        .btn-gold:hover { background: #b8962f; }
    </style>
</head>
<body class="p-4">

<fmt:formatDate value="${reservation.reservationTime}" pattern="yyyy-MM-dd'T'HH:mm" var="formattedTime"/>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h3 class="mb-0">Chỉnh sửa đặt bàn #${reservation.reservationId}</h3>
        </div>
        <div class="card-body p-4">
            <form method="post" action="${pageContext.request.contextPath}/admin/reservation-edit">
                <input type="hidden" name="id" value="${reservation.reservationId}">
                
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Tên khách</label>
                        <input class="form-control" name="customerName" value="${reservation.customerName}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Số điện thoại</label>
                        <input class="form-control" name="phone" value="${reservation.phone}" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Số khách</label>
                        <input type="number" min="1" class="form-control" name="guestCount" value="${reservation.guestCount}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Thời lượng (phút)</label>
                        <input type="number" class="form-control" name="duration" value="${reservation.duration}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Bàn</label>
                        <select class="form-select" name="tableId">
                            <c:forEach items="${tableList}" var="t">
                                <option value="${t.tableId}" ${reservation.restaurantTable.tableId==t.tableId?'selected':''}>
                                    ${t.tableName} (${t.capacity} khách)
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Thời gian đặt</label>
                        <input type="datetime-local" class="form-control" name="reservationTime" value="${formattedTime}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Trạng thái</label>
                        <select class="form-select" name="status">
                            <option value="PENDING" ${reservation.status=='PENDING'?'selected':''}>PENDING</option>
                            <option value="CONFIRMED" ${reservation.status=='CONFIRMED'?'selected':''}>CONFIRMED</option>
                            <option value="COMPLETED" ${reservation.status=='COMPLETED'?'selected':''}>COMPLETED</option>
                            <option value="CANCELLED" ${reservation.status=='CANCELLED'?'selected':''}>CANCELLED</option>
                        </select>
                    </div>
                </div>

                <hr class="my-4 border-secondary">

                <div class="d-flex gap-2">
                    <button class="btn btn-gold px-4">💾 Lưu thay đổi</button>
                    <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/admin/reservation-detail?id=${reservation.reservationId}">Quay lại</a>
                    <a class="btn btn-outline-danger" onclick="return confirm('Bạn có chắc muốn hủy đặt bàn này?')" 
                       href="${pageContext.request.contextPath}/admin/reservation-cancel?id=${reservation.reservationId}">Hủy đặt bàn</a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>