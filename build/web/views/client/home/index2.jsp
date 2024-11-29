<%-- 
    Document   : index2
    Created on : Oct 26, 2024, 10:44:56 PM
    Author     : hc
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang Laptopworld</title>
        <link rel="stylesheet" href="./assets/bootstrap-5.0.2-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link rel="stylesheet" href="./assets/css/index2.css">
        <style>

            .banner {
                text-align: center;
                /*    padding: 20px;
                    margin-bottom: 20px;*/
                background-color: white;
            }
            .custom-scroll {
                max-height: 542px; /* Giới hạn chiều cao của sidebar */
                overflow-y: auto; /* Bật cuộn dọc khi vượt quá chiều cao */
                border: 1px solid #ddd; /* Tùy chỉnh viền */
                padding: 10px;
                background-color: #f9f9f9;
            }

            /* Tùy chỉnh thanh cuộn để phù hợp với giao diện */
            .custom-scroll::-webkit-scrollbar {
                width: 8px;
            }

            .custom-scroll::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            .custom-scroll::-webkit-scrollbar-thumb {
                background: #888;
                border-radius: 4px;
            }

            .custom-scroll::-webkit-scrollbar-thumb:hover {
                background: #555;
            }
            /* Định dạng cho từng item trong sidebar */
            .sidebar-item {
                display: block;
                padding: 8px;
                color: #333;
                text-decoration: none;
            }

            .sidebar-item:hover {
                background-color: #e0e0e0;
                color: #000;
            }

            /* Tùy chỉnh thanh cuộn */
            .custom-scroll::-webkit-scrollbar {
                width: 8px;
            }

            .custom-scroll::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            .custom-scroll::-webkit-scrollbar-thumb {
                background: #888;
                border-radius: 4px;
            }

            .custom-scroll::-webkit-scrollbar-thumb:hover {
                background: #555;
            }
            .product-item img {
                max-width: 150px;
                height: auto;
                display: block;
                margin: 0 auto;
            }
            .product-item {
                width: 200px;
                height: 400px;
            }
            .product-name {
                font-size: 16px;
                font-weight: 600;
                color: #333;
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

        <div class="container">
            <!-- Sidebar and Main Content Row -->
            <div class="row">
                <!-- Sidebar (Danh mục sản phẩm) -->
                <div class="col-md-3">
                    <div class="sidebar custom-scroll">
                        <h4>Danh mục sản phẩm</h4>
                        <c:forEach items="${ldms}" var="dm">
                            <a href="#" class="sidebar-item">${dm.mo_ta}</a>
                        </c:forEach>
                    </div>
                </div>



                <!-- Main Content -->
                <div class="col-md-9">
                    <!-- Banner Carousel -->
                    <div id="bannerCarousel" class="carousel slide banner" data-bs-ride="carousel">
                        <!-- Carousel items -->
                        <div class="carousel-inner">
                            <!-- Slide 1 -->
                            <div class="carousel-item active">
                                <img src="./assets/img/banner.png"
                                     alt="Chương trình khuyến mãi" class="d-block w-100">
                                <div class="carousel-caption d-none d-md-block">
                                    <h3>Tặng màn hình Smart monitor khi mua Laptop LG gram 2024</h3>
                                    <p>Tặng ngay màn hình thông minh LG IPS 25'' Full HD trị giá 5.190.000 VNĐ</p>
                                    <button class="btn btn-danger">Chớp ngay deal khủng</button>
                                </div>
                            </div>

                            <!-- Slide 4 -->
                            <div class="carousel-item">
                                <img src="./assets/img/banner4.png"
                                     alt="Khuyến mãi TV LG" class="d-block w-100">
                                <div class="carousel-caption d-none d-md-block">
                                    <h3>Giảm giá khủng cho TV LG</h3>
                                    <p>TV thông minh LG giảm đến 25% cho mùa lễ hội!</p>
                                    <button class="btn btn-danger">Khám phá ngay</button>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img src="./assets/img/Banner5.jpg"
                                     alt="Khuyến mãi TV LG" class="d-block w-100">
                                <div class="carousel-caption d-none d-md-block">
                                    <h3>Giảm giá khủng cho TV LG</h3>
                                    <p>TV thông minh LG giảm đến 25% cho mùa lễ hội!</p>
                                    <button class="btn btn-danger">Khám phá ngay</button>
                                </div>
                            </div>
                            <!-- Add more slides as needed -->
                        </div>

                        <!-- Carousel controls -->
                        <button class="carousel-control-prev" type="button" data-bs-target="#bannerCarousel" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon rounded-circle bg-dark p-2" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#bannerCarousel" data-bs-slide="next">
                            <span class="carousel-control-next-icon rounded-circle bg-dark p-2" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>

            </div>
        

            <div class="sale-section mt-3">
                <h4>SẢN PHẨM KHUYẾN MÃI</h4>
            </div>
            <table class="table text-center mt-3">
                <tbody>
                    <!-- Dòng sản phẩm đầu tiên -->
                    <tr>
                        <c:forEach items="${spss}" var="x" varStatus="status">
                            <td class="p-3">
                                <div class="product-item border rounded p-2">
                                    <a href="productDetailServlet?id=${x.id_sanpham}">
                                        <img src="./assets/image_product/${x.link_anh}" 
                                             alt="${x.ten_sanpham}" class="img-fluid mb-2" style="max-width: 150px; height: auto;">
                                    </a>
                                    <h5 class="product-name">${x.ten_sanpham}</h5>
                                    <p class="sale-price text-danger fw-bold">${x.gia_ban} VND</p>
                                    <p class="sale-old-price text-muted text-decoration-line-through">${x.gia_cu} VND</p>
                                    <span class="sale-discount badge bg-danger text-white">-30%</span>

                                    <!-- Nút Thêm vào giỏ hàng -->
                                    <form action="AddToCartServlet" method="POST" class="mt-2" onsubmit="showCartNotification(event)">
                                        <input type="hidden" name="id_sanpham" value="${x.id_sanpham}">
                                        <input type="hidden" name="gia_ban" value="${x.gia_ban}">
                                        <input type="hidden" name="soLuong" value="1">
                                        <input type="hidden" name="idNguoiDung" value="${sessionScope.user.id_nguoidung}">
                                        <input type="hidden" name="linkAnh" value="${x.link_anh}">
                                        <button type="submit" class="btn btn-outline-danger">Thêm Vào Giỏ Hàng</button>
                                    </form>
                                </div>
                            </td>

                            <!-- Tạo hàng mới sau mỗi 4 sản phẩm -->
                            <c:if test="${status.count % 6 == 0}">
                            </tr><tr>
                            </c:if>
                        </c:forEach>
                    </tr>
                </tbody>
            </table>
            
            <!-- Sale Section (Giờ vàng giá sốc) -->
            <div class="product-section mt-3">
                <!-- Menu loại sản phẩm -->
                <div class="product-nav">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link active" href="#flash-sale" data-bs-toggle="tab">Giờ vàng giá sốc</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#new-products" data-bs-toggle="tab">Sản phẩm mới</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#hot-products" data-bs-toggle="tab">Sản phẩm hot</a>
                        </li>
                    </ul>
                </div>

                <!-- Nội dung tab sản phẩm -->
                <div class="tab-content mt-3">
                    <!-- Tab "Giờ vàng giá sốc" -->
                    <div class="tab-pane fade show active" id="flash-sale">
                        <div class="row mt-3 g-2">
                            <c:forEach items="${spss}" var="x">
                                <div class="col-md-2">
                                    <div class="sale-item product-item text-center p-2 border rounded">
                                        <a href="productDetailServlet?id=${x.id_sanpham}">
                                            <img src="./assets/image_product/${x.link_anh}" alt="${x.ten_sanpham}" class="img-fluid mb-2">
                                        </a>
                                        <h6>${x.ten_sanpham}</h6>
                                        <p class="sale-price text-danger fw-bold">${x.gia_ban} VND</p>
                                        <p class="sale-old-price text-muted text-decoration-line-through">${x.gia_cu} VND</p>
                                        <span class="sale-discount badge bg-danger text-white">-30%</span>
                                        <form action="AddToCartServlet" method="POST" onsubmit="showCartNotification(event)">
                                            <input type="hidden" name="id_sanpham" value="${x.id_sanpham}">
                                            <input type="hidden" name="id_sanpham" value="${x.id_sanpham}">
                                            <input type="hidden" name="gia_ban" value="${x.gia_ban}">
                                            <input type="hidden" name="soLuong" value="1">
                                            <input type="hidden" name="idNguoiDung" value="${sessionScope.user.id_nguoidung}">
                                            <input type="hidden" name="linkAnh" value="${x.link_anh}">
                                            <button type="submit" class="btn btn-outline-danger mt-2">Thêm Vào Giỏ Hàng</button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Tab "Sản phẩm mới" với bố cục khác -->
                    <div class="tab-pane fade" id="new-products">
                        <div class="row mt-3 g-2">
                            <c:forEach items="${spss}" var="np">
                                <div class="col-md-2">
                                    <div class="new-product-item product-item p-3 border rounded d-flex flex-column align-items-center">
                                        <a href="productDetailServlet?id=${np.id_sanpham}">
                                            <img src="./assets/image_product/${np.link_anh}" alt="${np.ten_sanpham}" class="img-fluid mb-2">
                                        </a>
                                        <h5 class="text-center">${np.ten_sanpham}</h5>
                                        <p class="new-price text-primary fw-bold">${np.gia_ban} VND</p>
                                        <form action="AddToCartServlet" method="POST" onsubmit="showCartNotification(event)">
                                            <input type="hidden" name="id_sanpham" value="${np.id_sanpham}">

                                            <input type="hidden" name="id_sanpham" value="${np.id_sanpham}">
                                            <input type="hidden" name="gia_ban" value="${np.gia_ban}">
                                            <input type="hidden" name="soLuong" value="1">
                                            <input type="hidden" name="idNguoiDung" value="${sessionScope.user.id_nguoidung}">
                                            <input type="hidden" name="linkAnh" value="${np.link_anh}">
                                            <button type="submit" class="btn btn-outline-primary mt-2">Thêm Vào Giỏ Hàng</button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Tab "Sản phẩm hot" -->
                    <div class="tab-pane fade" id="hot-products">
                        <div class="row mt-3 g-2">
                            <c:forEach items="${spss}" var="hp">
                                <div class="col-md-2">
                                    <div class="hot-product-item product-item p-3 border rounded d-flex flex-column align-items-center">
                                        <a href="productDetailServlet?id=${hp.id_sanpham}">
                                            <img src="./assets/image_product/${hp.link_anh}" alt="${hp.ten_sanpham}" class="img-fluid mb-2">
                                        </a>
                                        <h5 class="text-center">${hp.ten_sanpham}</h5>
                                        <p class="hot-price text-warning fw-bold">${hp.gia_ban} VND</p>
                                        <form action="AddToCartServlet" method="POST" onsubmit="showCartNotification(event)">
                                            <input type="hidden" name="id_sanpham" value="${hp.id_sanpham}">

                                            <input type="hidden" name="id_sanpham" value="${hp.id_sanpham}">
                                            <input type="hidden" name="gia_ban" value="${hp.gia_ban}">
                                            <input type="hidden" name="soLuong" value="1">
                                            <input type="hidden" name="idNguoiDung" value="${sessionScope.user.id_nguoidung}">
                                            <input type="hidden" name="linkAnh" value="${hp.link_anh}">
                                            <button type="submit" class="btn btn-outline-warning mt-2">Thêm Vào Giỏ Hàng</button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
   
        </div>


   
    <!-- Footer -->
    <%@ include file="/views/client/home/footer.jsp" %>
    <!-- Footer -->

    <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
    <script src="./assets/js/popper.min.js"></script>
    <!--    <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>-->
    <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
    <script src="./assets/bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script>
    <!-- JavaScript để hiển thị thông báo -->
    <script>
        // JavaScript to get the message from the URL and display it (if any)
        window.onload = function() {
            var urlParams = new URLSearchParams(window.location.search);
            var message = urlParams.get('message');

            if (message) {
                alert(decodeURIComponent(message));
            }
        };
    </script>
</body>


</html>
