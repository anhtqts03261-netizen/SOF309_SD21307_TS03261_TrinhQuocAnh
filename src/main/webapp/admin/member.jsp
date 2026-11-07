<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hội viên - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .table-box { background: var(--card-bg); padding: 25px; border-radius: 15px; border: 1px solid #2b2f42; }
        .table { color: var(--text-light); border-color: #2b2f42; vertical-align: middle; }
        .table thead { background: var(--gold); color: var(--dark); }
        .form-control { background: #1a1e33; border: 1px solid #2b2f42; color: var(--text-light); padding: 12px; }
        .form-control:focus { background: #1a1e33; border-color: var(--gold); color: var(--text-light); box-shadow: 0 0 0 0.2rem rgba(212, 175, 55, 0.25); }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: 600; padding: 12px 25px; }
        .btn-gold:hover { background: #b8962f; }
        .badge-rank { color: var(--gold); border: 1px solid var(--gold); background: transparent; padding: 5px 12px; }
        .table-hover tbody tr:hover { background-color: #1a1e33; }
    </style>
</head>
<body class="p-4">

<div class="container-fluid">
    <h2 class="mb-4"><i class="bi bi-person-vcard"></i> Quản lý hội viên</h2>

    <!-- Search -->
    <form method="get" action="${pageContext.request.contextPath}/admin/member" class="row g-2 mb-4">
        <div class="col-md-6">
            <input type="text" class="form-control" name="keyword" placeholder="Nhập tên hoặc số điện thoại..." value="${param.keyword}">
        </div>
        <div class="col-auto">
            <button class="btn btn-gold"><i class="bi bi-search"></i> Tìm kiếm</button>
        </div>
    </form>

    <div class="table-box table-responsive">
        <table class="table table-hover">
            <thead class="text-uppercase">
                <tr>
                    <th>ID</th>
                    <th>Họ tên</th>
                    <th>Điện thoại</th>
                    <th>Email</th>
                    <th>Điểm</th>
                    <th>Hạng</th>
                    <th>Trạng thái</th>
                    <th width="320">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${memberList}" var="m">
                    <tr>
                        <td>#${m.customerId}</td>
                        <td><strong>${m.fullName}</strong></td>
                        <td>${m.phone}</td>
                        <td>${m.email}</td>
                        <td>${m.rewardPoints}</td>
                        <td><span class="badge badge-rank">${m.rank}</span></td>
                        <td>
                            <c:choose>
                                <c:when test="${m.isActive}"><span class="badge bg-success">Hoạt động</span></c:when>
                                <c:otherwise><span class="badge bg-danger">Đã khóa</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="btn-group mb-2">
                                <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/admin/member-rank?id=${m.customerId}&rank=Silver">Silver</a>
                                <a class="btn btn-outline-warning btn-sm" href="${pageContext.request.contextPath}/admin/member-rank?id=${m.customerId}&rank=Gold">Gold</a>
                                <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/admin/member-rank?id=${m.customerId}&rank=Platinum">Platinum</a>
                            </div>
                            <div class="mt-1">
                                <c:choose>
                                    <c:when test="${m.isActive}">
                                        <a class="btn btn-outline-danger btn-sm" onclick="return confirm('Khóa hội viên này?')" href="${pageContext.request.contextPath}/admin/member-status?id=${m.customerId}&active=false">
                                            <i class="bi bi-lock"></i> Khóa
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="btn btn-outline-success btn-sm" onclick="return confirm('Mở khóa hội viên này?')" href="${pageContext.request.contextPath}/admin/member-status?id=${m.customerId}&active=true">
                                            <i class="bi bi-unlock"></i> Mở khóa
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="mt-4">
        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/dashboard">← Dashboard</a>
    </div>
</div>

</body>
</html>