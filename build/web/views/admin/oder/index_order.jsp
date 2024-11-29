<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Đơn Hàng</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link href="./assets/css/admin.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/views/admin/navbar.jsp" %>
    <div class="d-flex">
        <%@ include file="/views/admin/menu.jsp" %>
            <div class="content">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h1>Danh Sách Đơn Hàng</h1>
                    <div class="d-flex">
                         <form action="search_trangthai" method="get">
              <input class="form-control mr-2"  aria-label="search" type="text" id="search" name="search"   >
              </form>
                    </div>
                </div>
                <div class="table-responsive" style="max-height: 500px; overflow-y: auto; width: 1400px;">
                    <table class="table table-striped table-hover" style="width: 100%;">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">STT</th>
                                <th scope="col">Mã Đơn Hàng</th>
                                <th scope="col">Khách Hàng</th>
                                <th scope="col">Sản Phẩm</th>
                                <th scope="col">Số Lượng</th>
                                <th scope="col">Ngày Đặt</th>

                                <th scope="col">Trạng Thái</th>
                                <th scope="col">Hình Thức Thanh Toán</th>
                                <th scope="col">Tổng Tiền</th>
                                <th scope="col">Hành Động</th>

                            </tr>
                        </thead>
                        <tbody id="orderTable">
                            <c:forEach items="${listDonHangs}" var="order" varStatus="loop">
                                <tr>
                                    <td><strong>${loop.index + 1}</strong></td>
                                    <td scope="row">${order.id_donhang}</td>
                                    <td hidden>${order.id_khachhang}</td>
                                    <td>${order.ho_ten}</td>
                                    <td hidden>${order.id_sanpham}</td>
                                    <td ><img src="./assets/image_product/${order.link_anh}" alt="Product Image" class="product-image" style="width: 80px;height: 60px"></td>
                                    <td>${order.so_luong}</td>
                                    <td>${order.ngay_dat}</td>
                                    <td>
                                    ${order.trang_thai == 'dang_xu_ly' ? 'Đang xử lý' :
                                    order.trang_thai == 'da_giao' ? 'Đã giao bên vận chuyển' :
                                    order.trang_thai == 'da_nhan' ? 'Khách Hàng Đã nhận' : 
                                    'Hủy'}</td>
                                    <td>${order.hinh_thuc_thanh_toan}</td>

                                    <td> <fmt:formatNumber value="${order.tong_tien}" type="currency" currencySymbol="VND" pattern="#,##0" /> VND</td>

                                    <td>
                                        <button hidden class="btn btn-danger btn-sm delete">Delete</button>
                                        <button class="btn btn-warning btn-sm edit"><a href="update_oder?id=${order.id_donhang}">Xử Lý</button>
                                        <button class="btn btn-warning btn-sm "><a href="InvoiceServlet?id=${order.id_donhang}">In Hóa Đơn</button>
                                        <a href="#" class="btn btn-danger btn-sm delete" data-id="${order.id_donhang}">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <p class="text-danger">Lưu ý (*): Vui lòng thao tác cẩn thận</p>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
        <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>

    <!--delete--> 
    <script>
    $(document).ready(function() {
        $('.delete').click(function(e) {
            e.preventDefault();
            var id = $(this).data('id');
            if (confirm("Are you sure you want to delete this oder?")) {
                // Chuyển hướng đến trang xóa sản phẩm và truyền tham số id
                window.location.href = "delete_oder_ad?id=" + id;
            }
        });
    });
</script>

    </body>
</html>
