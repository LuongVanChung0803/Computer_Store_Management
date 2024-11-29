<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Authentication Page</title>
    <link rel="stylesheet" href="./assets/css/login.css">
    <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
    
    <style>
        .error-message {
            color: red;
            font-weight: bold;
        }
        body{
           background: url('./assets/img/banner4.png') no-repeat center center fixed;
           background-size: cover;
        }
    </style>
    
</head>
<body>
    <div class="auth-container">
        <form class="auth-form needs-validation" id="login-form" method="post" action="loadlogin"  novalidate>
            <h2>Login</h2>
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
            <div class="form-group">
                <label for="login-username">Username/Email</label>
                <input type="text" id="login-username" name="login-username" placeholder="Enter your username" value="${email}" required>
                <div class="invalid-feedback">Please enter your account</div>
            </div>
            <div class="form-group">
                <label for="login-password">Password</label>
                <input type="password" id="login-password" name="login-password" placeholder="Enter your password" value="${id}" required>
                <div class="invalid-feedback">Please enter your password</div>
            </div>
            <div class="form-group remember-me">
                <input type="checkbox" id="remember-me" name="remember-me">
                <label for="remember-me">Remember Me</label>
            </div>
            <div class="form-group">
                <a href="forgotPassword" class="forgot-password">Forget Password?</a>
            </div>
            <button type="submit" class="auth-button">Log In</button>
            <div class="form-group switch-form">
                <p>Don't have an account? <a href="dangkyServlet">Register</a></p>
            </div>
        
        <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:9999/WebQLBanMayTinh1/login&response_type=code&client_id=790968265421-eagtooe0f64rqkiijlusbg50udkf7ga2.apps.googleusercontent.com&approval_prompt=force" class="btn btn-lg btn-danger">
        <i class="fab fa-google"></i> Sign in with Google
        </a>


    </div>
    <!-- Bootstrap JS and dependencies -->
        <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
        <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
</body>

</html>
