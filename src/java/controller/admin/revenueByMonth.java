/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import dao.ThongKeDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hc
 */
@WebServlet(name="revenueByMonth", urlPatterns={"/revenueByMonth"})
public class revenueByMonth extends HttpServlet {
   private static final long serialVersionUID = 1L;
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
            out.println("<title>Servlet revenueByMonth</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet revenueByMonth at " + request.getContextPath () + "</h1>");
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
        request.getRequestDispatcher("./views/admin/statistics/revenueByMonth.jsp").forward(request, response);
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
        String selectedMonth = request.getParameter("selectedMonth");

        ThongKeDao thongKeDao = new ThongKeDao();

        // Thống kê doanh thu theo tháng
        Map<String, Double> revenueByMonth = thongKeDao.getRevenueByMonth(selectedMonth);

        // Lấy sản phẩm theo tháng
        Map<String, List<Map<String, Object>>> productsByMonth = thongKeDao.getProductsByMonth(selectedMonth);
        // Đếm số lượng sản phẩm
        int productCount = 0;
        if (productsByMonth != null) {
            for (List<Map<String, Object>> productList : productsByMonth.values()) {
                productCount += productList.size();
            }
        }
        // Đặt thuộc tính cho request
        request.setAttribute("selectedMonth", selectedMonth);
        request.setAttribute("revenueByMonth", revenueByMonth);
        request.setAttribute("productsByMonth", productsByMonth);
        request.setAttribute("totalOrders", productCount);
        request.getRequestDispatcher("./views/admin/statistics/revenueByMonth.jsp").forward(request, response);
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
