<%-- 
    Document   : header
    Created on : Oct 30, 2024, 5:51:43 PM
    Author     : hc
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="row align-items-center">
    <!-- Logo -->
    <div class="col-lg-4 text-center text-lg-start">
        <a class="navbar-brand-custom" href="loadhome">
            <img src="./assets/img/logo.webp" alt="" style="height: 50px;">
            LAPTOP <span style="color: #ff0000;">WORLD</span>
        </a>
        <div>Thế giới là của bạn!</div>
    </div>

    <!-- Search Bar -->
    <div class="col-lg-4 my-2 my-lg-0 search-bar flex-grow-1 d-flex align-items-center mr-3">
        <!--                    <div class="container mt-5">-->
        <div class="search-container">
            <form action="SearchProductServlet"  method="get">
                <input type="text" name="keyword" id="searchInput"  class="form-control search-input" placeholder="Nhập từ khóa tìm kiếm ...">
            </form>
        </div>
    </div>

    <!-- Contact and Config Buttons -->
    <div class="col-lg-4 d-flex justify-content-center justify-content-lg-end gap-1">
        <div class="phone-box">
            <div class="phone-number">
                <img src="./assets/img/bn.jpg" alt="">
            </div>
        </div>
    </div>

</div>
