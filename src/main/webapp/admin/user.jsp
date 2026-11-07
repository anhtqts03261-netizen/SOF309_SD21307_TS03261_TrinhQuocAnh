<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý nhân viên - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; padding-bottom: 50px; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 15px; color: var(--text-light); }
        .card-header { background: #1a1e33; color: var(--gold); border-bottom: 1px solid var(--gold); font-weight: 600; }
        
        input, select { background: #1a1e33 !important; border: 1px solid #2b2f42 !important; color: var(--text-light) !important; }
        input:focus { border-color: var(--gold) !important; }
        
        .table { color: var(--text-light); vertical-align: middle; }
        .table thead { background: #1a1e33; color: var(--gold); }
        .btn-gold { background: var(--gold); color: var(--dark); font-weight: 600; }
        .btn-gold:hover { background: #b8962f; }
        .badge { font-weight: 400; }
    </style>
</head>
<body class="p-4">

<div class="container">
    <h2 class="mb-4">Quản lý nhân viên</h2>

    <c:if test="${message!=null}">
        <div class="alert alert-warning">${message}</div>
    </c:if>

    <!-- FORM -->
    <div class="card mb-4">
        <div class="card-header">Thông tin nhân viên</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/user" method="post">
                <input type="hidden" name="action" value="${editUser!=null?'update':'create'}">
                <div class="row g-3">
                    <div class="col-md-3"><label>Username</label><input class="form-control" name="username" value="${editUser.username}" ${editUser!=null?'readonly':''} required></div>
                    <div class="col-md-3"><label>Password</label><input type="password" class="form-control" name="password" value="${editUser.password}" required></div>
                    <div class="col-md-3"><label>Họ tên</label><input class="form-control" name="fullName" value="${editUser.fullName}" required></div>
                    <div class="col-md-3"><label>Vai trò</label>
                        <select class="form-select" name="role">
                            <option value="ADMIN" ${editUser.role=='ADMIN'?'selected':''}>ADMIN</option>
                            <option value="WAITER" ${editUser.role=='WAITER'?'selected':''}>WAITER</option>
                            <option value="CHEF" ${editUser.role=='CHEF'?'selected':''}>CHEF</option>
                            <option value="STOREKEEPER" ${editUser.role=='STOREKEEPER'?'selected':''}>STOREKEEPER</option>
                        </select>
                    </div>
                </div>
                <div class="row g-3 mt-1">
                    <div class="col-md-4"><label>Email</label><input class="form-control" name="email" value="${editUser.email}"></div>
                    <div class="col-md-4"><label>Số điện thoại</label><input class="form-control" name="phone" value="${editUser.phone}"></div>
                    <div class="col-md-4 d-flex align-items-end">
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" name="isActive" ${editUser.isActive?'checked':''}>
                            <label class="form-check-label">Hoạt động</label>
                        </div>
                    </div>
                </div>
                <div class="mt-4">
                    <button class="btn btn-gold">${editUser!=null?'Cập nhật':'Thêm nhân viên'}</button>
                    <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-outline-light">Làm mới</a>
                </div>
            </form>
        </div>
    </div>

    <!-- TABLE -->
    <div class="card">
        <div class="card-header">Danh sách nhân viên</div>
        <table class="table table-hover mb-0">
            <thead>
                <tr><th>Username</th><th>Họ tên</th><th>Email</th><th>Vai trò</th><th>Trạng thái</th><th>Thao tác</th></tr>
            </thead>
            <tbody>
                <c:forEach items="${userList}" var="u">
                    <tr>
                        <td>${u.username}</td>
                        <td>${u.fullName}</td>
                        <td>${u.email}</td>
                        <td><span class="text-gold">${u.role}</span></td>
                        <td><span class="badge ${u.isActive?'bg-success':'bg-danger'}">${u.isActive?'Hoạt động':'Khóa'}</span></td>
                        <td>
                            <a class="btn btn-sm btn-outline-warning" href="${pageContext.request.contextPath}/admin/user?action=edit&username=${u.username}">Sửa</a>
                            <a class="btn btn-sm btn-outline-danger" onclick="return confirm('Xóa nhân viên này?')" href="${pageContext.request.contextPath}/admin/user?action=delete&username=${u.username}">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="mt-4"><a href="dashboard" class="text-secondary text-decoration-none">&larr; Quay lại Dashboard</a></div>
</div>

</body>
</html>