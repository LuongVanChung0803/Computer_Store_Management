/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.NhaCC;
import utils.connectionDB;

/**
 *
 * @author hc
 */
public class NhaCCDao {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;
    public NhaCCDao() {
    }
    //    getAllProduct
    public List<NhaCC> getAllNhaCC() {
        List<NhaCC> ncc = new ArrayList<>();
//        ORDER BY gia ASC
        String query = "SELECT * FROM NhaCC;";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                ncc.add(new NhaCC(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4)  
                ));
            }
        } catch (SQLException e) {
        }
        return ncc;
    }
    // add nhacungcap
    public boolean addNhaCC(String ten_nhacungcap, String dia_chi, int so_dien_thoai) {
        String query = "INSERT INTO NhaCC (ten_nhacungcap, dia_chi, so_dien_thoai) VALUES ( ?, ?, ?)";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ten_nhacungcap);
            ps.setString(2, dia_chi);
            ps.setInt(3, so_dien_thoai);
            ps.executeUpdate();
         return true;
        } catch (SQLException e) {
            return false;
        }
    }

    //delete nhacc
    public void deleteNhaCC(String id_nhacungcap) {
        String query = "DELETE FROM NhaCC WHERE id_nhacungcap = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id_nhacungcap);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
    
    // update nhacc
    public void updateNhaCC( String ten_nhacungcap, String dia_chi, int so_dien_thoai,int id_nhacungcap) {
        String query = "UPDATE NhaCC SET ten_nhacungcap = ?, dia_chi = ?, so_dien_thoai = ? WHERE id_nhacungcap = ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, ten_nhacungcap);
            ps.setString(2, dia_chi);
            ps.setInt(3, so_dien_thoai);
            ps.setInt(4, id_nhacungcap);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
    
    
    
     // tim kiem khach hang
    public List<NhaCC> searchNhaCC(String ten_nhacungcap) {
        List<NhaCC> ncc = new ArrayList<>();
        String query = "SELECT * FROM NhaCC WHERE ten_nhacungcap LIKE ?";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + ten_nhacungcap + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                ncc.add(new NhaCC(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4)
                ));
            }
        } catch (SQLException e) {
        }
        return ncc;
    }
    
    // Lấy tên nhà cung cấp dựa vào id_nhacungcap
public String getTenNhaCCById(int id_nhacungcap) {
    String query = "SELECT ten_nhacungcap FROM NhaCC WHERE id_nhacungcap = ?";
    try {
        conn = connectionDB.getConnection();
        ps = conn.prepareStatement(query);
        ps.setInt(1, id_nhacungcap);
        rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getString(1); // Trả về tên nhà cung cấp
        }
    } catch (SQLException e) {
    }
    return null; // Trả về null nếu không tìm thấy hoặc có lỗi
}


    
   //lay thong tin 1 ncc
    public  NhaCC getmaSupplier(int id_nhacungcap){
        String query ="SELECT* FROM NhaCC WHERE id_nhacungcap = ?";
        try {
        conn = connectionDB.getConnection();
        ps = conn.prepareStatement(query);
        ps.setInt(1, id_nhacungcap);
        rs = ps.executeQuery();
         while (rs.next()) {
                return new NhaCC(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4));
            }
    } catch (SQLException e) {
    }
        return null;
    };
}
