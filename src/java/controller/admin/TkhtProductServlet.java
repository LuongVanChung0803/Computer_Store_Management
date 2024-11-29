package controller.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ProductDao;
import java.util.List;
import model.Product;

@WebServlet(name = "TkhtProductServlet", urlPatterns = {"/sptk"})
public class TkhtProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy tham số "so_luong" và "condition" từ request
        String soLuongParam = request.getParameter("so_luong");
        String condition = request.getParameter("condition"); // "greater" hoặc "less"
        int so_luong = 0; // Giá trị mặc định

        // Kiểm tra và chuyển đổi giá trị "so_luong" từ chuỗi sang số nguyên
        if (soLuongParam != null && !soLuongParam.isEmpty()) {
            try {
                so_luong = Integer.parseInt(soLuongParam);
            } catch (NumberFormatException e) {
                so_luong = 0; // Nếu chuyển đổi thất bại, sử dụng giá trị mặc định
            }
        }

        // Lấy danh sách sản phẩm dựa trên điều kiện lọc
        ProductDao productDao = new ProductDao();
        List<Product> products;
        
        if ("greater".equals(condition)) {
            products = productDao.searchProductsByGreaterThanSL(so_luong);
        } else {
            products = productDao.searchProductsByLessThanSL(so_luong);
        }

        // Đưa danh sách sản phẩm vào request attribute
        request.setAttribute("products", products);
        
        // Forward tới trang JSP hiển thị kết quả
        request.getRequestDispatcher("./views/admin/statistics/productInventory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Chuyển POST request sang xử lý bởi GET method
    }
}

