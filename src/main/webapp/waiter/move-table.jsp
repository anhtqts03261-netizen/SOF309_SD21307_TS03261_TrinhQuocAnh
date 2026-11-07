<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi bàn - Restaurant Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap" rel="stylesheet">

    <style>
        :root {
            --gold: #d4af37;
            --dark-bg: #0a0c16;
            --card-bg: #111424;
            --text-light: #fcfbf7;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--dark-bg);
            color: var(--text-light);
            min-height: 100vh;
            padding: 40px 0;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            color: var(--gold);
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 30px;
        }

        .back-link {
            color: #888;
            text-decoration: none;
            font-size: 14px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            margin-bottom: 25px;
        }

        .back-link i {
            margin-right: 8px;
            transition: transform 0.3s ease;
        }

        .back-link:hover {
            color: var(--gold);
        }

        .back-link:hover i {
            transform: translateX(-5px);
        }

        /* --- TABLE CARDS --- */
        .table-card {
            background-color: var(--card-bg);
            border: 1px solid rgba(212, 175, 55, 0.15);
            border-radius: 8px;
            padding: 25px 20px;
            text-align: center;
            transition: all 0.4s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .table-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.6);
            border-color: rgba(212, 175, 55, 0.5);
        }

        .table-card h5 {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            color: var(--text-light);
            margin-bottom: 15px;
            letter-spacing: 1px;
        }

        .table-capacity {
            font-size: 12px;
            color: #a0a0a0;
            margin-bottom: 25px;
            background: rgba(255, 255, 255, 0.05);
            padding: 6px 12px;
            border-radius: 20px;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .table-capacity b {
            color: var(--gold);
            font-weight: 600;
            font-size: 14px;
            margin-left: 4px;
        }

        .btn-move {
            background-color: transparent;
            color: var(--gold);
            border: 1px solid var(--gold);
            width: 100%;
            padding: 10px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            border-radius: 4px;
        }

        .btn-move:hover {
            background-color: var(--gold);
            color: var(--dark-bg);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }

        /* Hiệu ứng load danh sách bàn */
        .card-anim {
            animation: fadeInUp 0.6s ease forwards;
            opacity: 0;
            transform: translateY(20px);
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <a href="${pageContext.request.contextPath}/waiter/tables" class="back-link">
            <i class="fas fa-arrow-left"></i> Quay lại sơ đồ bàn
        </a>

        <h3 class="page-title text-center">
            Đổi bàn <span style="color: #fff;">${fromTable}</span>
        </h3>

        <div class="row g-4 mt-2">
            <c:forEach items="${tables}" var="t" varStatus="loop">
                <c:if test="${t.tableId!=fromTable && empty t.mergedWith && t.status=='EMPTY'}">
                    <div class="col-6 col-md-4 col-lg-3 card-anim" style="animation-delay: ${loop.index * 0.05}s;">
                        <div class="table-card">
                            <div>
                                <h5><i class="fas fa-chair me-2" style="color: rgba(212, 175, 55, 0.5); font-size: 18px;"></i>${t.tableName}</h5>
                                
                                <div class="table-capacity">
                                    <i class="fas fa-users me-1"></i> Sức chứa: <b>${t.capacity}</b>
                                </div>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/waiter/move-table?tableId=${fromTable}&targetTable=${t.tableId}" class="btn-move">
                                <i class="fas fa-exchange-alt me-1"></i> Đổi sang đây
                            </a>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>