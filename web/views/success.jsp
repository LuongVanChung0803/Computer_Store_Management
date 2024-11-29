<%-- 
    Document   : success
    Created on : Nov 18, 2024, 6:04:00 PM
    Author     : hc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả đăng nhập Google</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
        }
        .message {
            font-size: 18px;
            margin: 20px 0;
        }
        .success {
            color: green;
        }
        .error {
            color: red;
        }
        .token {
            background: #f4f4f4;
            padding: 10px;
            border-radius: 5px;
            font-family: monospace;
            word-break: break-word;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Kết quả Đăng Nhập</h1>
        
        <!-- Hiển thị thông báo từ session -->
        <c:choose>
            <c:when test="${not empty sessionScope.message}">
                <p class="message ${sessionScope.accToken != null ? 'success' : 'error'}">
                    ${sessionScope.message}
                </p>
            </c:when>
            <c:otherwise>
                <p class="error">Không có thông báo đăng nhập.</p>
            </c:otherwise>
        </c:choose>

        <!-- Hiển thị Access Token nếu có -->
        <c:if test="${not empty sessionScope.accToken}">
            <h2>Access Token:</h2>
            <div class="token">${sessionScope.accToken}</div>
        </c:if>

        <!-- Nút quay lại -->
        <div style="text-align: center; margin-top: 20px;">
            <a href="login" style="text-decoration: none; background-color: #007bff; color: white; padding: 10px 20px; border-radius: 5px;">Quay lại</a>
        </div>
    </div>
</body>
</html>
