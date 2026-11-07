<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách chế biến - Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 30px; }
        
        .custom-card { background: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; box-shadow: 0 10px 25px rgba(0,0,0,0.4); padding: 25px; }
        
        .custom-table { color: var(--text-light); margin-bottom: 0; }
        .custom-table thead th { background: rgba(10,12,22,0.9) !important; color: var(--gold) !important; text-transform: uppercase; font-size: 13px; letter-spacing: 1px; }
        .custom-table tbody td { border-bottom: 1px solid rgba(255,255,255,0.05); vertical-align: middle; }
        
        .badge { font-weight: 500; padding: 6px 12px; border-radius: 20px; font-size: 12px; text-transform: uppercase; }
        
        .btn-gold { background: var(--gold); color: var(--dark-bg); font-weight: 600; font-size: 12px; text-transform: uppercase; padding: 6px 15px; }
        .btn-gold:hover { background: #f3c63e; }
    </style>
</head>
<body>

<div class="container">
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show mb-4"><i class="fas fa-times-circle me-2"></i> ${sessionScope.error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        <c:remove var="error" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.success}">
        <div class="alert alert-success alert-dismissible fade show mb-4" style="background: rgba(40,167,69,0.1); border-color: rgba(40,167,69,0.3); color: #51cf66;"><i class="fas fa-check-circle me-2"></i> ${sessionScope.success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>
        <c:remove var="success" scope="session"/>
    </c:if>

    <h2 class="page-title"><i class="fas fa-utensils me-2"></i> Danh sách món cần chế biến</h2>

    <div class="custom-card">
        <div class="table-responsive">
            <table class="table custom-table table-hover align-middle">
                <thead>
                    <tr>
                        <th>Bàn</th>
                        <th>Món</th>
                        <th>Số lượng</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${queue}" var="d">
                        <tr>
                            <td><b style="color: var(--gold);">${d.order.restaurantTable.tableName}</b></td>
                            <td>${d.dish.dishName}</td>
                            <td>${d.quantity}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${d.itemStatus=='PENDING'}"><span class="badge bg-warning text-dark">Chờ chế biến</span></c:when>
                                    <c:when test="${d.itemStatus=='PREPARING'}"><span class="badge bg-primary">Đang chế biến</span></c:when>
                                    <c:when test="${d.itemStatus=='COMPLETED'}"><span class="badge bg-success">Hoàn thành</span></c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${d.itemStatus=='PENDING'}">
                                    <form action="${pageContext.request.contextPath}/kitchen/preparing" method="post">
                                        <input type="hidden" name="detailId" value="${d.orderDetailId}">
                                        <button class="btn btn-gold btn-sm"><i class="fas fa-fire me-1"></i> Nhận làm</button>
                                    </form>
                                </c:if>
                                <c:if test="${d.itemStatus=='PREPARING'}">
                                    <form action="${pageContext.request.contextPath}/kitchen/complete" method="post">
                                        <input type="hidden" name="detailId" value="${d.orderDetailId}">
                                        <button class="btn btn-success btn-sm"><i class="fas fa-check me-1"></i> Hoàn thành</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-4">
        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>