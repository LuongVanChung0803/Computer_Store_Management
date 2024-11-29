/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author hc
 */
public class ThanhToan {
    private int id_thanhtoan;
    private int id_donhang;
    private Date ngay_thanhtoan;
    private double so_tien;
    private String hinh_thuc_thanh_toan;

    public ThanhToan(int id_thanhtoan, int id_donhang, Date ngay_thanhtoan, double so_tien, String hinh_thuc_thanh_toan) {
        this.id_thanhtoan = id_thanhtoan;
        this.id_donhang = id_donhang;
        this.ngay_thanhtoan = ngay_thanhtoan;
        this.so_tien = so_tien;
        this.hinh_thuc_thanh_toan = hinh_thuc_thanh_toan;
    }

    
}
