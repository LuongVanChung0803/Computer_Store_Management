/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author hc
 */
public class NhaCC {
    private int id_nhacungcap;
    private String  ten_nhacungcap;
    private String dia_chi;
    private int so_dien_thoai;

    public NhaCC() {
    }
    public NhaCC(int id_nhacungcap, String ten_nhacungcap, String dia_chi, int so_dien_thoai) {
        this.id_nhacungcap = id_nhacungcap;
        this.ten_nhacungcap = ten_nhacungcap;
        this.dia_chi = dia_chi;
        this.so_dien_thoai = so_dien_thoai;
    }

    public int getId_nhacungcap() {
        return id_nhacungcap;
    }

    public void setId_nhacungcap(int id_nhacungcap) {
        this.id_nhacungcap = id_nhacungcap;
    }

    public String getTen_nhacungcap() {
        return ten_nhacungcap;
    }

    public void setTen_nhacungcap(String ten_nhacungcap) {
        this.ten_nhacungcap = ten_nhacungcap;
    }

    public String getDia_chi() {
        return dia_chi;
    }

    public void setDia_chi(String dia_chi) {
        this.dia_chi = dia_chi;
    }

    public int getSo_dien_thoai() {
        return so_dien_thoai;
    }

    public void setSo_dien_thoai(int so_dien_thoai) {
        this.so_dien_thoai = so_dien_thoai;
    }

    @Override
    public String toString() {
        return "NhaCC{" + "id_nhacungcap=" + id_nhacungcap + ", ten_nhacungcap=" + ten_nhacungcap + ", dia_chi=" + dia_chi + ", so_dien_thoai=" + so_dien_thoai + '}';
    }
    
}
