<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
    <link href="./assets/css/update_user.css" rel="stylesheet">
</head>
<body>
    <%@ include file="/views/admin/navbar.jsp" %>
    <div class="container">
        <h2 class="mb-4">Update User</h2>
        <form id="updateForm" action="update_user" method="post">
            <input hidden type="hidden" name="id_nguoidung" id="id_nguoidung" value="${user.id_nguoidung}">
            <div class="form-group">
                <label for="ten_dangnhap">Username</label>
                <input type="text" class="form-control" id="ten_dangnhap" name="ten_dangnhap" value="${user.ten_dangnhap}" required>
            </div>
            <div class="form-group password-toggle">
                <label for="matkhau">Password</label>
                <input type="password" class="form-control" id="matkhau" name="matkhau" value="${user.matkhau}" required>
                <i class="fas fa-eye toggle-password" onclick="togglePasswordVisibility()"></i>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
            </div>
            
            <div class="form-group">
                <label for="vai_tro">Role</label>
                <select class="form-control" id="vai_tro" name="vai_tro" required>
                    <option value="admin" ${user.vai_tro == 'admin' ? 'selected' : ''}>Admin</option>
                    <option value="Nhân Viên" ${user.vai_tro == 'Nhân Viên' ? 'selected' : ''}>Nhân Viên</option>
                    <option value="Khách Hàng" ${user.vai_tro == 'Khách Hàng' ? 'selected' : ''}>Khách Hàng</option>
                    <!-- Add other roles as needed -->
                </select>
            </div>
            <div  class="form-group">
                <label for="trang_thai">Trạng Thái</label>
                <select class="form-control" id="trang_thai" name="trang_thai" required>
                    <option value="ON" ${user.trang_thai == 'ON' ? 'selected' : ''}>ON</option>
                    <option value="OFF" ${user.trang_thai == 'OFF' ? 'selected' : ''}>OFF</option>
                    <!-- Add other roles as needed -->
                </select>
            </div>
            <button type="button" class="btn btn-primary" onclick="confirmUpdate();">Update</button>
            <a href="loaduser" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
    <script src="./assets/js/popper.min.js"></script>
    <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
    <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
    <script>
        function togglePasswordVisibility() {
            var passwordInput = document.getElementById('matkhau');
            var toggleIcon = document.querySelector('.toggle-password');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
    </script>
    <script>
            // Hàm xử lý xác nhận cập nhật
            function confirmUpdate() {
                // Hiển thị hộp thoại Yes/No
                let confirmation = confirm("Bạn có chắc chắn muốn cập nhật thông tin tài khoản?");

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
</body>
</html>
