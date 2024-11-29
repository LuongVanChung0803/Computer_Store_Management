/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author hc
 */
public class DanhMuc {
    private int id_danhmuc;
    private String ten_danhmuc;
    private String mo_ta;

    public DanhMuc(int id_danhmuc, String ten_danhmuc, String mo_ta) {
        this.id_danhmuc = id_danhmuc;
        this.ten_danhmuc = ten_danhmuc;
        this.mo_ta = mo_ta;
    }

    public int getId_danhmuc() {
        return id_danhmuc;
    }

    public void setId_danhmuc(int id_danhmuc) {
        this.id_danhmuc = id_danhmuc;
    }

    public String getTen_danhmuc() {
        return ten_danhmuc;
    }

    public void setTen_danhmuc(String ten_danhmuc) {
        this.ten_danhmuc = ten_danhmuc;
    }

    public String getMo_ta() {
        return mo_ta;
    }

    public void setMo_ta(String mo_ta) {
        this.mo_ta = mo_ta;
    }

    @Override
    public String toString() {
        return "DanhMuc{" + "id_danhmuc=" + id_danhmuc + ", ten_danhmuc=" + ten_danhmuc + ", mo_ta=" + mo_ta + '}';
    }
}