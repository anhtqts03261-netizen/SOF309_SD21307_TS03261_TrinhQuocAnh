<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết bàn - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; padding-bottom: 50px; }
        h2, h4, h5 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; }
        .card-header { background: #1a1e33 !important; border-bottom: 1px solid var(--gold); color: var(--gold); font-weight: 600; }
        .table { color: var(--text-light); vertical-align: middle; }
        .table thead { background: #1a1e33; color: var(--gold); }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: 600; }
        .btn-gold:hover { background: #b8962f; }
        .badge { font-weight: 400; }
    </style>
</head>
<body class="p-4">

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>${table.tableName}</h2>
        <a href="${pageContext.request.contextPath}/admin/table" class="btn btn-outline-light">← Quay lại</a>
    </div>

    <!-- Thông tin bàn -->
    <div class="card mb-4">
        <div class="card-header">Thông tin phục vụ</div>
        <div class="card-body">
            <div class="row text-center">
                <div class="col-md-3"><b>Trạng thái:</b><br>
                    <c:choose>
                        <c:when test="${table.status=='EMPTY'}"><span class="badge bg-success">TRỐNG</span></c:when>
                        <c:when test="${table.status=='SERVING'}"><span class="badge bg-danger">ĐANG PHỤC VỤ</span></c:when>
                        <c:otherwise><span class="badge bg-warning text-dark">ĐÃ ĐẶT</span></c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-3"><b>Nhân viên:</b><br>${order.user.fullName != null ? order.user.fullName : '-'}</div>
                <div class="col-md-3"><b>Khách hàng:</b><br>${order.customer.fullName != null ? order.customer.fullName : 'Khách lẻ'}</div>
                <div class="col-md-3"><b>Tổng tiền:</b><br><span class="text-warning fw-bold"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VNĐ</span></div>
            </div>
        </div>
    </div>

    <!-- Form Thêm món -->
    <div class="card mb-4">
        <div class="card-header">Thêm món ăn</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/table/add-dish" method="post" class="row align-items-end">
                <input type="hidden" name="tableId" value="${table.tableId}">
                <div class="col-md-7">
                    <label class="form-label text-gold">Chọn món</label>
                    <select class="form-select" name="dishId" style="background:#1a1e33; border:1px solid #2b2f42; color:#fff;">
                        <c:forEach items="${dishes}" var="d">
                            <option value="${d.dishId}">${d.dishName} - <fmt:formatNumber value="${d.price}" pattern="#,##0"/> VNĐ</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label text-gold">SL</label>
                    <input type="number" class="form-control" name="quantity" value="1" min="1" style="background:#1a1e33; border:1px solid #2b2f42; color:#fff;">
                </div>
                <div class="col-md-3">
                    <button class="btn btn-gold w-100">Thêm món</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Danh sách món -->
    <div class="card">
        <div class="card-header">Danh sách món đã gọi</div>
        <table class="table table-hover mb-0">
            <thead>
                <tr><th>Tên món</th><th>SL</th><th>Đơn giá</th><th>Thành tiền</th><th>Trạng thái</th><th>Thao tác</th></tr>
            </thead>
            <tbody>
                <c:forEach items="${order.orderDetails}" var="od">
                    <tr>
                        <td>${od.dish.dishName}</td>
                        <td>${od.quantity}</td>
                        <td><fmt:formatNumber value="${od.price}" pattern="#,##0"/></td>
                        <td><fmt:formatNumber value="${od.quantity * od.price}" pattern="#,##0"/></td>
                        <td><span class="badge bg-secondary">${od.itemStatus}</span></td>
                        <td><a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/admin/table/delete-dish?id=${od.orderDetailId}&tableId=${table.tableId}" onclick="return confirm('Xóa?')">Xóa</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Thanh toán -->
    <c:if test="${order != null}">
        <div class="text-end mt-4">
            <form method="post" action="${pageContext.request.contextPath}/admin/payment">
                <input type="hidden" name="orderId" value="${order.orderId}">
                <button class="btn btn-success btn-lg px-5" onclick="return confirm('Xác nhận thanh toán?')">Thanh toán hóa đơn</button>
            </form>
        </div>
    </c:if>
</div>

</body>
</html>