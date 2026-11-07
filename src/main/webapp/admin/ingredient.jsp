<c:choose>
    <c:when test="${i.quantity <= i.minQuantity}">
        <!-- Màu đỏ đậm để cảnh báo sự cấp bách mà vẫn giữ vẻ sang trọng -->
        <span class="badge" style="background-color: #8b0000; color: #fff; border-radius: 20px; padding: 5px 12px;">
            <i class="fas fa-exclamation-triangle"></i> Sắp hết
        </span>
    </c:when>
    <c:otherwise>
        <!-- Sử dụng tông màu xanh trầm hoặc vàng gold làm nổi bật trạng thái đủ hàng -->
        <span class="badge" style="background-color: rgba(212, 175, 55, 0.2); color: #d4af37; border: 1px solid #d4af37; border-radius: 20px; padding: 5px 12px;">
            <i class="fas fa-check-circle"></i> Đủ
        </span>
    </c:otherwise>
</c:choose>