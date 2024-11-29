<%-- 
    Document   : contact_and_cart
    Created on : Oct 30, 2024, 11:30:35 AM
    Author     : hc
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Nút giỏ hàng -->
<div class="cart-button">
    <a href="CartServlet?sid=${sessionScope.user.id_nguoidung}"><img src="./assets/img/icon-gio-hang-mau-trang.png" alt="Giỏ Hàng"></a>
</div>
<!-- Floating Contact Sidebar -->
<div class="floating-contact">
    <a href="https://www.facebook.com/profile.php?id=100060813557362" class="contact-icon facebook" title="Chat Facebook">
        <i class="fab fa-facebook-f"></i>
    </a>
    <a href="#" class="contact-icon youtube" title="YouTube">
        <i class="fab fa-youtube"></i>
    </a>
    <a href="#" class="contact-icon email" title="Email">
        <i class="fas fa-envelope"></i>
    </a>
    <a href="#" class="contact-icon phone" title="Hotline">
        <i class="fas fa-phone-alt"></i>
    </a>
</div>
<!-- Floating Contact Sidebar with Icons and Text -->
<div class="floating-contacts">
    <div class="contact-item facebook">
        <a href="https://www.facebook.com/profile.php?id=100060813557362" class="contact-icon facebook" title="Chat Facebook">
            <i class="fab fa-facebook-f"></i>
        </a>
        <span><strong>Chat Facebook</strong> (8h-21h)</span>
    </div>
    <div class="contact-item zalo">
        <a href="#" class="contact-icon youtube" title="Hotline">
            <i class="fas fa-comments"></i>
        </a>
        <span><strong>Chat Zalo</strong> (8h-21h)</span>
    </div>
    <div class="contact-item phone">
        <a href="#" class="contact-icon phone" title="Hotline">
            <i class="fas fa-phone-alt"></i>
        </a>
        <span><strong>0867127278</strong> (8h-21h)</span>
    </div>
</div>
<!-- Thông báo giỏ hàng -->
<div id="cartNotification" class="alert alert-success alert-dismissible fade show" role="alert" style="display:none; position: fixed; top: 10px; right: 10px; z-index: 9999;">
    <img src="./assets/img/icon-gio-hang-mau-trang.png" alt="Cart Icon" class="mr-2" style="width: 24px; height: 24px;">
    Sản phẩm đã được thêm vào giỏ hàng!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>

</div>
<script>
    function showCartNotification(event) {
        event.preventDefault(); // Ngừng hành động gửi form mặc định

        // Lấy form và phần tử thông báo giỏ hàng
        var form = event.target;
        var notification = document.getElementById('cartNotification');

        // Hiển thị thông báo giỏ hàng
        notification.style.display = 'block';

        // Ẩn thông báo sau 3 giây và sau đó submit form
        setTimeout(function () {
            notification.style.display = 'none';
            form.submit(); // Gửi form sau khi ẩn thông báo
        }, 1500); // Thời gian hiển thị thông báo (3 giây)
    }
</script>
