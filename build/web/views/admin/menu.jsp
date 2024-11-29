<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="sidebar bg-light p-3 ">
    <ul class="nav flex-column" id="sidebarMenu">
        <li class="nav-item">
            <a class="nav-link" href="loaddashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="loaduser"><i class="fas fa-users"></i> Quản Lý Tài Khoản</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="loadproduct"><i class="fas fa-boxes"></i> Quản Lý Sản Phẩm</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="loadoder"><i class="fas fa-shopping-cart"></i> Quản Lý Đơn Hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="loadcustommer"><i class="fas fa-user"></i> Quản Lý Khách Hàng</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="loadsupplier"><i class="fas fa-truck"></i> Quản Lý Nhà Cung Cấp</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="loadstatistics"><i class="fas fa-chart-bar"></i> Thống Kê</a>
        </li>
    </ul>
</div>

<script>
    // Get all nav-link elements inside the sidebar
    const navLinks = document.querySelectorAll("#sidebarMenu .nav-link");

    // Loop through each link and add a click event
    navLinks.forEach(link => {
        link.addEventListener("click", function() {
            // Remove active class from all links
            navLinks.forEach(nav => nav.classList.remove("active"));
            // Add active class to the clicked link
            this.classList.add("active");
        });
    });

    // Optional: Retain the active link on page load based on URL
    window.addEventListener("load", function() {
        navLinks.forEach(link => {
            if (link.href === window.location.href) {
                link.classList.add("active");
            }
        });
    });
</script>
