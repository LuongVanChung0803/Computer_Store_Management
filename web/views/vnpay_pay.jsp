<%-- 
    Document   : vnpay_pay
    Created on : Nov 20, 2024, 1:31:26 AM
    Author     : hc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh Toán VNPAY</title>
        <link rel="stylesheet" href="./assets/bootstrap-5.0.2-dist/css/bootstrap.min.css">
<!--        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">-->
        <link rel="stylesheet" href="./assets/css/index2.css">
        <link href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap" rel="stylesheet">
        <!-- Bootstrap core CSS -->
        <link href="./assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="./assets/jumbotron-narrow.css" rel="stylesheet">      
        <script src="./assets/jquery-1.11.3.min.js"></script>
    </head>

    <body>
        <!-- Main Header -->
        <div class="container my-4">
            <%@ include file="/views/client/home/header.jsp" %>
        </div>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-navbar">
            <%@ include file="/views/client/home/navigation_bar.jsp" %>

        </nav>
       

         <div class="container">
         
           <div class="header clearfix" style="color: white;" >

               <h3>THANH TOÁN CÙNG VNPAY</h3>
            </div>
              <%
        // Lấy tổng tiền từ session và chuyển thành số nguyên
        Double totalAmount = (Double) session.getAttribute("totalAmount");
        if (totalAmount == null) {
            totalAmount = 0.0; // Nếu không có giá trị, đặt mặc định là 0
        }
        
        // Chuyển đổi từ Double sang Long để loại bỏ phần thập phân và không bị dạng khoa học
        long amountInLong = totalAmount.longValue();
        %>
            <h3>Tạo mới đơn hàng</h3>
            <div class="table-responsive">
                <form action="ajaxServlet" id="frmCreateOrder" method="post">        
                    <div class="form-group">
                        <label for="amount">Số tiền</label>
                        <input class="form-control" data-val="true" data-val-number="The field Amount must be a number." data-val-required="The Amount field is required." id="amount" max="1000000000" min="1" name="amount" type="number" value="<%= amountInLong %>" />
                    </div>
                     <h4>Chọn phương thức thanh toán của VNPAY</h4>
                    <div class="form-group">
                        <h5>Cách 1: Chuyển hướng sang Cổng VNPAY chọn phương thức thanh toán</h5>
                       <input type="radio" Checked="True" id="bankCode" name="bankCode" value="">
                       <label for="bankCode">Cổng thanh toán VNPAYQR</label><br>
                       
                       <h5>Cách 2: Tách phương thức tại site của đơn vị kết nối</h5>
                       <input type="radio" id="bankCode" name="bankCode" value="Thanh toán bằng vnpay">
                       <label for="bankCode">Thanh toán bằng ứng dụng hỗ trợ VNPAYQR</label><br>
                       
                       <input type="radio" id="bankCode" name="bankCode" value="VNBANK">
                       <label for="bankCode">Thanh toán qua thẻ ATM/Tài khoản nội địa</label><br>
                       
                       <input type="radio" id="bankCode" name="bankCode" value="INTCARD">
                       <label for="bankCode">Thanh toán qua thẻ quốc tế</label><br>
                       
                    </div>
                    <div class="form-group">
                        <h5>Chọn ngôn ngữ giao diện thanh toán:</h5>
                         <input type="radio" id="language" Checked="True" name="language" value="vn">
                         <label for="language">Tiếng việt</label><br>
                         <input type="radio" id="language" name="language" value="en">
                         <label for="language">Tiếng anh</label><br>
                    </div>
                    <button type="submit" class="btn btn-default" href>Thanh toán</button>
                </form>
            </div>
            <p>
                &nbsp;
            </p>
            <footer class="footer">
                <p>&copy; VNPAY 2025</p>
            </footer>
        </div>
          
        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script type="text/javascript">
            $("#frmCreateOrder").submit(function () {
                var postData = $("#frmCreateOrder").serialize();
                var submitUrl = $("#frmCreateOrder").attr("action");
                $.ajax({
                    type: "POST",
                    url: submitUrl,
                    data: postData,
                    dataType: 'JSON',
                    success: function (x) {
                        if (x.code === '00') {
                            if (window.vnpay) {
                                vnpay.open({width: 768, height: 600, url: x.data});
                            } else {
                                location.href = x.data;
                            }
                            return false;
                        } else {
                            alert(x.Message);
                        }
                    }
                });
                return false;
            });
        </script>       
    </body>
</html>
