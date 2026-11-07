<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Menu - Nhà hàng Âu Marcel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); }
        .card { background: var(--card-bg); border: 1px solid #2b2f42; border-radius: 20px; color: var(--text-light); }
        .card-header { background: #1a1e33 !important; border-bottom: 1px solid #2b2f42; border-radius: 20px 20px 0 0 !important; padding: 20px; color: var(--gold); font-size: 1.2rem; }
        .form-control, .form-select { background: #1a1e33; border: 1px solid #2b2f42; color: var(--text-light); }
        .table { color: var(--text-light); vertical-align: middle; }
        .table thead { background: var(--gold); color: var(--dark); }
        .btn-gold { background: var(--gold); color: var(--dark); border: none; font-weight: 600; }
        .btn-gold:hover { background: #b8962f; }
        .btn-outline-gold { border: 1px solid var(--gold); color: var(--gold); }
        .btn-outline-gold:hover { background: var(--gold); color: var(--dark); }
    </style>
</head>
<body class="p-4">

<div class="container">
    <h2 class="mb-4 text-center">🍽 Quản lý Thực đơn</h2>

    <div class="card shadow mb-5">
        <div class="card-header">
            <b>${editDish != null ? "Cập nhật món ăn" : "Thêm món mới"}</b>
        </div>
        <div class="card-body p-4">
            <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/${editDish != null ? 'admin/edit-dish' : 'admin/menu'}">
                <c:if test="${editDish != null}"><input type="hidden" name="dishId" value="${editDish.dishId}"></c:if>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label>Tên món</label>
                        <input class="form-control" name="dishName" required value="${editDish.dishName}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Giá</label>
                        <input type="number" class="form-control" name="price" required value="${editDish.price}">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Loại món</label>
                        <select class="form-select" name="category">
                            <option value="Món chính" ${editDish.category=="Món chính"?"selected":""}>Món chính</option>
                            <option value="Khai vị" ${editDish.category=="Khai vị"?"selected":""}>Khai vị</option>
                            <option value="Tráng miệng" ${editDish.category=="Tráng miệng"?"selected":""}>Tráng miệng</option>
                            <option value="Đồ uống" ${editDish.category=="Đồ uống"?"selected":""}>Đồ uống</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Ảnh món ăn</label>
                        <input type="file" class="form-control" name="image" id="image" accept="image/*" onchange="previewImage(event)">
                        <img id="preview" src="${pageContext.request.contextPath}/assets/images/menu/${not empty editDish.image ? editDish.image : 'default-food.png'}" width="120" height="90" class="mt-2" style="object-fit:cover; border-radius:10px;">
                    </div>
                    <div class="col-md-12">
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" name="isAvailable" ${editDish==null || editDish.isAvailable ? "checked" : ""}>
                            <label class="form-check-label">Đang kinh doanh</label>
                        </div>
                    </div>
                </div>
                <button class="btn btn-gold px-4">${editDish != null ? "💾 Cập nhật" : "➕ Thêm món"}</button>
                <c:if test="${editDish != null}">
                    <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/admin/menu">Hủy</a>
                </c:if>
            </form>
        </div>
    </div>

    <div class="card shadow">
        <div class="card-header"><b>Danh sách món ăn</b></div>
        <div class="card-body table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr><th>ID</th><th>Tên món</th><th>Giá</th><th>Loại</th><th>Ảnh</th><th>Trạng thái</th><th>Thao tác</th></tr>
                </thead>
                <tbody>
                    <c:forEach items="${dishList}" var="d">
                        <tr>
                            <td>#${d.dishId}</td>
                            <td><strong>${d.dishName}</strong></td>
                            <td>${d.price}</td>
                            <td>${d.category}</td>
                            <td><img src="${pageContext.request.contextPath}/assets/images/menu/${not empty d.image ? d.image : 'default-food.png'}" width="60" height="45" style="object-fit:cover; border-radius:5px;"></td>
                            <td>
                                <span class="badge ${d.isAvailable ? 'bg-success' : 'bg-danger'}">${d.isAvailable ? 'Có bán' : 'Ngừng bán'}</span>
                            </td>
                            <td>
                                <a class="btn btn-outline-warning btn-sm" href="${pageContext.request.contextPath}/admin/edit-dish?id=${d.dishId}">Sửa</a>
                                <a class="btn btn-outline-danger btn-sm" onclick="return confirm('Xóa món này?')" href="${pageContext.request.contextPath}/admin/delete-dish?id=${d.dishId}">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-4"><a href="dashboard" class="text-secondary text-decoration-none">← Quay lại Dashboard</a></div>
</div>

<script>
    function previewImage(event){
        const file = event.target.files[0];
        if(file){
            const reader = new FileReader();
            reader.onload = function(e){ document.getElementById("preview").src = e.target.result; }
            reader.readAsDataURL(file);
        }
    }
</script>

</body>
</html>