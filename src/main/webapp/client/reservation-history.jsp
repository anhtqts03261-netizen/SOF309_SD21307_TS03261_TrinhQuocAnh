<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đặt bàn - Nhà hàng Âu Marcel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); border-bottom: 2px solid var(--gold); display: inline-block; padding-bottom: 10px; }
        .table-container { background: var(--card-bg); border-radius: 15px; padding: 20px; box-shadow: 0 8px 32px rgba(0,0,0,0.3); }
        .table { color: var(--text-light); border-color: #2b2f42; }
        .table thead { background-color: var(--gold); color: var(--dark); }
        .table tbody tr:hover { background-color: rgba(212, 175, 55, 0.1); cursor: pointer; transition: 0.3s; }
        .badge { font-weight: 300; border-radius: 20px; padding: 5px 12px; }
        .bg-warning { background: #f39c12 !important; color: #fff !important; }
        .bg-primary { background: var(--gold) !important; color: var(--dark) !important; }
        .bg-success { background: #27ae60 !important; }
        .bg-danger { background: #c0392b !important; }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4">Lịch sử đặt bàn</h2>
    
    <div class="table-container table-responsive">
        <table class="table table-hover align-middle">
            <thead class="text-uppercase">
                <tr>
                    <th>ID</th>
                    <th>Ngày</th>
                    <th>Bàn</th>
                    <th>Khách</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${reservationList}" var="r">
                    <tr>
                        <td><strong>#${r.reservationId}</strong></td>
                        <td><fmt:formatDate value="${r.reservationTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td>${r.restaurantTable.tableName}</td>
                        <td>${r.guestCount} <i class="fas fa-user text-gold"></i></td>
                        <td>
                            <c:choose>
                                <c:when test="${r.status=='PENDING'}"><span class="badge bg-warning">⏳ Chờ xác nhận</span></c:when>
                                <c:when test="${r.status=='CONFIRMED'}"><span class="badge bg-primary">✔ Đã xác nhận</span></c:when>
                                <c:when test="${r.status=='COMPLETED'}"><span class="badge bg-success">✔ Hoàn thành</span></c:when>
                                <c:otherwise><span class="badge bg-danger">✖ Đã hủy</span></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>