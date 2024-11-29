package controller.login;

import dao.TaiKhoanDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.TaiKhoan;
import java.io.IOException;
import utils.EmailUtil;
import utils.OTPUtils;


@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {

    private TaiKhoanDao taiKhoanDao;

    @Override
    public void init() throws ServletException {
        taiKhoanDao = new TaiKhoanDao();
    }
   

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        TaiKhoan taiKhoan = taiKhoanDao.getTaiKhoanByEmail(email);

        if (taiKhoan != null) {
            // Tạo OTP
            String otp = OTPUtils.generateOTP();

            // Lưu OTP vào session
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);

            // Gửi OTP qua email
            boolean emailSent = EmailUtil.sendOTPEmail(email, otp);
            if (emailSent) {
                // Chuyển đến form nhập OTP
                response.sendRedirect("VerifyOTPServlet2");
            } else {
                // Nếu gửi email thất bại
                request.setAttribute("errorMessage", "Không thể gửi OTP, vui lòng thử lại!");
                request.getRequestDispatcher("./views/forgotPassword.jsp").forward(request, response);
            }
        } else {
            // Nếu email không tồn tại trong hệ thống
            request.setAttribute("errorMessage", "Email không tồn tại trong hệ thống.");
            request.getRequestDispatcher("./views/forgotPassword.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển đến trang quên mật khẩu
        request.getRequestDispatcher("./views/forgotPassword.jsp").forward(request, response);
    }
}

