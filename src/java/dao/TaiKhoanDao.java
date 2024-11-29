package dao;

import utils.connectionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.TaiKhoan;

public class TaiKhoanDao {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public TaiKhoanDao() {
    }
    public TaiKhoan getTaiKhoanByEmail(String email) {
        TaiKhoan taiKhoan = null;
        try {
            String query = "SELECT * FROM TaiKhoan WHERE email = ?";
            conn = connectionDB.getConnection(); // Kết nối cơ sở dữ liệu
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                taiKhoan = new TaiKhoan();
                taiKhoan.setEmail(rs.getString("email"));
                taiKhoan.setMatkhau(rs.getString("matkhau"));
                // Cài thêm các thuộc tính khác nếu có
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return taiKhoan;
    }
    
    // Kiểm tra sự tồn tại của email trong hệ thống
    public TaiKhoan getTaiKhoanByEmails(String email) {
        TaiKhoan taiKhoan = null;
        try {
            String query = "SELECT * FROM TaiKhoan WHERE email = ?";
            conn = connectionDB.getConnection(); // Kết nối cơ sở dữ liệu
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                taiKhoan = new TaiKhoan();
                taiKhoan.setEmail(rs.getString("email"));
                taiKhoan.setMatkhau(rs.getString("matkhau"));
                // Cài thêm các thuộc tính khác nếu có
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return taiKhoan;
    }
    
// Phương thức cập nhật mật khẩu
    public boolean updatePassword(TaiKhoan taiKhoan) {
        boolean isUpdated = false;
        String query = "UPDATE TaiKhoan SET matkhau = ? WHERE email = ?";

        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, taiKhoan.getMatkhau()); // Cập nhật mật khẩu mới
            ps.setString(2, taiKhoan.getEmail());  // Dựa vào email để xác định tài khoản

            int rowsAffected = ps.executeUpdate(); // Thực thi câu lệnh SQL

            if (rowsAffected > 0) {
                isUpdated = true; // Nếu cập nhật thành công
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return isUpdated; // Trả về kết quả cập nhật
    }
    
    // Cập nhật mật khẩu mới
    public boolean updatePassword(String email, String newPassword) {
        try {
            String query = "UPDATE TaiKhoan SET matkhau = ? WHERE email = ?";
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    // Đóng kết nối và tài nguyên
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lay danh sach tai khoan
    public List<TaiKhoan> getAllTaiKhoan() {
        List<TaiKhoan> tk = new ArrayList<>();
        String query = "SELECT * FROM TaiKhoan;";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                tk.add(new TaiKhoan(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)
                ));
            }
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return tk;
    }

    // Login
    public TaiKhoan login(String ten_dangnhap, String matkhau) {
        String query = "SELECT * FROM TaiKhoan WHERE ten_dangnhap = ? AND matkhau = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ten_dangnhap);
            ps.setString(2, matkhau);
            rs = ps.executeQuery();

            if (rs.next()) {
                return new TaiKhoan(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return null;
    }

    // Them tai khoan
    public void addTaiKhoan(String ten_dangnhap, String matkhau, String email, String vai_tro, String trang_thai) {
        String query = "INSERT INTO TaiKhoan (ten_dangnhap, matkhau, email, vai_tro, trang_thai) VALUES (?, ?, ?, ?, ?)";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ten_dangnhap);
            ps.setString(2, matkhau);
            ps.setString(3, email);
            ps.setString(4, vai_tro);
            ps.setString(5, trang_thai);
            ps.executeUpdate();
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
    }


    // Xoa tai khoan
    public void deleteTaiKhoan(String id_nguoidung) {
        String query = "DELETE FROM TaiKhoan WHERE id_nguoidung = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id_nguoidung);
            ps.executeUpdate();
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
    }

    // Cap nhat tai khoan
    public void updateTaiKhoan(String ten_dangnhap, String matkhau, String email, String vai_tro, String trang_thai, String id_nguoidung) {
        String query = "UPDATE TaiKhoan SET ten_dangnhap = ?, matkhau = ?, email = ?, vai_tro = ?, trang_thai = ? WHERE id_nguoidung = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ten_dangnhap);
            ps.setString(2, matkhau);
            ps.setString(3, email);
            ps.setString(4, vai_tro);
            ps.setString(5, trang_thai);
            ps.setString(6, id_nguoidung);
            ps.executeUpdate();
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
    }

    // Lay thong tin tai khoan bang id
    public TaiKhoan getidNguoiDung(int id_nguoidung) {
        String query = "SELECT * FROM TaiKhoan WHERE id_nguoidung = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id_nguoidung);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new TaiKhoan(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return null;
    }

    // Tim kiem tai khoan bang ten
    public List<TaiKhoan> searchUserByName(String ten_dangnhap) {
        List<TaiKhoan> sp = new ArrayList<>();
        String query = "SELECT * FROM TaiKhoan WHERE ten_dangnhap LIKE ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + ten_dangnhap + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                sp.add(new TaiKhoan(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return sp;
    }

    // Kiem tra username da ton tai
    public boolean usernameExists(String ten_dangnhap) {
        String query = "SELECT * FROM TaiKhoan WHERE ten_dangnhap = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ten_dangnhap);
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return false;
    }

    // Kiem tra email da ton tai
    public boolean emailExists(String email) {
        String query = "SELECT * FROM TaiKhoan WHERE email = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return false;
    }
    public TaiKhoan findByUsername(String ten_dangnhap) {
    String query = "SELECT * FROM TaiKhoan WHERE ten_dangnhap = ? ";
    
    try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ten_dangnhap);
            rs = ps.executeQuery();

            if (rs.next()) {
                return new TaiKhoan(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return null;
}
    public void updatePasswordByUsername(String ten_dangnhap, String matkhau) {
    String query = "UPDATE TaiKhoan SET matkhau = ? WHERE ten_dangnhap = ?";
    try {
        // Lấy kết nối từ connectionDB
        conn = connectionDB.getConnection();

        // Chuẩn bị câu lệnh SQL
        ps = conn.prepareStatement(query);
        ps.setString(1, matkhau);
        ps.setString(2, ten_dangnhap);

        // Thực thi cập nhật
        int rowsUpdated = ps.executeUpdate();
        if (rowsUpdated > 0) {
            System.out.println("Cập nhật mật khẩu thành công cho tài khoản: " + ten_dangnhap);
        } else {
            System.out.println("Không tìm thấy tài khoản với tên đăng nhập: " + ten_dangnhap);
        }
    } catch (SQLException e) {
        System.err.println("Lỗi khi cập nhật mật khẩu: " + e.getMessage());
    } finally {
        // Đóng tài nguyên
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                System.err.println("Không thể đóng PreparedStatement: " + e.getMessage());
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Không thể đóng kết nối: " + e.getMessage());
            }
        }
    }
}



    // Dong tai nguyen

}
