/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dao.CartDao;
import dao.DanhMucDao;
import dao.KhachHangDao;
import dao.TaiKhoanDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.DanhMuc;
import model.KhachHang;
import model.TaiKhoan;
import org.apache.catalina.User;

/**
 *
 * @author hc
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id_nguoidung;

        try {
            id_nguoidung = Integer.parseInt(request.getParameter("sid"));
        } catch (NumberFormatException e) {
            // Redirect to login if sid is not a valid integer
            response.sendRedirect("loadlogin");
            return;
        }
        DanhMucDao dm = new DanhMucDao();
        List<DanhMuc> ldm = dm.getAllDanhMuc();
        
        
        KhachHangDao khachHangDao = new KhachHangDao();
        KhachHang khachHang = khachHangDao.getCustomerById(id_nguoidung);

        CartDao cartDao = new CartDao();
        List<CartItem> cartItems = cartDao.getItemsByUserId(id_nguoidung);
        
        TaiKhoanDao tk = new TaiKhoanDao();
        TaiKhoan tkk = tk.getidNguoiDung(id_nguoidung);
        

        if (cartItems != null) {
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("khachHang", khachHang);
            request.setAttribute("user", tkk);
            request.setAttribute("ldms", ldm);
            request.getRequestDispatcher("./views/client/home/Cart.jsp").forward(request, response);
            
        } else {
            request.setAttribute("khachHang", khachHang);
            request.setAttribute("cartItems", new ArrayList<CartItem>());
            request.setAttribute("user", tkk);
            request.setAttribute("ldms", ldm);
            request.getRequestDispatcher("./views/client/home/Cart.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
