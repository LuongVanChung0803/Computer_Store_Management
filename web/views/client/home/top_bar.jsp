<%-- 
    Document   : top_bar
    Created on : Oct 30, 2024, 11:34:43 AM
    Author     : hc
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="container d-flex justify-content-between">
    <div>
        <span class="icon">⏰</span> Cam kết giá tốt nhất |
        <span class="icon">🚚</span> Miễn phí vận chuyển |
        <span class="icon">💳</span> Thanh toán khi nhận hàng |
        <span class="icon">🔄</span> Đổi trả trong 7 ngày |
        <span class="icon">🛡️</span> Bảo hành tận nơi
    </div>
    <div>
        <!-- Right side: Account dropdown, logout, and cart links -->
        <div class="d-flex align-items-center ">
            <div class="dropdown">
                <a href="#" class="dropdown-toggle" role="button" id="accountDropdown" data-bs-toggle="dropdown"
                   aria-expanded="false">
                    👤 <c:if test="${not empty sessionScope.user}">
                        ${sessionScope.user.ten_dangnhap}!
                        <p hidden>You are logged in as: ${sessionScope.user.email}</p>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        Tài khoản
                    </c:if>
                </a>
                <ul class="dropdown-menu" aria-labelledby="accountDropdown">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li><a class="dropdown-item" href="customerInformationServlet?sid=${sessionScope.user.id_nguoidung}">Hồ Sơ</a></li>
                            <li><a class="dropdown-item" href="OderServlet?sid=${sessionScope.user.id_nguoidung}">Đơn Hàng</a></li>
                            <li>
                                <a class="dropdown-item" href="#" onclick="confirmLogout()">Đăng Xuất</a>
                            </li>

                        </c:when>
                        <c:otherwise>
                            <li><a class="dropdown-item" href="loadlogin">Đăng Nhập</a></li>
                            <li><a class="dropdown-item" href="dangkyServlet">Đăng Ký</a></li>
                            </c:otherwise>
                        </c:choose>
                </ul>
            </div>
            <a href="CartServlet?sid=${sessionScope.user.id_nguoidung}" class="ms-3"><i class="fas fa-shopping-cart"></i> Giỏ hàng</a>
        </div>
    </div>
</div>
<script>
    function confirmLogout() {
        const isConfirmed = confirm("Bạn có chắc chắn muốn đăng xuất không?");
        if (isConfirmed) {
            // Điều hướng đến servlet xử lý logout
            window.location.href = 'logout';
        }
    }
</script>
