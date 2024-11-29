/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import utils.connectionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Product;

/**
 *
 * @author hc
 */
public class ProductDao {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public ProductDao() {
    }
    //  getAllProduct

    public List<Map<String, Object>> getAllProduct() {
        List<Map<String, Object>> products = new ArrayList<>();
        String query = "SELECT p.id_sanpham, p.ten_sanpham, p.id_nhacungcap, p.gia,p.gia_ban ,p.mo_ta, p.so_luong, p.link_anh, n.ten_nhacungcap "
                + "FROM SanPham p JOIN NhaCC n ON p.id_nhacungcap = n.id_nhacungcap";

        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("id_sanpham", rs.getInt("id_sanpham"));
                product.put("ten_sanpham", rs.getString("ten_sanpham"));
                product.put("id_nhacungcap", rs.getInt("id_nhacungcap"));

                // Lấy giá bán từ cơ sở dữ liệu
                double gia = rs.getFloat("gia");
                double giaBan = rs.getFloat("gia_ban");

                // Tính giá cũ lớn hơn 30% giá bán
                double giaCu = giaBan / 0.7;
                DecimalFormat decimalFormat = new DecimalFormat("#,##0");
                String formattedGia = decimalFormat.format(gia);
                String formattedGiaCu = decimalFormat.format(giaCu);
                String formattedGiaBan = decimalFormat.format(giaBan);

                // Lưu giá cũ và giá bán vào map
                product.put("gia", formattedGia);
                product.put("gia_cu", formattedGiaCu);
                product.put("gia_ban", formattedGiaBan);

                product.put("mo_ta", rs.getString("mo_ta"));
                product.put("so_luong", rs.getInt("so_luong"));
                product.put("link_anh", rs.getString("link_anh"));
                product.put("ten_nhacungcap", rs.getString("ten_nhacungcap")); // Lưu tên nhà cung cấp vào map

                // Thêm sản phẩm vào danh sách
                products.add(product);
            }

        } catch (SQLException e) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }

        return products; // Trả về danh sách sản phẩm
    }
    // Lấy đường dẫn ảnh từ id_sanpham
    public String getAnhSanPhamById(int id_sanpham) {
        String link_anh = null;
        String query = "SELECT link_anh FROM SanPham WHERE id_sanpham = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id_sanpham);
            rs = ps.executeQuery();
            if (rs.next()) {
                link_anh = rs.getString("link_anh");
            }
        } catch (SQLException e) {
        }
        return link_anh;
    }

    //lấy sản phẩm mới
    public List<Product> getNewProduct() {
        List<Product> sp = new ArrayList<>();
        String query = """
                       SELECT * 
                       FROM SanPham 
                       ORDER BY id_sanpham DESC 
                       LIMIT 20;;""";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                sp.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getFloat(4),
                        rs.getFloat(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getString(8)
                ));
            }
        } catch (SQLException e) {
        }
        return sp;
    }

    // san pham dat nhat
    public List<Product> getExpensiveProduct() {
        List<Product> sp = new ArrayList<>();
        String query = """
                       SELECT * 
                       FROM SanPham 
                       ORDER BY gia DESC 
                       LIMIT 20;;""";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                sp.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getFloat(4),
                        rs.getFloat(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getString(8)
                ));
            }
        } catch (SQLException e) {
        }
        return sp;
    }

    //    addProduct
    public void addProduct(String ten_sanpham, int id_nhacungcap, float gia, float gia_ban, String mo_ta, int so_luong, String link_anh) {
        String query = "INSERT INTO SanPham ( ten_sanpham, id_nhacungcap, gia ,gia_ban, mo_ta, so_luong, link_anh) VALUES ( ?,?, ?, ?, ?,?,?)";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ten_sanpham);
            ps.setInt(2, id_nhacungcap);
            ps.setFloat(3, gia);
            ps.setFloat(4, gia_ban);
            ps.setString(5, mo_ta);
            ps.setInt(6, so_luong);
            ps.setString(7, link_anh);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    //delete 
    public void deleteSanPham(String id_sanpham) {
        String query = "DELETE FROM SanPham WHERE id_sanpham = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id_sanpham);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    // lay thong tin 
    public Product getmaProduct(int id_sanpham) {
        String query = "SELECT* FROM SanPham WHERE id_sanpham = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id_sanpham);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getFloat(4),
                        rs.getFloat(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getString(8));
            }
        } catch (SQLException e) {
        }
        return null;
    }

    ;
   
