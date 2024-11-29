<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authentication Page</title>
    <link rel="stylesheet" href="./assets/css/login.css">
    <style>
        .error-message {
            color: red;
            font-weight: bold;
        }
        body {
            background: url('./assets/img/banner4.png') no-repeat center center fixed;
            background-size: cover;
        }
    </style>
    <script>
        // Kiểm tra thông báo thành công
        window.onload = function () {
            const successMessage = '<c:out value="${successMessage}"/>';
            if (successMessage) {
                alert(successMessage);
                window.location.href = "loadlogin"; // Chuyển hướng về trang đăng nhập
            }
        };
    </script>
</head>
<body>
    <div class="auth-container">
        <form method="post" action="dangkyServlet" class="auth-form" id="register-form">
            <h2>Register</h2>
            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty errorMessages}">
                <div class="error-message">${errorMessages}</div>
            </c:if>
            <br>
            <div class="form-group">
                <label for="register-username">Username</label>
                <input type="text" id="register-username" name="register-username" placeholder="username" required>
            </div>
            <div class="form-group">
                <label for="register-email">Email</label>
                <input type="email" id="register-email" name="register-email" placeholder="email" required>
            </div>
            <div class="form-group">
                <label for="register-password">Password</label>
                <input type="password" id="register-password" name="register-password" placeholder="password" required>
            </div>
            <div class="form-group">
                <label for="confirm-password">Confirm Password</label>
                <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm password" required>
            </div>
            <button type="submit" class="auth-button">Register</button>
            <div class="form-group switch-form">
                <p>Already have an account? <a href="loadlogin">Login</a></p>
            </div>
        </form>
    </div>
</body>
</html>
