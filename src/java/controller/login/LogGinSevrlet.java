package controller.login;

import dao.TaiKhoanDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import model.TaiKhoan;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "LogGinSevrlet", urlPatterns = {"/loadlogin"})
public class LogGinSevrlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("./views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenDangNhap = request.getParameter("login-username");
        String matKhau = request.getParameter("login-password");

        TaiKhoanDao dao = new TaiKhoanDao();
        TaiKhoan user = dao.findByUsername(tenDangNhap);

        HttpSession session = request.getSession();
        
        if (user != null) {
            if (checkPassword(matKhau, user.getMatkhau())) {
                if ("ON".equals(user.getTrang_thai())) {
                    session.setAttribute("user", user);
                    String message = "Đăng nhập thành công!";
                    if ("admin".equals(user.getVai_tro()) || "Nhân Viên".equals(user.getVai_tro())) {
                        response.sendRedirect("loaddashboard?message=" + URLEncoder.encode(message, "UTF-8"));
                    } else if ("Khách Hàng".equals(user.getVai_tro())) {
                        response.sendRedirect("loadhome?message=" + URLEncoder.encode(message, "UTF-8"));
                    }
                } else {
                    session.setAttribute("errorMessage", "Tài khoản không hoạt động.");
                    response.sendRedirect("loadlogin");
                }
            } else {
                session.setAttribute("errorMessage", "Sai mật khẩu.");
                response.sendRedirect("loadlogin");
            }
        } else {
            session.setAttribute("errorMessage", "Tài khoản không tồn tại.");
            response.sendRedirect("loadlogin");
        }
    }

    private boolean checkPassword(String plainPassword, String hashedPassword) {
        try {
            // Kiểm tra nếu mật khẩu đã băm
            if (hashedPassword.startsWith("$2a$") || hashedPassword.startsWith("$2b$")) {
                return BCrypt.checkpw(plainPassword, hashedPassword);
            } else {
                // So sánh trực tiếp nếu mật khẩu chưa băm
                if (plainPassword.equals(hashedPassword)) {
                    // Nếu khớp, mã hóa và cập nhật lại mật khẩu trong cơ sở dữ liệu
                    TaiKhoanDao dao = new TaiKhoanDao();
                    String newHashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
                    dao.updatePasswordByUsername(hashedPassword, newHashedPassword);
                    return true;
                }
                return false;
            }
        } catch (IllegalArgumentException e) {
            System.err.println("Lỗi kiểm tra mật khẩu: " + e.getMessage());
            return false;
        }
    }
    

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng nhập.";
    }
}