//    updateProduct
    public void updateProduct(String ten_sanpham, int id_nhacungcap, float gia, float gia_ban, String mo_ta, int so_luong, String link_anh, int id_sanpham) {
        String query = "UPDATE SanPham SET ten_sanpham = ?, id_nhacungcap = ?, gia = ?,gia_ban=?, mo_ta = ?, so_luong = ?,link_anh=?  WHERE id_sanpham = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ten_sanpham);
            ps.setInt(2, id_nhacungcap);
            ps.setFloat(3, gia);
            ps.setFloat(4, gia_ban);
            ps.setString(5, mo_ta);
            ps.setInt(6, so_luong);
            ps.setString(7, link_anh);
            ps.setInt(8, id_sanpham);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
//searchProductByName
 public List<Product> searchProductsByName(String ten_sanpham) {
        List<Product> sp = new ArrayList<>();
        String query = "SELECT * FROM SanPham WHERE ten_sanpham LIKE ?";
        
        try {
            conn = new connectionDB().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + ten_sanpham + "%");
            rs = ps.executeQuery();
            
            while (rs.next()) {
                sp.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getFloat(4),
                        rs.getFloat(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getString(8)
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        
        return sp;
    }
 //searchProductBySL
 // Tìm kiếm sản phẩm có số lượng lớn hơn một giá trị
    public List<Product> searchProductsByGreaterThanSL(int soLuong) {
        String query = "SELECT * FROM SanPham WHERE so_luong > ?";
        return getProductsByQuantity(query, soLuong);
    }

    // Tìm kiếm sản phẩm có số lượng nhỏ hơn một giá trị
    public List<Product> searchProductsByLessThanSL(int soLuong) {
        String query = "SELECT * FROM SanPham WHERE so_luong < ?";
        return getProductsByQuantity(query, soLuong);
    }

private List<Product> getProductsByQuantity(String query, int soLuong) {
    List<Product> products = new ArrayList<>();
    
    // Sử dụng try-with-resources để tự động đóng Connection, PreparedStatement, ResultSet
    try (Connection conn = new connectionDB().getConnection();  // Kết nối cơ sở dữ liệu
         PreparedStatement stmt = conn.prepareStatement(query)) {  // Chuẩn bị câu truy vấn
        stmt.setInt(1, soLuong);  // Thiết lập tham số cho câu truy vấn
        
        try (ResultSet rs = stmt.executeQuery()) {  // Thực thi truy vấn
            // Duyệt qua kết quả trả về
            while (rs.next()) {
                // Tạo đối tượng Product từ kết quả truy vấn
                Product product = new Product();
                
                product.setTen_sanpham(rs.getString("ten_sanpham"));  // Tên sản phẩm
                product.setSo_luong(rs.getInt("so_luong"));  // Số lượng
               
                product.setLink_anh(rs.getString("link_anh"));  // Liên kết hình ảnh
                
                // Thêm sản phẩm vào danh sách
                products.add(product);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();  // In ra lỗi nếu có
    }
    
    return products;  // Trả về danh sách sản phẩm tìm được
}

public List<Product> searchProductsBySL(int so_luong) {
    List<Product> sp = new ArrayList<>();
    String query = "SELECT * FROM SanPham WHERE so_luong > ?"; // Thay đổi điều kiện truy vấn
    
    try {
        conn = new connectionDB().getConnection();
        ps = conn.prepareStatement(query);
        ps.setInt(1, so_luong); // Đặt tham số số lượng
        rs = ps.executeQuery();
        
        while (rs.next()) {
            sp.add(new Product(rs.getInt(1),
                    rs.getString(2),
                    rs.getInt(3),
                    rs.getFloat(4),
                    rs.getFloat(5),
                    rs.getString(6),
                    rs.getInt(7),
                    rs.getString(8)
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Đảm bảo đóng kết nối để tránh rò rỉ tài nguyên
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    return sp;
}

 public List<Product> getAllProducts() {
        List<Product> sp = new ArrayList<>();
//        ORDER BY gia ASC
        String query = "SELECT * FROM SanPham ;";
        try {
            conn = new connectionDB().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                sp.add(new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getFloat(4),
                        rs.getFloat(5),
                        rs.getString(6),
                        rs.getInt(7),
                        rs.getString(8)
                        
                ));
               
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sp;
    }


    public List<Map<String, Object>> searchProductByName(String ten_sanpham) {
        List<Map<String, Object>> products = new ArrayList<>();
        String query = "SELECT p.id_sanpham, p.ten_sanpham, p.id_nhacungcap, p.gia,p.gia_ban ,p.mo_ta, p.so_luong, p.link_anh, n.ten_nhacungcap "
                + "FROM SanPham p JOIN NhaCC n ON p.id_nhacungcap = n.id_nhacungcap WHERE p.ten_sanpham LIKE ?";

        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + ten_sanpham + "%");  // Set the search parameter
            rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("id_sanpham", rs.getInt("id_sanpham"));
                product.put("ten_sanpham", rs.getString("ten_sanpham"));
                product.put("id_nhacungcap", rs.getInt("id_nhacungcap"));
                product.put("gia", rs.getFloat("gia"));
                product.put("gia_ban", rs.getFloat("gia_ban"));
                product.put("mo_ta", rs.getString("mo_ta"));
                product.put("so_luong", rs.getInt("so_luong"));
                product.put("link_anh", rs.getString("link_anh"));
                product.put("ten_nhacungcap", rs.getString("ten_nhacungcap"));
                products.add(product);
            }
        } catch (SQLException e) {
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }
        return products;
    }
}
