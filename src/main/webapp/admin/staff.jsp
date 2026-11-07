<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 20px; padding: 20px; }
        .table { color: var(--text-light); vertical-align: middle; }
        .table thead { background: var(--gold); color: var(--dark); }
        .table-hover tbody tr:hover { background: #1a1e33; color: var(--gold); }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: 600; }
        .btn-gold:hover { background: #b8962f; }
    </style>
</head>
<body class="p-4">

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>DANH SÁCH NHÂN VIÊN</h2>
        <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/admin/dashboard">← Dashboard</a>
    </div>

    <div class="card">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên nhân viên</th>
                    <th>Chức vụ</th>
                    <th>Số điện thoại</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="s" items="${staffList}">
                    <tr>
                        <td><strong>#${s.id}</strong></td>
                        <td>${s.name}</td>
                        <td><span class="badge" style="background:#2b2f42; color:var(--gold);">${s.position}</span></td>
                        <td>${s.phone}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>