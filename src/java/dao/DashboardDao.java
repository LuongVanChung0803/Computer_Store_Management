/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.DonHang;
import utils.connectionDB;
/**
 *
 * @author hc
 */



public class DashboardDao {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    // Method to get total users count
   

    // Method to get recent orders
    public List<DonHang> getRecentOrders() {
        List<DonHang> orders = new ArrayList<>();
        String query = "SELECT * FROM DonHang ORDER BY ngay_dat DESC LIMIT 10";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                DonHang order = new DonHang(
                        rs.getInt("id_donhang"),
                        rs.getInt("id_khachhang"),
                        rs.getInt("id_sanpham"),
                         rs.getInt("so_luong"),
                        rs.getDate("ngay_dat"),
                        rs.getString("trang_thai"),
                         rs.getString("hinh_thuc_thanh_toan"),
                        
                        rs.getFloat("tong_tien")
                );
                orders.add(order);
            }
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return orders;
    }
    
        // Khách hàng có đơn hàng nhiều nhất và tổng số tiền của tất cả đơn hàng ấy
    public Map<String, Object> getCustomerWithMostOrdersAndTotalAmount() {
        Map<String, Object> result = new HashMap<>();
        String query = "SELECT id_khachhang, COUNT(*) as so_don_hang, SUM(tong_tien) as tong_tien " +
                       "FROM DonHang " +
                       "GROUP BY id_khachhang " +
                       "ORDER BY so_don_hang DESC " +
                       "LIMIT 1";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                int id_khachhang = rs.getInt("id_khachhang");
                int so_don_hang = rs.getInt("so_don_hang");
                float tong_tien = rs.getFloat("tong_tien");

                result.put("id_khachhang", id_khachhang);
                result.put("so_don_hang", so_don_hang);
                result.put("tong_tien", tong_tien);
            }
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return result;
    }

    // Đơn hàng bán chạy nhất
    public Map<String, Object> getBestSellingProduct() {
        Map<String, Object> result = new HashMap<>();
        String query = "SELECT id_sanpham, SUM(so_luong) as total_quantity " +
                       "FROM DonHang " +
                       "GROUP BY id_sanpham " +
                       "ORDER BY total_quantity DESC " +
                       "LIMIT 1";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                int id_sanpham = rs.getInt("id_sanpham");
                int total_quantity = rs.getInt("total_quantity");

                result.put("id_sanpham", id_sanpham);
                result.put("total_quantity", total_quantity);
            }
        } catch (SQLException e) {
        } finally {
            closeResources();
        }
        return result;
    }


    // Method to close resources
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
        }
    }
}
