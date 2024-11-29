/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.login;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author hc
 */
import dao.TaiKhoanDao;
import jakarta.servlet.http.HttpSession;
import model.TaiKhoan;
import utils.EmailUtil;

@WebServlet(name = "VerifyOTPServlet2", urlPatterns = {"/VerifyOTPServlet2"})
public class VerifyOTPServlet2 extends HttpServlet {

    private TaiKhoanDao taiKhoanDao;

    @Override
    public void init() throws ServletException {
        taiKhoanDao = new TaiKhoanDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String otpInput = request.getParameter("otp");
        HttpSession session = request.getSession();
        String generatedOtp = (String) session.getAttribute("otp");
        String email = (String) session.getAttribute("email");

        // Kiểm tra OTP
        if (generatedOtp != null && generatedOtp.equals(otpInput)) {
            // OTP chính xác, cho phép thay đổi mật khẩu
            String newPassword = request.getParameter("newPassword");
            TaiKhoan taiKhoan = taiKhoanDao.getTaiKhoanByEmail(email);
            
            if (taiKhoan != null) {
                // Cập nhật mật khẩu mới
                taiKhoan.setMatkhau(newPassword);
                taiKhoanDao.updatePassword(taiKhoan);

                // Gửi mật khẩu mới qua email
                boolean emailSent = EmailUtil.sendPasswordEmail(email, newPassword);
                if (emailSent) {
                    request.setAttribute("successMessage", "Mật khẩu đã được thay đổi thành công và gửi qua email!");
                    response.sendRedirect("loadlogin"); // Chuyển đến trang đăng nhập
                } else {
                    request.setAttribute("errorMessage", "Không thể gửi mật khẩu mới qua email!");
                    request.getRequestDispatcher("./views/verifyOTP.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy tài khoản!");
                request.getRequestDispatcher("./views/verifyOTP.jsp").forward(request, response);
            }
        } else {
            // OTP không chính xác
            request.setAttribute("errorMessage", "OTP không chính xác!");
            request.getRequestDispatcher("./views/verifyOTP.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển đến trang xác minh OTP
        request.getRequestDispatcher("./views/verifyOTP.jsp").forward(request, response);

    }
}
