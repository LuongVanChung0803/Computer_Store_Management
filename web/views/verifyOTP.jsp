<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực OTP</title>
    <!-- Liên kết đến Bootstrap CSS và FontAwesome -->
   
    <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
    

    <style>
        body {
            background: url('./assets/img/banner4.png') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Arial', sans-serif;
        }

        .auth-container {
            width: 100%;
            max-width: 500px;
            margin: 80px auto;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
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

        .password-strength {
            font-size: 12px;
            margin-top: 5px;
            color: #666;
        }

        .strength-weak {
            color: #e74c3c;
        }

        .strength-medium {
            color: #f39c12;
        }

        .strength-strong {
            color: #2ecc71;
        }
    </style>

    <script>
        function checkPasswordStrength(password) {
            var strength = "Weak";
            var regexLowercase = /[a-z]/;
            var regexUppercase = /[A-Z]/;
            var regexNumber = /\d/;
            var regexSpecialChar = /[!@#$%^&*(),.?":{}|<>]/;
            var passwordStrength = document.getElementById("password-strength");

            if (password.length >= 8 && regexLowercase.test(password) && regexUppercase.test(password) && regexNumber.test(password) && regexSpecialChar.test(password)) {
                strength = "Strong";
                passwordStrength.className = "password-strength strength-strong";
            } else if (password.length >= 6 && regexLowercase.test(password) && regexUppercase.test(password) && regexNumber.test(password)) {
                strength = "Medium";
                passwordStrength.className = "password-strength strength-medium";
            } else {
                strength = "Weak";
                passwordStrength.className = "password-strength strength-weak";
            }
            passwordStrength.innerHTML = "Mật khẩu: " + strength;
        }

        function validatePasswords() {
            var password = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            if (password !== confirmPassword) {
                alert("Mật khẩu không khớp.");
                return false;
            }
            return true;
        }
    </script>

</head>

<body>

    <div class="auth-container">
        <h2>Xác thực OTP</h2>
        <form action="VerifyOTPServlet2" method="post" onsubmit="return validatePasswords()">
            <div class="form-group">
                <label for="otp">Mã OTP:</label>
                <input type="text" name="otp" required class="form-control" placeholder="Nhập mã OTP" />
            </div>

            <div class="form-group">
                <label for="newPassword">Mật khẩu mới:</label>
                <input type="password" name="newPassword" id="newPassword" required class="form-control" placeholder="Nhập mật khẩu mới" onkeyup="checkPasswordStrength(this.value)" />
                <div id="password-strength" class="password-strength strength-weak">Mật khẩu: Weak</div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Nhập lại mật khẩu mới:</label>
                <input type="password" name="confirmPassword" id="confirmPassword" required class="form-control" placeholder="Nhập lại mật khẩu mới" />
            </div>

            <button type="submit" class="btn btn-primary">Thay đổi mật khẩu</button>
        </form>
        <div class="form-group switch-form">
                <p>Already have an account? <a href="loadlogin">Login</a></p>
            </div>

        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>

        <c:if test="${not empty successMessage}">
    <div class="alert alert-success" role="alert">
        <i class="fas fa-check-circle"></i> ${successMessage}
    </div>
</c:if>

    </div>

    <!-- Liên kết đến các thư viện JS của Bootstrap và FontAwesome -->
        <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
        <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>

</body>

</html>
