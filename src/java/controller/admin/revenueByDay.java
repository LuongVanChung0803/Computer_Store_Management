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
@WebServlet(name="revenueByDay", urlPatterns={"/loadrevenueByDay"})
public class revenueByDay extends HttpServlet {
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
            out.println("<title>Servlet revenueByDay</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet revenueByDay at " + request.getContextPath () + "</h1>");
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
       
         request.getRequestDispatcher("./views/admin/statistics/revenueByDay.jsp").forward(request, response);
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
    String selectedDate = request.getParameter("selectedDate");
    ThongKeDao thongKeDao = new ThongKeDao();
    
    // Lấy dữ liệu doanh thu 
    Map<String, Double> revenueByDay = thongKeDao.getRevenueByDay(selectedDate);
    
    // Lấy thông tin sản phẩm cho đơn hàng theo ngày
    Map<Integer, Map<String, Object>> productsByDay = thongKeDao.getProductsByDay(selectedDate);
    
    // Đếm số đơn hàng
    int orderCount = (productsByDay != null) ? productsByDay.size() : 0;

    // Kiểm tra nếu không có sản phẩm
    String message = "";
    if (orderCount == 0) {
        message = "Không có đơn hàng nào trong ngày này.";
    }

    // Thiết lập các thuộc tính vào request
    request.setAttribute("selectedDate", selectedDate);
    request.setAttribute("revenueByDay", revenueByDay);
    request.setAttribute("productsByDay", productsByDay);
    request.setAttribute("Countsp", orderCount);
    request.setAttribute("message", message);  // Gửi thông báo nếu có

    // Chuyển tiếp đến JSP
    request.getRequestDispatcher("./views/admin/statistics/revenueByDay.jsp").forward(request, response);
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
