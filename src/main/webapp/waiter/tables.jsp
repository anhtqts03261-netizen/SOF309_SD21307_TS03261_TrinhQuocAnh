<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý bàn - Restaurant Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root { --gold: #d4af37; --dark-bg: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { font-family: 'Montserrat', sans-serif; background-color: var(--dark-bg); color: var(--text-light); min-height: 100vh; padding: 40px 0; }
        .page-title { font-family: 'Playfair Display', serif; color: var(--gold); font-weight: 700; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 30px; }
        
        .table-card { background-color: var(--card-bg); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 8px; padding: 20px; transition: 0.3s; height: 100%; position: relative; }
        .table-card:hover { border-color: var(--gold); transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.5); }
        
        .status-badge { font-size: 11px; text-transform: uppercase; letter-spacing: 1px; padding: 4px 10px; border-radius: 4px; }
        .bg-empty { background: rgba(40,167,69,0.2); color: #28a745; }
        .bg-serving { background: rgba(220,53,69,0.2); color: #dc3545; }
        .bg-reserved { background: rgba(255,193,7,0.2); color: #ffc107; }

        .btn-custom { font-size: 11px; text-transform: uppercase; padding: 5px 10px; margin: 2px; border: 1px solid var(--gold); color: var(--gold); background: transparent; }
        .btn-custom:hover { background: var(--gold); color: var(--dark-bg); }
    </style>
</head>
<body>
<div class="container">
    <h2 class="page-title"><i class="fas fa-chair me-2"></i> Quản lý bàn</h2>
    <div class="row g-3">
        <c:forEach items="${tables}" var="t">
            <c:if test="${empty t.mergedWith}">
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="table-card">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h5 class="m-0">${t.tableName}</h5>
                            <c:set var="count" value="0"/><c:forEach items="${tables}" var="m"><c:if test="${m.mergedWith == t.tableId}"><c:set var="count" value="${count+1}"/></c:if></c:forEach>
                            <c:if test="${count > 0}"><span class="badge bg-primary">${count+1} bàn</span></c:if>
                        </div>
                        <div class="mb-3">
                            <c:choose>
                                <c:when test="${t.status=='EMPTY'}"><span class="status-badge bg-empty">Trống</span></c:when>
                                <c:when test="${t.status=='SERVING'}"><span class="status-badge bg-serving">Đang phục vụ</span></c:when>
                                <c:otherwise><span class="status-badge bg-reserved">${t.status}</span></c:otherwise>
                            </c:choose>
                        </div>
                        <div class="d-flex flex-wrap">
                            <a class="btn btn-custom" href="${pageContext.request.contextPath}/waiter/order?tableId=${t.tableId}">Chọn</a>
                            <a class="btn btn-custom" href="${pageContext.request.contextPath}/waiter/merge-table?tableId=${t.tableId}">Ghép</a>
                            <a class="btn btn-custom" href="${pageContext.request.contextPath}/waiter/move-table?tableId=${t.tableId}">Đổi</a>
                            <a class="btn btn-custom" href="${pageContext.request.contextPath}/waiter/unmerge-table?tableId=${t.tableId}">Tách</a>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>
</body>
</html>