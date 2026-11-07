<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nguyên liệu - Marcel Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; display: flex; align-items: center; min-height: 100vh; }
        .card-container { width: 100%; max-width: 500px; margin: auto; background: var(--card-bg); padding: 40px; border-radius: 20px; border: 1px solid #2b2f42; box-shadow: 0 10px 40px rgba(0,0,0,0.5); }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); margin-bottom: 30px; text-align: center; }
        label { color: var(--gold); font-weight: 600; font-size: 0.9rem; margin-bottom: 8px; }
        .form-control, .form-select { background: #1a1e33; border: 1px solid #2b2f42; color: var(--text-light); padding: 12px; }
        .form-control:focus, .form-select:focus { background: #1a1e33; border-color: var(--gold); color: var(--text-light); box-shadow: 0 0 0 0.2rem rgba(212, 175, 55, 0.25); }
        .btn-gold { background: var(--gold); color: var(--dark); width: 100%; font-weight: bold; padding: 12px; border: none; transition: 0.3s; }
        .btn-gold:hover { background: #b8962f; }
        input::-webkit-outer-spin-button, input::-webkit-inner-spin-button { -webkit-appearance: none; margin: 0; }
    </style>
</head>
<body>

<div class="card-container">
    <h2>${ingredient.ingredientId==null ? "Thêm nguyên liệu" : "Cập nhật nguyên liệu"}</h2>
    
    <form method="post">
        <input type="hidden" name="ingredientId" value="${ingredient.ingredientId}">
        
        <div class="mb-3">
            <label>Tên nguyên liệu</label>
            <input class="form-control" name="ingredientName" value="${ingredient.ingredientName}" required>
        </div>
        
        <div class="row">
            <div class="col-md-6 mb-3">
                <label>Số lượng</label>
                <input type="number" step="0.1" class="form-control" name="quantity" value="${ingredient.quantity}" required>
            </div>
            <div class="col-md-6 mb-3">
                <label>Đơn vị</label>
                <select class="form-select" name="unit">
                    <option value="Kg" ${ingredient.unit=="Kg"?"selected":""}>Kg</option>
                    <option value="Gói" ${ingredient.unit=="Gói"?"selected":""}>Gói</option>
                    <option value="Lon" ${ingredient.unit=="Lon"?"selected":""}>Lon</option>
                    <option value="Chai" ${ingredient.unit=="Chai"?"selected":""}>Chai</option>
                    <option value="Lít" ${ingredient.unit=="Lít"?"selected":""}>Lít</option>
                </select>
            </div>
        </div>
        
        <div class="mb-4">
            <label>Tồn tối thiểu</label>
            <input type="number" step="0.1" class="form-control" name="minQuantity" value="${ingredient.minQuantity}" required>
        </div>

        <button class="btn btn-gold">Lưu nguyên liệu</button>
    </form>
</div>

</body>
</html>