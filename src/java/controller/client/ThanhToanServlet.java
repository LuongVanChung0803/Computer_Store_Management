package controller.client;

import dao.KhachHangDao;
import dao.CartDao;
import dao.DonHangDao;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import utils.EmailUtil;

@WebServlet(name = "ThanhToanServlet", urlPatterns = {"/ThanhToanServlet"})
public class ThanhToanServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        int id_donhang;
//        do {
//            // Tạo số ngẫu nhiên và kiểm tra tồn tại
//            id_donhang = Integer.parseInt(utils.Config.getRandomNumber(8));
//        } while (DonHangDao.isIdDonHangExists(id_donhang));
        String ho_ten = request.getParameter("ho_ten");
        String email = request.getParameter("email");
        String dia_chi = request.getParameter("dia_chi");
        int so_dien_thoai = Integer.parseInt(request.getParameter("so_dien_thoai"));
        int id_nguoidung = Integer.parseInt(request.getParameter("id_nguoidung"));
        String hinh_thuc_thanh_toan = request.getParameter("hinh_thuc_thanh_toan");

        // Kiểm tra khách hàng có tồn tại chưa
        KhachHangDao kh = new KhachHangDao();
        if (!kh.customerExists(id_nguoidung)) {
            kh.addCustomer(id_nguoidung, ho_ten, email, dia_chi, so_dien_thoai, id_nguoidung);
        }

        // Lấy danh sách sản phẩm trong giỏ hàng
        CartDao cartDao = new CartDao();
        List<CartItem> cartItems = cartDao.getCartItems(id_nguoidung);

        // Tính tổng tiền và lưu vào session
        double totalAmount = calculateTotalAmount(cartItems);
        HttpSession session = request.getSession();
        session.setAttribute("totalAmount", totalAmount);
        session.setAttribute("ho_ten", ho_ten);
        session.setAttribute("email", email);
        session.setAttribute("id_nguoidung", id_nguoidung);

        DonHangDao donHangDao = new DonHangDao();

        if ("Thanh toán bằng vnpay".equals(hinh_thuc_thanh_toan)) {
            // Xử lý thanh toán bằng VNPAY
            response.sendRedirect("http://localhost:9999/WebQLBanMayTinh1/PaymentServlet");
        } else {
            // Xử lý thanh toán tiền mặt
            for (CartItem item : cartItems) {
                donHangDao.addDonHang(id_nguoidung, item.getId_sanpham(), item.getSo_luong(), new Date(),
                        "dang_xu_ly", hinh_thuc_thanh_toan, item.getGia_ban() * item.getSo_luong());
            }
            boolean emailSent = EmailUtil.sendOrder_Cash_ConfirmationEmail(email, ho_ten, cartItems);
            if (emailSent) {
                cartDao.clearCart(id_nguoidung);
                response.sendRedirect("CartServlet?sid=" + id_nguoidung);
            } else {
                response.getWriter().write("Có lỗi khi gửi email xác nhận.");
            }
        }
    }

    /**
     * Tính tổng tiền đơn hàng
     */
    private double calculateTotalAmount(List<CartItem> cartItems) {
        double totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getGia_ban() * item.getSo_luong();
        }
        return totalAmount;
    }
}
