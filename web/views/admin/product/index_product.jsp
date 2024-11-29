<%-- 
    Document   : admin_product
    Created on : Jun 4, 2024, 7:11:37 PM
    Author     : hc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm</title>
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
            <h1>Danh Sách Sản Phẩm</h1>
               <div class="d-flex">
               <a href="add_product" class="btn btn-success mr-2">Add</a>
               <a href="#" class="btn btn-primary mr-2" onclick="window.print()">Print</a>
              <form action="search" method="get">
              <input class="form-control mr-2"  placeholder="Search" aria-label="Search" type="text" id="searchName" name="searchName"   >
              </form>
            </div>
            </div>

            
            <div class="table-responsive" style="max-height: 700px; overflow-y: auto; width: 1600px; font-size:14px;">
                <table class="table table-striped table-hover" style="width: 100%;">
                    <thead class="thead-light">
                        <tr>
                            <th>ID</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Thương Hiệu</th>
                            <th>Giá Nhập</th>
                            <th>Giá Bán</th>
                            <th style="width: 500px;" >Mô Tả</th>
                            <th>Số Lượng</th>
                            <th>Image</th>
                            <th>Hành Động</th>
                            
                        </tr>
                    </thead>
                    <tbody id="productTable">
                        <c:forEach items="${spss}" var="product">
                            <tr>
                                <th scope="row">${product.id_sanpham}</th>
                                <td>${product.ten_sanpham}</td>
                                <td>${product.ten_nhacungcap}</td> 
                                <td>${product.gia} VND</td>
                                <td>${product.gia_ban} VND</td>
                                <td>${product.mo_ta}</td>
                                <td>${product.so_luong}</td>
                                <td><img src="./assets/image_product/${product.link_anh}" alt="Product Image" class="product-image"></td>
                                <td>
                                    <a href="#" class="btn btn-danger btn-sm delete" data-id="${product.id_sanpham}">Xóa </a>

                                    <a href="update_product?id=${product.id_sanpham}" class="btn btn-warning btn-sm">Sửa</a>
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
    <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
    <script src="./assets/js/popper.min.js"></script>
    <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
    <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>

    <!--delete--> 
    <script>
    $(document).ready(function() {
        $('.delete').click(function(e) {
            e.preventDefault();
            var id = $(this).data('id');
            if (confirm("Are you sure you want to delete this product?")) {
                // Chuyển hướng đến trang xóa sản phẩm và truyền tham số id
                window.location.href = "delete_product?id=" + id;
            }
        });
    });
</script>

</body>
</html>
