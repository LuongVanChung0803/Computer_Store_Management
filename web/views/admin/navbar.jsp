<%-- 
    Document   : navbar.jsp
    Created on : Oct 25, 2024, 7:02:29 PM
    Author     : hc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto align-items-center">
            <!-- Dropdown Thông Báo -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="notificationsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-bell"></i>
                    <span class="badge badge-danger">3</span> Thông Báo
                </a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="notificationsDropdown">
                    <h6 class="dropdown-header">Thông Báo</h6>
                    <a class="dropdown-item" href="#">Đơn hàng mới được đặt</a>
                    <a class="dropdown-item" href="#">Hàng tồn kho sản phẩm X thấp</a>
                    <a class="dropdown-item" href="#">Khách hàng mới đăng ký</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item text-center" href="#">Xem tất cả thông báo</a>
                </div>
            </li>

            <!-- Dropdown Tin Nhắn -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-envelope"></i>
                    <span class="badge badge-primary">5</span> Tin Nhắn
                </a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="messagesDropdown">
                    <h6 class="dropdown-header">Tin Nhắn</h6>
                    <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="dropdown-message">
                            <strong>John Doe</strong>
                            <p class="small text-muted">Chào! Tôi cần sự trợ giúp về...</p>
                        </div>
                    </a>
                    <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="dropdown-message">
                            <strong>Jane Smith</strong>
                            <p class="small text-muted">Bạn có thể cập nhật tình trạng đơn hàng của tôi không?</p>
                        </div>
                    </a>
                    <a class="dropdown-item d-flex align-items-center" href="#">
                        <div class="dropdown-message">
                            <strong>Admin</strong>
                            <p class="small text-muted">Cập nhật hệ thống dự kiến vào...</p>
                        </div>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item text-center" href="#">Xem tất cả tin nhắn</a>
                </div>
            </li>

            <!-- Dropdown Hồ Sơ Người Dùng -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <img src="./assets/img/administrator_icon.png" alt="" class="rounded-circle" width="30" height="30">
                    Chào, Admin!
                </a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">Hồ Sơ</a>
                    <a class="dropdown-item" href="#">Cài Đặt</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="logout">Đăng Xuất</a>
                </div>
            </li>
        </ul>
    </div>
</nav>

