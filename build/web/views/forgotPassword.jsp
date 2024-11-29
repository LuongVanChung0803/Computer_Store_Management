<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu</title>
    <!-- Liên kết đến Bootstrap CSS và FontAwesome -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: url('./assets/img/banner4.png') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Arial', sans-serif;
        }

        .auth-container {
            width: 100%;
            max-width: 450px;
            margin: 80px auto;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .auth-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #007bff;
            font-weight: 600;
        }

        .auth-container label {
            font-weight: bold;
            color: #333;
        }

        .auth-container input {
            border-radius: 25px;
            border: 1px solid #ddd;
            padding: 15px;
            font-size: 16px;
            width: 100%;
            margin-bottom: 20px;
        }

        .auth-container button {
            width: 100%;
            padding: 15px;
            font-size: 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .auth-container button:hover {
            background-color: #0056b3;
        }

        .back-login {
            text-align: center;
            margin-top: 20px;
        }

        .back-login a {
            font-size: 16px;
            color: #007bff;
            text-decoration: none;
        }

        .back-login a:hover {
            text-decoration: underline;
            color: #0056b3;
        }

        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-top: 15px;
        }

        .success-message {
            color: #2ecc71;
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>

<body>

    <div class="auth-container">
        <h2>Quên mật khẩu</h2>
        <form action="forgotPassword" method="post">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" required class="form-control" placeholder="Nhập email của bạn" />
            </div>
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
            <button type="submit" class="btn btn-primary">Gửi OTP</button>
        </form>

        <c:if test="${not empty successMessage}">
            <div class="success-message">${successMessage}</div>
        </c:if>

        <div class="back-login">
            <a href="loadlogin"><i class="fas fa-arrow-left"></i> Quay về trang đăng nhập</a>
        </div>
    </div>

    <!-- Liên kết đến các thư viện JS của Bootstrap và FontAwesome -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>

</html>
