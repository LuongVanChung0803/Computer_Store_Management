<%-- 
    Document   : searchpage
    Created on : Nov 8, 2024, 3:55:59 PM
    Author     : hc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tim Kiếm</title>
        <link rel="stylesheet" href="./assets/bootstrap-5.0.2-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link rel="stylesheet" href="./assets/css/index2.css">
        <link href="./assets/css/cart_oder.css" rel="stylesheet">

        <link href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap" rel="stylesheet">
        <!--        <link href="./assets/css/index_product.css" rel="stylesheet">-->
    </head>
    <body>
        <!-- Top Bar -->
        <div class="top-bar py-2">
            <%@ include file="/views/client/home/top_bar.jsp" %>
        </div>

        <!-- Main Header -->
        <div class="container my-4">
            <%@ include file="/views/client/home/header.jsp" %>
        </div>
        
    
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-navbar">
            <%@ include file="/views/client/home/navigation_bar.jsp" %>
        </nav>
        <div class="container my-5">
        <!-- New Products Section (6 products per row) -->
            <div class="row mt-5">
                <div class="col-12">
                    <h3 style="margin: 20px ;text-align: center">Sản phẩm tìm kiếm liên quan</h3>
                    <div class="row">
                        <c:forEach items="${searchResults}" var="x">
                            <div class="col-md-2 col-sm-4 mb-4">
                                <div class="card">
                                    <img src="./assets/image_product/${x.link_anh}" alt="${x.ten_sanpham}" class="card-img-top">
                                    <div class="card-body">
                                        <h5 class="card-title">${x.ten_sanpham}</h5>
<!--                                        <p type="hidden"  class="card-text">${x.mo_ta}</p>-->
                                        <p><fmt:formatNumber value="${x.gia_ban}" type="currency" currencySymbol="VND" pattern="#,##0" /> VND</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                             
                                            <a href="productDetailServlet?id=${x.id_sanpham}" class="btn btn-outline-primary btn-sm">Chi Tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!--contact_and_cart-->
        <%@ include file="/views/client/home/contact_and_cart.jsp" %>
        <!-- top navbar -->
        <!-- navbar -->

        <%@ include file="/views/client/home/footer.jsp" %>
        <!-- Footer -->

        <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
        <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
        <script src="./assets/bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script>
        
    </body>
</html>

