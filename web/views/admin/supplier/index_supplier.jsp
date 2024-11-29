
<%-- 
    Document   : index_custommer
    Created on : Jun 12, 2024, 1:14:03 AM
    Author     : hc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Nhà Cung Cấp</title>
    <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        
        <link href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap" rel="stylesheet">
    <link href="./assets/css/admin.css" rel="stylesheet">
</head>
<body>
    <%@ include file="/views/admin/navbar.jsp" %>
    <div class="d-flex">
        <%@ include file="/views/admin/menu.jsp" %>
        <div class="content">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h1>Danh Sách Nhà Cung Cấp</h1>
                <div class="d-flex" style="margin-left: 500px" >
                <a href="add_supplier" class="btn btn-success mr-2">Add</a>
                </div>
                <form action="searchsupplier" method="get">
                <div class="d-flex">
                    <input class="form-control mr-2" id ="searchName" name="searchName"  placeholder="Tìm kiếm ..."  aria-label="Search">
                </div>
                </form>
            </div>
            <div class="table-responsive" style="max-height: 500px; overflow-y: auto; width: 1400px;">
                <table class="table table-striped table-hover" style="width: 100%;">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">STT</th>
                            <th scope="col">ID_Nhà Cung Cấp</th>
                            <th scope="col">Tên Nhà Cung Cấp</th>
                            <th scope="col">Địa Chỉ</th>
                            <th scope="col">Số Điện Thoại</th>
                            <th scope="col">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody id="customerTable">
                         
                        <c:forEach items="${ncc}" var="supplier"  varStatus="loop">
                        <tr>
                            <td><strong>${loop.index + 1}</strong></td>
                            <th  scope="row">${supplier.id_nhacungcap}</th>
                            <td>${supplier.ten_nhacungcap}</td>
                            <td>${supplier.dia_chi}</td>
                            <td>${supplier.so_dien_thoai}</td>
                            <td>
                                <button class="btn btn-danger btn-sm delete" onclick="confirmDelete(${supplier.id_nhacungcap})">Xóa</button>
                                <button class="btn btn-warning btn-sm edit" ><a href="update_supplier?sid=${supplier.id_nhacungcap}">Sửa</a></button>
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

    <script>
    function confirmDelete(id) {
        if (confirm('Are you sure you want to delete this supplier?')) {
            window.location.href = 'delete_supplier?sid=' + id;
        }
    }
    </script>
</body>
</html>
