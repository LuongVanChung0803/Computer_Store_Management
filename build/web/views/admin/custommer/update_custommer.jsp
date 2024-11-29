<%-- 
    Document   : update_custommer
    Created on : Jun 12, 2024, 3:42:08 AM
    Author     : hc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập Nhật Khách Hàng</title>
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
                <div class="container mt-5">
                    <h2 class="mb-4">Cập Nhật Thông Tin Khách Hàng</h2>
                    <form id="updateForm"  action="update_custommer" method="post">
                        <input hidden type="hidden" name="id_khachhang" value="${customer.id_khachhang}" />
                        <div  class="form-group">
                            <label for="ho_ten">Họ Tên:</label>
                            <input type="text" class="form-control" id="ho_ten" name="ho_ten" value="${customer.ho_ten}" readonly >
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" class="form-control" id="email" name="email" value="${customer.email}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="dia_chi">Địa Chỉ:</label>
                            <input type="text" class="form-control" id="dia_chi" name="dia_chi" value="${customer.dia_chi}">
                        </div>
                        <div class="form-group">
                            <label for="so_dien_thoai">Số Điện Thoại:</label>
                            <input type="text" class="form-control" id="so_dien_thoai" name="so_dien_thoai" value="${customer.so_dien_thoai}" readonly>
                        </div>
                        <div hidden class="form-group">
                            <label for="id_nguoidung">ID Người Dùng:</label>
                            <input type="text" class="form-control" id="id_nguoidung" name="id_nguoidung" value="${customer.id_nguoidung}">
                        </div>
                        <button type="button" class="btn btn-primary" onclick="confirmUpdate();">Cập Nhật</button>
                        <a href="loadcustommer" class="btn btn-secondary">Hủy</a>
                    </form>
                </div>
            </div>
        </div>
        <script>
            // Hàm xử lý xác nhận cập nhật
            function confirmUpdate() {
                // Hiển thị hộp thoại Yes/No
                let confirmation = confirm("Bạn có chắc chắn muốn cập nhật thông tin khách hàng?");

                // Nếu người dùng chọn Yes
                if (confirmation) {
                    // Gọi lại việc submit form
                    document.getElementById("updateForm").submit();
                } else {
                    // Nếu chọn No, không làm gì cả (giữ nguyên form)
                    return false;
                }
            }
        </script>
        <!-- Bootstrap JS and dependencies -->
        <!-- Bootstrap JS and dependencies -->
    <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
    <script src="./assets/js/popper.min.js"></script>
    <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
    <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
   


    </body>
</html>
