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
        <link href="./assets/css/index_oder.css" rel="stylesheet">

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
        <!-- Display success or error messages -->
<!--        <div class="container mt-4">-->
            <!--contact_and_cart-->
            <%@ include file="/views/client/home/contact_and_cart.jsp" %>
            <!-- navbar -->
            <div class="container mt-4">
                <h2 class="my-4">Tất cả đơn hàng của bạn</h2>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">STT</th>
                                <th scope="col">Image</th>
                                <th scope="col">Số Lượng</th>
                                <th scope="col">Ngày Đặt</th>
                                <th scope="col">Trạng Thái</th>
                                <th scope="col">Hình Thức Thanh Toán</th>
                                <th scope="col">Tổng Tiền</th>
                                <th scope="col">Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach items="${orders}" var="order" varStatus="loop">
                                <tr>
                                    <td><strong>${loop.index + 1}</strong></td>
                                    <td hidden>${order.id_donhang}</td>
                                    <td><img src="./assets/image_product/${order.link_anh}" alt="Product Image" class="product-image"></td>
                                    <td>${order.so_luong}</td>
                                    <td>${order.ngay_dat}</td>
                                    <td><c:if test="${order.trang_thai == 'dang_xu_ly'}">
                                            Đang xử lý
                                        </c:if>

                                        <!--                                                trang_thai ENUM('dang_xu_ly', 'da_giao', 'da_nhan', 'huy')-->
                                        <c:if test="${order.trang_thai == 'da_giao'}">
                                            Đang giao hàng
                                        </c:if>
                                        <c:if test="${order.trang_thai == 'huy'}">
                                            Đơn bị hủy
                                        </c:if>
                                        <c:if test="${order.trang_thai == 'da_nhan'}">
                                            Đã nhận hàng
                                        </c:if>
                                    </td>
                                    <td>${order.hinh_thuc_thanh_toan}</td>
                                    <td><fmt:formatNumber value="${order.tong_tien}" type="currency" currencySymbol="VND" pattern="#,##0" /> VND</td>
                                    <td>
                                        <div class="text-end">
                                            <!-- Chỉ cho phép hủy đơn hàng khi đơn hàng có trạng thái "dang_xu_ly" -->
                                            <c:if test="${order.trang_thai == 'dang_xu_ly'}">
                                                <a href="delete_oders1?id_donhang=${order.id_donhang}" class="btn btn-outline-secondary btn-sm" onclick="return confirmDelete()">Hủy Đơn Hàng</a>
                                            </c:if>

                                            <!--                                                trang_thai ENUM('dang_xu_ly', 'da_giao', 'da_nhan', 'huy')-->
                                            <c:if test="${order.trang_thai != 'dang_xu_ly'}">
                                              
                                            </c:if>
                                        </div>

                                    </td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                    
                    <c:if test="${empty orders}">
                        <p> Bạn chưa có đơn hàng nào !.</p>
                    </c:if>
                    <p>*Lưu ý : Nếu bạn không thể hủy đơn trên hệ thống , hãy liên hệ với nhân viên tư vấn để được hỗ trợ !</p>
                </div>
                <div class="text-end btn-back" style="margin-bottom: 10px ">
                    <a href="loadhome" class="btn btn-primary">Quay Lại Trang Chủ</a>
                </div>
            </div>
            <%@ include file="/views/client/home/footer.jsp" %>
            <!-- Footer -->
            <script>
                function confirmDelete() {
                    return confirm("Bạn có chắc chắn muốn hủy đơn hàng này ?");

                }
            </script>

            <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
            <script src="./assets/js/popper.min.js"></script>
            <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
            <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
            <script src="./assets/bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
