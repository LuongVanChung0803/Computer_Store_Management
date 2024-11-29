<%-- 
    Document   : Print.jsp
    Created on : Jun 21, 2024, 9:07:07 PM
    Author     : hc
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    
<head>
     <link href="./assets/css/print.css" rel="stylesheet">
    <title>Invoice</title>

</head>
<body>
    <a href="#" class="btn btn-primary mr-2" onclick="window.print()">Print</a>
    <div class="invoice-container">
        <div class="invoice-header">
            <h1>Hóa Đơn</h1>
        </div>
        <table class="invoice-details">
            <tr>
                <th>Order ID</th>
                <td>${invoice.id_donhang}</td>
            </tr>
            <tr>
                <th>Customer ID</th>
                <td>${invoice.id_khachhang}</td>
            </tr>
            <tr>
                <th>Product ID</th>
                <td>${invoice.id_sanpham}</td>
            </tr>
            <tr>
                <th>Quantity</th>
                <td>${invoice.so_luong}</td>
            </tr>
            <tr>
                <th>Order Date</th>
                <td>${invoice.ngay_dat}</td>
            </tr>
            <tr hidden>
                <th>Status</th>
                <td>${invoice.trang_thai}</td>
            </tr>
            <tr>
                <th>Payment Method</th>
                <td>${invoice.hinh_thuc_thanh_toan}</td>
            </tr>
            <tr>
                <th>Total Amount</th>
                <td>${invoice.tong_tien}</td>
            </tr>
        </table>
        <div class="total-amount">
            Total: $${invoice.tong_tien}
        </div>
        <div class="footer">
            Thank you for your business!
        </div>
    </div>
</body>
</html>
