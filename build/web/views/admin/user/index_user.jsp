<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="controller.login.PasswordEncryption" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Tài Khoản</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link href="./assets/css/admin.css" rel="stylesheet">
        <link href="./assets/css/index_user.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/views/admin/navbar.jsp" %>
    <div class="d-flex">
        <%@ include file="/views/admin/menu.jsp" %>

            <div class="content">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h1>Danh Sách Người Dùng</h1>
                    <div class="d-flex">
                        <a href="add_user" class="btn btn-primary mr-2">Add</a>
                        <form action="search_user" method="get">
                            <input type="text" id="searchName" class="form-control mr-2"  name="searchName"  placeholder="Tìm kiếm ..."  required>
                            <input hidden type="submit" value="Tìm kiếm">
                        </form>
                    </div>
                </div>
                <div class="table-responsive" style="max-height: 500px; overflow-y: auto; width: 1400px;">
                    <table class="table table-striped table-hover" style="width: 100%;">
                        <thead class="thead-light">
                            <tr> 
                                <th>STT</th>
                                <th hidden>ID</th>
                                <th>UserName</th>
                                <th>Password</th>
                                <th>Email</th>
                                <th>Vai Trò</th>
                                <th>Trạng Thái</th>
                                <th>Hành Động</th>
                            </tr>
                        </thead>
                        <tbody id="userTable">
                            <c:forEach items="${tkss}" var="x" varStatus="loop"> 
                                <tr>
                                    <td><strong>${loop.index + 1}</strong></td> <!-- Số thứ tự in đậm -->
                                    <th hidden scope="row">${x.id_nguoidung}</th>
                                    <td>${x.ten_dangnhap}</td>
                                    <td>${PasswordEncryption.encryptPassword(x.matkhau)}</td><!-- Mã hóa mật khẩu khi hiển thị -->

                                    <td>${x.email}</td>
                                    <td>${x.vai_tro}</td>
                                    <td>
                                        <label class="switch">
                                            <input readonly type="checkbox"  class="status-toggle" data-id="${x.id_nguoidung}" <c:if test="${x.trang_thai == 'ON'}" >checked</c:if>>
                                                <span class="slider round" ></span>
                                            </label>
                                        </td>
                                        <td>
                                        <button class="btn btn-danger btn-sm delete" onclick="confirmDelete(${x.id_nguoidung})">Xóa</button>
                                        <button class="btn btn-warning btn-sm edit" ><a href="update_user?id=${x.id_nguoidung}">Sửa</a></button>

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
            $(document).ready(function () {
            $('.status-toggle').change(function () {
            var userId = $(this).data('id');
                    var status = $(this).is(':checked') ? 'ON' : 'OFF';
                    $.ajax({
                    url: 'updateStatus',
                            method: 'POST',
                            data: {
                            id: userId,
                                    status: status
                            },
                            success: function (response) {
                            alert('Status updated successfully!');
                            },
                            error: function (xhr, status, error) {
                            alert('Error updating status!');
                            }
                    });
            });
        </script>
        <script>
                    function confirmDelete(id) {
                    if (confirm('Are you sure you want to delete this user?')) {
                    window.location.href = 'delete_user?id=' + id;
                    }
                    }
        </script>
    </body>
</html>
