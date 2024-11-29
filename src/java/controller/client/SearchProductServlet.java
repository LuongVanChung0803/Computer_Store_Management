package controller.client;

import dao.DanhMucDao;
import dao.ProductDao;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DanhMuc;
import model.Product;

@WebServlet(name = "SearchProductServlet", urlPatterns = {"/SearchProductServlet"})
public class SearchProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        ProductDao pro = new ProductDao();
        List<Product> products = pro.searchProductsByName(keyword);
        request.setAttribute("searchResults", products);
        DanhMucDao dm = new DanhMucDao();
        
        List<DanhMuc> ldm = dm.getAllDanhMuc();
        request.setAttribute("ldms", ldm);
        RequestDispatcher dispatcher = request.getRequestDispatcher("./views/client/home/searchpage.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet cho phép tìm kiếm sản phẩm";
    }
}
