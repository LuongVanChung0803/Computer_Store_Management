<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="utils.Config"%>
<%@page import="dao.CartDao"%>
<%@page import="dao.DonHangDao"%>
<%@page import="model.CartItem"%>
<%@page import="utils.EmailUtil"%>
<%@page contentType="application/json; charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    
<head>
    <script type="text/javascript">
        // Chuyển hướng ngay lập tức đến vnpay_return.jsp
        window.location.href = './views/vnpay_return.jsp';
    </script>
</head>
<body>
    <!-- Trang vnpay_ipn.jsp có thể hiển thị gì đó, sau đó sẽ tự động chuyển hướng -->
    <h1>Đang xử lý, vui lòng chờ...</h1>
</body>
</html>

<%
    // Lấy các tham số từ request
    Map<String, String> fields = new HashMap<>();
    Enumeration<String> parameterNames = request.getParameterNames();

    while (parameterNames.hasMoreElements()) {
        String fieldName = parameterNames.nextElement();
        String fieldValue = request.getParameter(fieldName);

        if (fieldValue != null && !fieldValue.isEmpty()) {
            fields.put(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()), 
                       URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
        }
    }

    // Xóa các tham số không cần thiết để kiểm tra checksum
    String vnp_SecureHash = request.getParameter("vnp_SecureHash");
    fields.remove("vnp_SecureHashType");
    fields.remove("vnp_SecureHash");

    // Kiểm tra checksum
    String calculatedHash = Config.hashAllFields(fields);
    if (calculatedHash.equals(vnp_SecureHash)) {
        boolean isOrderIdValid = true; // Giả sử mã đơn hàng tồn tại
        boolean isAmountValid = true; // Giả sử số tiền hợp lệ
        boolean isOrderStatusPending = true; // Giả sử trạng thái đơn hàng là "pending"

        if (isOrderIdValid) {
            if (isAmountValid) {
                if (isOrderStatusPending) {
                    String responseCode = request.getParameter("vnp_ResponseCode");

                    if ("00".equals(responseCode)) {
                        // Giao dịch thành công
                        int userId = (int) session.getAttribute("id_nguoidung");
                        String email = (String) session.getAttribute("email");
                        String fullName = (String) session.getAttribute("ho_ten");


                        // Lấy thông tin giỏ hàng
                        CartDao cartDao = new CartDao();
                        List<CartItem> cartItems = cartDao.getCartItems(userId);

                        // Thêm đơn hàng vào CSDL
                        DonHangDao donHangDao = new DonHangDao();
                        for (CartItem item : cartItems) {
                            donHangDao.addDonHang(userId, item.getId_sanpham(), item.getSo_luong(), new Date(),
                                    "dang_xu_ly", "Thanh toán bằng VNPay", item.getGia_ban() * item.getSo_luong());
                        }

                        // Gửi email xác nhận đơn hàng
                        try {
                            EmailUtil.sendOrderConfirmationEmail(email, fullName, cartItems);
                        } catch (Exception e) {
                            out.print("{\"RspCode\":\"98\",\"Message\":\"Failed to send email\"}");
                            return;
                        }

                        // Xóa giỏ hàng
                        cartDao.clearCart(userId);

                        // Trả kết quả thành công
                        out.print("{\"RspCode\":\"00\",\"Message\":\"Confirm Success\"}");
                    } else {
                        // Giao dịch thất bại
                        out.print("{\"RspCode\":\"99\",\"Message\":\"Transaction Failed\"}");
                    }
                } else {
                    // Đơn hàng đã được xử lý trước đó
                    out.print("{\"RspCode\":\"02\",\"Message\":\"Order already confirmed\"}");
                }
            } else {
                // Số tiền không khớp
                out.print("{\"RspCode\":\"04\",\"Message\":\"Invalid Amount\"}");
            }
        } else {
            // Mã đơn hàng không tồn tại
            out.print("{\"RspCode\":\"01\",\"Message\":\"Order not found\"}");
        }
    } else {
        // Checksum không hợp lệ
        out.print("{\"RspCode\":\"97\",\"Message\":\"Invalid Checksum\"}");
    }
%>
