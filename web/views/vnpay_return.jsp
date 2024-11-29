<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="utils.Config"%>
<%@page import="java.text.DecimalFormat"%>  <!-- Import DecimalFormat -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="utils.Config"%>
<%@page import="dao.CartDao"%>
<%@page import="dao.DonHangDao"%>
<%@page import="model.CartItem"%>
<%@page import="utils.EmailUtil"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>KẾT QUẢ THANH TOÁN</title>
        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="./assets/bootstrap-5.0.2-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link rel="stylesheet" href="./assets/css/index2.css">
        <link href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap" rel="stylesheet">
        <link href="./assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="./assets/jumbotron-narrow.css" rel="stylesheet"> 
        <script src="./assets/jquery-1.11.3.min.js"></script>
    </head>
    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-navbar">
            <%@ include file="/views/client/home/navigation_bar.jsp" %>
        </nav>
        <%
            // Begin process return from VNPAY
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);

            // Get the amount parameter from VNPAY and format it
            String amountStr = request.getParameter("vnp_Amount");
            long amount = Long.parseLong(amountStr);
            DecimalFormat formatter = new DecimalFormat("#,###");  // Format the number with commas
            String formattedAmount = formatter.format(amount/100);
            


            // Lấy giá trị ngày thanh toán từ request
    String payDateStr = request.getParameter("vnp_PayDate");

    String formattedPayDate = ""; // Khai báo biến ngày định dạng
    if (payDateStr != null && !payDateStr.isEmpty()) {
        try {
            // Định dạng ban đầu của thời gian là yyyyMMddHHmmss
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
            Date payDate = dateFormat.parse(payDateStr);

            // Định dạng lại thời gian chỉ lấy ngày (dd/MM/yyyy)
            SimpleDateFormat formattedDate = new SimpleDateFormat("dd/MM/yyyy");
            formattedPayDate = formattedDate.format(payDate); // Gán giá trị cho biến
        } catch (ParseException e) {
            formattedPayDate = "Lỗi định dạng ngày"; // Nếu có lỗi
        }
    } else {
        formattedPayDate = "Không có ngày thanh toán"; // Nếu không có ngày thanh toán
    }
            
            
        %>

        <!--Begin display -->
        <div class="container">
            <div class="header clearfix" style="background: whitesmoke" >
                <h3 class="text-muted" >KẾT QUẢ THANH TOÁN</h3>
            </div> <br> <br>
            <div class="table-responsive">
                <div class="form-group">
                    <label >Mã giao dịch thanh toán:</label>
                    <label><%=request.getParameter("vnp_TxnRef")%></label>
                </div>    
                <div class="form-group">
                    <label >Số tiền:</label>
                    <!-- Display formatted amount -->
                    <label><%= formattedAmount %>   VND</label>
                </div>  
                <div class="form-group">
                    <label >Mô tả giao dịch:</label>
                    <label>${sessionScope.user.id_nguoidung}</label>
<!--                    <label><%=request.getParameter("vnp_OrderInfo")%></label>-->
                </div>
                <div class="form-group">
                    <label >Mã lỗi thanh toán:</label>
                    <label><%=request.getParameter("vnp_ResponseCode")%></label>
                </div> 
                <div class="form-group">
                    <label >Mã giao dịch tại CTT VNPAY-QR:</label>
                    <label><%=request.getParameter("vnp_TransactionNo")%></label>
                </div> 
                <div class="form-group">
                    <label >Mã ngân hàng thanh toán:</label>
                    <label><%=request.getParameter("vnp_BankCode")%></label>
                </div> 
                <!-- Hiển thị ngày đã định dạng -->
                <div class="form-group">
                    <label>Thời gian thanh toán:</label>
                    <label><%= formattedPayDate %></label>
                </div>
            <div class="form-group">
            <label >Tình trạng giao dịch:</label>
            <label>
            <%
                if (signValue.equals(vnp_SecureHash)) {
                    if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                        int idDonHang = Integer.parseInt(request.getParameter("vnp_TxnRef"));
                        int userId = (int) session.getAttribute("id_nguoidung");
                        String email = (String) session.getAttribute("email");
                        String fullName = (String) session.getAttribute("ho_ten");

                        // Lấy thông tin giỏ hàng
                        CartDao cartDao = new CartDao();
                        List<CartItem> cartItems = cartDao.getCartItems(userId);
                        
                        // Tính tổng tiền trong giỏ hàng
                        double totalAmount = 0;
                        for (CartItem item : cartItems) {
                        totalAmount += item.getGia_ban() * item.getSo_luong();
                        }
                    if (totalAmount > 0) {
                        // Thêm đơn hàng vào CSDL
                        DonHangDao donHangDao = new DonHangDao();
                        for (CartItem item : cartItems) {
                            donHangDao.addDonHang_vnpay(idDonHang,userId, item.getId_sanpham(), item.getSo_luong(), new Date(),
                                    "dang_xu_ly", "Thanh toán bằng vnpay", item.getGia_ban() * item.getSo_luong());
                        }
                        EmailUtil.sendOrder_Vnpay_ConfirmationEmail(email, fullName, cartItems);
                        cartDao.clearCart(userId);
                                    out.print("Thành công");
                    } else {out.print("Không thành công");}
                            } else {
                                out.print("invalid signature");
                            }
                }
                        
            %>
            </label>
            </div> 
            </div>
            <p>
                &nbsp;
            </p>
            <footer class="footer">
                <p>&copy; VNPAY 2025</p>
            </footer>
        </div>  
    </body>
</html>
