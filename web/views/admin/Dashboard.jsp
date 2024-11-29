<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
    <!-- Chart.js CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.css" rel="stylesheet">
    <link href="./assets/css/admin.css" rel="stylesheet">
</head>
<body>
    <%@ include file="/views/admin/navbar.jsp" %>
    <div class="d-flex">
        <%@ include file="/views/admin/menu.jsp" %>
        <div class="content p-4" >
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1>Dashboard</h1>
            </div>
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Khách Hàng Tiềm Năng</h5>
                            <p class="card-text">Mã khách hàng: ${customerWithMostOrders.id_khachhang}</p>
                            <p class="card-text">Số lượng đơn hàng: ${customerWithMostOrders.so_don_hang}</p>
                            <p class="card-text">Tổng số tiền :<fmt:formatNumber value="${customerWithMostOrders.tong_tien}" type="currency"  pattern="#,##0" /> VND </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Sản Phẩm Bán Chạy Nhất</h5>
                            <p class="card-text">Mã sản phẩm:${bestSellingProduct.id_sanpham}</p>
                            <p class="card-text">Tổng số lượng đã bán: ${bestSellingProduct.total_quantity}</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card mb-4">
                <div class="card-header">
                    Đơn hàng gần đây
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Khách Hàng</th>
                                    <th>Ngày</th>
                                    <th>Trạng Thái</th>
                                    <th>Tổng Tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${recentOrders}">
                                    <tr>
                                        <td>${order.id_donhang}</td>
                                        <td>${order.id_khachhang}</td>
                                        <td>${order.ngay_dat}</td>
                                        <td>${order.trang_thai}</td>
                                        <td><fmt:formatNumber value="${order.tong_tien}" type="currency"  pattern="#,##0" /> VND</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
                        
                        
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
    <script src="./assets/js/popper.min.js"></script>
    
    <script src="./assets/js/chart.min.js"></script>
    <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
    <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>

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
