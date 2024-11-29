/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dao.NhaCCDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.NhaCC;

/**
 *
 * @author hc
 */
@WebServlet(name="update_supplier", urlPatterns={"/update_supplier"})
public class update_supplier extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet update_supplier</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet update_supplier at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id_nhacungcap = Integer.parseInt(request.getParameter("sid"));
        NhaCCDao nccd = new NhaCCDao();
        NhaCC ncc = nccd.getmaSupplier(id_nhacungcap);
        request.setAttribute("supplier", ncc);
        request.getRequestDispatcher("./views/admin/supplier/update_supplier.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
            String ten_nhacungcap = request.getParameter("ten_nhacungcap");
            String dia_chi = request.getParameter("dia_chi");
            int  so_dien_thoai = Integer.parseInt(request.getParameter("so_dien_thoai"));
            int  id_nhacungcap = Integer.parseInt(request.getParameter("id_nhacungcap"));
            
            NhaCCDao ncc = new NhaCCDao();
            ncc.updateNhaCC(ten_nhacungcap, dia_chi, so_dien_thoai,id_nhacungcap);
            response.sendRedirect("loadsupplier");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
