package controller.login;

import model.TaiKhoan;
import dao.TaiKhoanDao; // Đảm bảo bạn đã có lớp DAO xử lý database
import model.GoogleAccount;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ggLoginServlet", urlPatterns = {"/login"})
public class ggLoginServlet extends HttpServlet {

    private TaiKhoanDao taiKhoanDAO;

    @Override
    public void init() throws ServletException {
        taiKhoanDAO = new TaiKhoanDao(); // Khởi tạo DAO
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy mã xác thực và lỗi (nếu có) từ Google OAuth
        String code = request.getParameter("code");
        String error = request.getParameter("error");

        if (error != null) {
            // Nếu người dùng từ chối quyền truy cập
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
            return;
        }

        // Xử lý xác thực Google
        GoogleLogin gg = new GoogleLogin();
        String accessToken = gg.getToken(code);
        GoogleAccount googleAccount = gg.getUserInfo(accessToken);

        // Kiểm tra sự tồn tại của email trong hệ thống
        TaiKhoan existingAccount = taiKhoanDAO.getTaiKhoanByEmails(googleAccount.getEmail());

        if (existingAccount == null) {
            // Nếu tài khoản chưa tồn tại, thêm tài khoản mới
            String tenDangNhap = googleAccount.getEmail(); // Tên đăng nhập mặc định là email
            String matKhau = googleAccount.getId(); // Mật khẩu tạm thời là id
            String vaiTro = "Khách Hàng"; // Mặc định vai trò là user
            String trangThai = "ON"; // Trạng thái mặc định là "on"

            taiKhoanDAO.addTaiKhoan(tenDangNhap, matKhau, googleAccount.getEmail(), vaiTro, trangThai);
        }

        // Chuyển tiếp thông tin người dùng tới trang login.jsp
        request.setAttribute("email", googleAccount.getEmail());
        request.setAttribute("id", googleAccount.getId());
        request.getRequestDispatcher("views/login.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Google Login Servlet";
    }
}
