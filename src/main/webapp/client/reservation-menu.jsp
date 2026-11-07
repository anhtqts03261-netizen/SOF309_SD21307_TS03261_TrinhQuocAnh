<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thực đơn đặt bàn - Nhà hàng Marcel</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); text-align: center; margin-bottom: 30px; letter-spacing: 2px; }
        .info-bar { background: rgba(212,175,55,0.1); border: 1px solid rgba(212,175,55,0.2); padding: 20px; border-radius: 8px; margin-bottom: 30px; }
        
        .dish-card { background: var(--card-bg); border: 1px solid rgba(212,175,55,0.15); border-radius: 8px; padding: 15px; height: 100%; text-align: center; }
        .dish-img { width: 100%; height: 150px; object-fit: cover; border-radius: 6px; margin-bottom: 15px; }
        
        .quantity-box { display: flex; align-items: center; justify-content: center; gap: 10px; margin-top: 10px; }
        .btn-gold-sm { background: var(--gold); color: var(--dark-bg); border: none; padding: 5px 15px; border-radius: 4px; font-weight: 600; }
        .btn-outline-gold { border: 1px solid var(--gold); color: var(--gold); padding: 5px 15px; border-radius: 4px; }
    </style>
</head>
<body>

<c:if test="${sessionScope.customer==null}"><c:redirect url="/client/login"/></c:if>

<div class="container">
    <h1 class="page-title">ĐẶT BÀN ONLINE</h1>
    
    <div class="info-bar d-flex justify-content-between">
        <div><b>Bàn:</b> ${sessionScope.selectedTable}</div>
        <div><b>Số khách:</b> ${sessionScope.guestCount}</div>
        <div><b>Thời gian:</b> ${sessionScope.reservationTime}</div>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>Giỏ món (${empty sessionScope.reservationCart ? 0 : sessionScope.reservationCart.size()})</h3>
        <div>
            <a href="${pageContext.request.contextPath}/client/reservation-cart.jsp" class="text-gold text-decoration-none me-3">Xem giỏ hàng</a>
            <a href="${pageContext.request.contextPath}/client/reservation-cart?action=clear" class="text-danger text-decoration-none">Xóa tất cả</a>
        </div>
    </div>

    <div class="row g-4">
        <c:forEach items="${dishes}" var="dish">
            <div class="col-6 col-md-3">
                <div class="dish-card">
                    <c:choose>
                        <c:when test="${not empty dish.image}"><img src="${pageContext.request.contextPath}/assets/images/menu/${dish.image}" class="dish-img"></c:when>
                        <c:otherwise><div class="dish-img bg-dark d-flex align-items-center justify-content-center">No Image</div></c:otherwise>
                    </c:choose>
                    <h6>${dish.dishName}</h6>
                    <div class="text-gold fw-bold mb-2">${dish.price} VNĐ</div>

                    <c:choose>
                        <c:when test="${empty quantityMap[dish.dishId]}">
                            <form method="post" action="${pageContext.request.contextPath}/client/reservation-cart">
                                <input type="hidden" name="action" value="add"><input type="hidden" name="dishId" value="${dish.dishId}">
                                <button class="btn btn-gold-sm w-100">Thêm món</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <div class="quantity-box">
                                <form method="post" action="${pageContext.request.contextPath}/client/reservation-cart"><input type="hidden" name="action" value="minus"><input type="hidden" name="dishId" value="${dish.dishId}"><button class="btn btn-outline-gold">-</button></form>
                                <span class="fw-bold fs-5">${quantityMap[dish.dishId]}</span>
                                <form method="post" action="${pageContext.request.contextPath}/client/reservation-cart"><input type="hidden" name="action" value="add"><input type="hidden" name="dishId" value="${dish.dishId}"><button class="btn btn-gold-sm">+</button></form>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/client/reservation-cart" class="mt-2">
                                <input type="hidden" name="action" value="remove"><input type="hidden" name="dishId" value="${dish.dishId}">
                                <button class="btn btn-link text-danger btn-sm text-decoration-none">Xóa</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="mt-5 text-center">
        <a href="${pageContext.request.contextPath}/client/reservation" class="btn btn-outline-secondary me-3">← Quay lại đặt bàn</a>
        <a href="${pageContext.request.contextPath}/client/reservation-cart.jsp" class="btn btn-gold">Tiếp tục →</a>
    </div>
</div>

</body>
</html>