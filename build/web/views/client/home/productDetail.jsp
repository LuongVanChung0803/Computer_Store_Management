<%-- 
    Document   : productDetail
    Created on : Jun 13, 2024, 10:46:49 PM
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
        <title>${product.ten_sanpham} - Product Details</title>
        <link rel="stylesheet" href="./assets/bootstrap-5.0.2-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link rel="stylesheet" href="./assets/css/index2.css">

        <link href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap" rel="stylesheet">
        <!--        <link href="./assets/css/index_product.css" rel="stylesheet">-->
        <style>
            .image-container img {
                width:500px;
                height: 435px;
            }



        </style>
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
        <!--contact_and_cart-->
        <%@ include file="/views/client/home/contact_and_cart.jsp" %>
        <div class="container my-5">
            <!-- Product Detail Section -->
            <div class="row mb-5">
                <!-- Product Image Section (Left) -->
                <div class="col-md-4">
                    <div class="image-container">
                        <img src="./assets/image_product/${product.link_anh}" alt="${product.ten_sanpham}" class="img-fluid rounded shadow">
                    </div>
                </div>

                <!-- Product Info Section (Right) -->
                <div class="col-md-8">
                    <!-- Product Description (Above) -->
                    <h1>${product.ten_sanpham}</h1>
                    <p>${product.mo_ta}</p>
                    
                    <h2><fmt:formatNumber value="${product.gia_ban}" type="currency" currencySymbol="VND" pattern="#,##0" /> VND</h2>
                    <form action="DetaiToAddToCartServlet" method="post" >
                        <input type="hidden" name="id_sanpham" value="${product.id_sanpham}">
                        <input type="hidden" name="gia_ban" value="${product.gia_ban}">
                        <input type="hidden" name="soLuong" value="1">
                        <input type="hidden" name="idNguoiDung" value="${sessionScope.user.id_nguoidung}">
                        <input type="hidden" name="linkAnh" value="${product.link_anh}">
                        <button type="submit" class="btn btn-primary"onclick="addToCart()">Thêm Vào Giỏ Hàng</button>
                    </form>

                    <!-- Warranty and Gifts Table -->
                    <div class="mt-4">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th colspan="2" class="text-center">Bảo Hành & Quà Tặng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="align-middle">&#128736;</td>
                                    <td>Đổi mới trong vòng 12 tháng tại các cửa hàng trên toàn quốc (tháng đầu tiên miễn phí)</td>
                                </tr>
                                <tr>
                                    <td class="align-middle">&#128737;</td>
                                    <td>Bảo hành chính thức 1 năm cho máy tính tại các trung tâm bảo hành của thương hiệu</td>
                                </tr>
                                <tr>
                                    <td class="align-middle">&#128736;</td>
                                    <td>
                                        <ul>
                                            <li>Đầu tiên: Túi chống sốc laptop</li>
                                            <li>Thứ hai: Bàn phím máy tính</li>
                                            <li>Thứ ba: Bộ vệ sinh laptop</li>
                                        </ul>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

            <!-- New Products Section (6 products per row) -->
            <div class="row mt-5">
                <div class="col-12">
                    <h2>Sản Phẩm Tương Tự</h2>
                    <div class="row">
                        <c:forEach items="${spss}" var="x">
                            <div class="col-md-2 col-sm-4 mb-4">
                                <div class="card">
                                    <img src="./assets/image_product/${x.link_anh}" alt="${x.ten_sanpham}" class="card-img-top">
                                    <div class="card-body">
                                        <h5 class="card-title">${x.ten_sanpham}</h5>
<!--                                        <p type="hidden"  class="card-text">${x.mo_ta}</p>-->
                                        <div class="d-flex justify-content-between align-items-center">
                                             
                                            <span> <fmt:formatNumber value="${x.gia_ban}" type="currency" currencySymbol="VND" pattern="#,##0" /> VND</span>
                                            <a href="productDetailServlet?id=${x.id_sanpham}" class="btn btn-outline-primary btn-sm">Chi tiết</a>
                                        </div>
                                        <form action="DetaiToAddToCartServlet" method="POST" >
                                            <input type="hidden" name="id_sanpham" value="${x.id_sanpham}">
                                            <input type="hidden" name="gia_ban" value="${x.gia_ban}">
                                            <input type="hidden" name="soLuong" value="1">
                                            <input type="hidden" name="idNguoiDung" value="${sessionScope.user.id_nguoidung}">
                                            <input type="hidden" name="linkAnh" value="${x.link_anh}">
                                            <button type="submit" class="btn btn-primary btn-sm mt-2" onclick="addToCart()">Thêm Vào Giỏ Hàng</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer -->
        <%@ include file="/views/client/home/footer.jsp" %>
        <!-- Footer -->

        <script>
            // Hàm hiển thị thông báo khi nhấn nút
            function addToCart() {
                // Hiển thị thông báo đơn giản
                alert("Item added to cart successfully!");
            }
        </script>

        <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
        <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
        <script src="./assets/bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
