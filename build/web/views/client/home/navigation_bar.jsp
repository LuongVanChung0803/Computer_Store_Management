<%-- 
    Document   : navigation_bar
    Created on : Oct 30, 2024, 11:32:27 AM
    Author     : hc
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <div class="container">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="loadhome">Trang chủ</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        Sản phẩm
                    </a>
                    <ul class="dropdown-menu custom-scroll">
                        <c:forEach items="${ldms}" var="dm">
                            <li><a class="dropdown-item" href="#">${dm.ten_danhmuc}</a></li>
                            </c:forEach>
                    </ul>

                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Khuyến mãi</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        Dịch vụ
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Giao hàng</a></li>
                        <li><a class="dropdown-item" href="#">Bảo trì</a></li>
                        <li><a class="dropdown-item" href="#">Tư vấn</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Liên hệ</a>
                </li>
            </ul>
            <div class="d-flex">
<!--                <button class="btn btn-outline-success me-2">fakebook</button>
                <button class="btn btn-outline-primary">zalo</button>-->

            </div>
        </div>
    </div>