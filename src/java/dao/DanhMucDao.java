/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.SQLException;
import java.util.List;
import model.DanhMuc;
import utils.connectionDB;

/**
 *
 * @author hc
 */
public class DanhMucDao {
    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public DanhMucDao() {
    }
    
    public List<DanhMuc> getAllDanhMuc() {
        List<DanhMuc> danhmuc = new ArrayList<>();
        String query = "SELECT * FROM DanhMuc;";
        try {
            conn = connectionDB.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                danhmuc.add(new DanhMuc(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)
                        
                ));
            }
        } catch (SQLException e) {
            
        }
        return danhmuc;
    }
    
}
