<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Bàn - Marcel Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <style>
        :root { --gold: #d4af37; --dark: #0a0c16; --card-bg: #111424; --text-light: #fcfbf7; }
        body { background-color: var(--dark); color: var(--text-light); font-family: 'Montserrat', sans-serif; padding: 30px; }
        h2 { font-family: 'Playfair Display', serif; color: var(--gold); border-bottom: 1px solid var(--gold); padding-bottom: 10px; }
        
        .table-container { background: var(--card-bg); padding: 20px; border-radius: 15px; border: 1px solid #2b2f42; }
        .table { color: var(--text-light); width: 100%; border-collapse: collapse; }
        .table th { color: var(--gold); text-align: left; padding: 15px; border-bottom: 2px solid var(--gold); }
        .table td { padding: 15px; border-bottom: 1px solid #2b2f42; }
        
        .status-badge { 
            padding: 5px 12px; border-radius: 20px; font-size: 0.8em; font-weight: 600; 
            text-transform: uppercase; border: 1px solid var(--gold);
        }
    </style>
</head>
<body>

<div class="table-container">
    <h2>QUẢN LÝ BÀN ĂN</h2>
    <table class="table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên Bàn</th>
                <th>Trạng Thái</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="t" items="${tableList}">
                <tr>
                    <td>#${t.tableId}</td>
                    <td>${t.tableName}</td>
                    <td>
                        <span class="status-badge" style="color: ${t.status == 'EMPTY' ? '#28a745' : '#e74c3c'};">
                            ${t.status}
                        </span>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>