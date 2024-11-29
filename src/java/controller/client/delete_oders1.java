/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.client;

import dao.DonHangDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TaiKhoan;

/**
 *
 * @author hc
 */
@WebServlet(name = "delete_oder", urlPatterns = {"/delete_oders1"})
public class delete_oders1 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id_donhang = Integer.parseInt(request.getParameter("id_donhang"));
        DonHangDao dh = new DonHangDao();
        
        // Try to delete the order
        boolean isDeleted = dh.deleteOrder(id_donhang);
        
        // Check if deletion was successful
        if (isDeleted) {
            // Set success message
            request.getSession().setAttribute("deleteSuccessMessage", "Đơn hàng đã được hủy thành công!");
        } else {
            // Set failure message
            request.getSession().setAttribute("deleteErrorMessage", "Đơn hàng đã được xử lý ,không thể hủy đơn , bạn có thể nhắn tin với nhân viên để hủy đơn hàng nếu có thể ! .");
        }

        // Redirect to the order page
        TaiKhoan user = (TaiKhoan) request.getSession().getAttribute("user");
        if (user != null) {
            response.sendRedirect("OderServlet?sid=" + user.getId_nguoidung());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Do nothing, as no POST method is needed for this action
    }

    @Override
    public String getServletInfo() {
        return "Servlet for deleting an order";
    }
}


