package test;

import dao.TaiKhoanDao;
import model.TaiKhoan;
import utils.EmailUtil;

public class test {
    public static void main(String[] args) {
        // Bước 1: Nhập email cần kiểm tra
        String email = "chungvann2003@gmail.com"; // Thay bằng email bạn muốn kiểm tra

        // Bước 2: Sử dụng TaiKhoanDao để lấy thông tin tài khoản từ email
        TaiKhoanDao taiKhoanDao = new TaiKhoanDao();
        TaiKhoan taiKhoan = taiKhoanDao.getTaiKhoanByEmail(email);

        if (taiKhoan != null) {
            // Bước 3: Lấy mật khẩu từ tài khoản tương ứng
            String password = taiKhoan.getMatkhau();
            
            // Bước 4: Gửi mật khẩu qua email
            boolean emailSent = EmailUtil.sendPasswordEmail(email, password);
            
            if (emailSent) {
                System.out.println("Đã gửi email thành công tới: " + email);
            } else {
                System.out.println("Gửi email thất bại. Vui lòng kiểm tra lại cấu hình.");
            }
        } else {
            System.out.println("Email không tồn tại trong hệ thống.");
        }
    }
}
