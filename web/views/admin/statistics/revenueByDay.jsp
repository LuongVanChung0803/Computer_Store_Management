<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thống Kê Doanh Thu</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <!-- Chart.js CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.css" rel="stylesheet">
        <link href="./assets/css/admin.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/views/admin/navbar.jsp" %>

        <div class="d-flex">
            <%@ include file="/views/admin/menu.jsp" %>

            <div class="content p-4">
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="margin-bottom: 10px;width: 1300px">
                    <%@ include file="/views/admin/statistics/nav.jsp" %>
                </nav>
                <form method="post" action="loadrevenueByDay">
                    <div class="mb-3">
                        <label for="datePicker" class="form-label">Chọn ngày:</label>
                        <input type="text" class="form-control" id="datePicker" name="selectedDate" placeholder="yyyy-mm-dd" style="width: 200px">
                    </div>

                    <button type="submit" class="btn btn-primary">Xem Thống Kê</button>
                    <button type="button" id="exportButton" class="btn btn-success">Xuất Excel</button>
                    <div class="mb-3">
                        <label for="fileName" class="form-label">Nhập tên file:</label>
                        <input type="text" class="form-control" id="fileName" placeholder="Nhập tên file để lưu" style="width: 200px">
                    </div>
                </form>

                <!-- Thống kê doanh thu -->
                <table class="table mt-4">
                    <thead>
                        <tr>
                            <th>Số Đơn Hàng</th>
                            <th><strong>${Countsp} Đơn hàng</strong></th>
                        </tr>
                    </thead>
                </table>

                <!-- Bảng thống kê doanh thu theo ngày -->
                <table class="table mt-4" id="revenueByDayTable">
                    <thead>
                        <tr>
                            <th>Ngày</th>
                            <th>Doanh Thu (VND)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            DecimalFormat decimalFormat = new DecimalFormat("#,##0");
                            Map<String, Double> revenueByDay = (Map<String, Double>) request.getAttribute("revenueByDay");
                            if (revenueByDay != null) {
                                for (Map.Entry<String, Double> entry : revenueByDay.entrySet()) {
                                    String formattedRevenue = decimalFormat.format(entry.getValue());
                        %>
                        <tr>
                            <td><%= entry.getKey() %></td>
                            <td><%= formattedRevenue %> VND</td>
                        </tr>
                        <% 
                                }
                            }
                        %>
                    </tbody>
                </table>

                <!-- Bảng chi tiết sản phẩm -->
                <table class="table mt-4" border="1" id="revenueTable">
                    <thead>
                        <tr>
                            <th>ID Đơn Hàng</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Hình Ảnh</th>
                            <th>Số Lượng</th>
                            <th>Tổng Tiền (VND)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Map<Integer, Map<String, Object>> productsByDay = (Map<Integer, Map<String, Object>>) request.getAttribute("productsByDay");
                            if (productsByDay != null) {
                                for (Map.Entry<Integer, Map<String, Object>> entry : productsByDay.entrySet()) {
                                    int idDonHang = entry.getKey();
                                    Map<String, Object> details = entry.getValue();
                                    String images = (String) details.get("link_anh");
                                    String tenSanPham = (String) details.get("tenSanPham");
                                    int soLuong = (int) details.get("soLuong");
                                    double tongTien = (double) details.get("tongTien");
                        %>
                        <tr>
                            <td><%= idDonHang %></td>
                            <td><%= tenSanPham %></td>
                            <td><img src="./assets/image_product/<%= images %>" alt="Product Image" class="product-image" style="width: 100px; height: auto;"></td>    
                            <td><%= soLuong %></td>
                            <td><fmt:formatNumber value="<%= tongTien %>" type="currency" currencySymbol="VND" pattern="#,##0" /> VND</td>
                        </tr>
                        <% 
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
        <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
        <script src="./assets/js/chart.min.js"></script>
        <script>
            function exportTableToExcel() {
                var downloadLink;
                var dataType = 'application/vnd.ms-excel';

                // Lấy cả hai bảng: doanh thu theo ngày và chi tiết sản phẩm
                var revenueTable = document.getElementById('revenueTable');
                var revenueByDayTable = document.getElementById('revenueByDayTable'); // Thêm bảng doanh thu theo ngày

                // Chuyển đổi bảng thành HTML
                var revenueTableHTML = revenueTable.outerHTML.replace(/ /g, '%20');
                var revenueByDayTableHTML = revenueByDayTable.outerHTML.replace(/ /g, '%20'); // Chuyển đổi bảng doanh thu theo ngày

                // Lấy tên file từ ô nhập
                var filename = document.getElementById('fileName').value.trim();
                if (!filename) {
                    filename = 'thong_ke_doanh_thu'; // Tên mặc định nếu không nhập
                }

                // Thêm phần mở rộng .xls
                filename = filename + '.xls';

                // Tạo link download
                downloadLink = document.createElement("a");
                document.body.appendChild(downloadLink);

                if (navigator.msSaveOrOpenBlob) {
                    var blob = new Blob(['\ufeff', revenueByDayTableHTML + revenueTableHTML], {type: dataType});
                    navigator.msSaveOrOpenBlob(blob, filename);
                } else {
                    // Các trình duyệt khác (Chrome, Firefox)
                    downloadLink.href = 'data:' + dataType + ', ' + revenueByDayTableHTML + revenueTableHTML;

                    // Tên file
                    downloadLink.download = filename;

                    // Kích hoạt sự kiện click để tải file
                    downloadLink.click();
                }
            }

// Sự kiện click cho nút "Xuất Excel"
            document.getElementById('exportButton').addEventListener('click', function () {
                exportTableToExcel();
            });


            // Cài đặt cho datepicker
            $('#datePicker').datepicker({format: 'yyyy-mm-dd', autoclose: true});
        </script>
    </body>
</html>
