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
        <title>Thống Kê</title>
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
                <!-- Bootstrap Navbar -->
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="margin-bottom: 2px;width: 1300px">
                    <%@ include file="/views/admin/statistics/nav.jsp" %>
                </nav>
                <div class="container mt-5">
                    <!-- Form chọn tháng -->
                    <form method="post" action="revenueByMonth" class="row g-3">
                        <div class="col-md-6">
                            <label for="monthPicker" class="form-label">Chọn tháng:</label>
                            <input type="text" class="form-control" id="monthPicker" name="selectedMonth" placeholder="mm/yyyy" style="width: 200px">
                            <button type="submit" class="btn btn-primary mt-4" style="width: 200px">Xem Thống Kê</button>
                            <button id="exportButton" class="btn btn-primary mt-4">Xuất Excel</button>
                        </div>
                    </form>

                    <!-- Form nhập tên file -->
                    <div class="mb-3">
                        <label for="fileName" class="form-label">Nhập tên file (tùy chọn):</label>
                        <input type="text" class="form-control" id="fileName" placeholder="Tên file"style="width: 200px">
                    </div>

                    <!-- Kết quả thống kê -->
                    <div class="mt-4">
                        <h4>Kết Quả Thống Kê Doanh Thu:</h4>
                        <!-- Hiển thị tổng số đơn hàng -->
                        <table class="table mt-4">
                            <thead>
                                <tr>
                                    <th>Số Đơn Hàng</th>
                                    <th><strong>${totalOrders} Đơn hàng</strong></th>
                                </tr>
                            </thead>
                        </table>
                        <!-- Bảng tổng doanh thu -->
                        <table class="table mt-4" id="revenueSummaryTable" border="1" style="width: 100%; text-align: left;">
                            <thead>
                                <tr>
                                    <th>Tháng</th>
                                    <th>Doanh Thu (VND)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // Tạo một đối tượng DecimalFormat để định dạng số với dấu phẩy phân cách hàng nghìn
                                    DecimalFormat decimalFormat = new DecimalFormat("#,##0");
                                    Map<String, Double> revenueByMonth = (Map<String, Double>) request.getAttribute("revenueByMonth");
                                    if (revenueByMonth != null) {
                                        for (Map.Entry<String, Double> entry : revenueByMonth.entrySet()) {
                                            // Định dạng giá trị doanh thu
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
                    </div>
                </div>

                <div class="container mt-4">
                    <!-- Bảng chi tiết sản phẩm -->
                    <table class="table mt-4" id="revenueTable" border="1" style="width: 100%; text-align: left;">
                        <thead>
                            <tr>
                                <th>Tháng</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Hình Ảnh</th>
                                <th>Số Lượng</th>
                                <th>Tổng Tiền (VND)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="entry" items="${productsByMonth}">
                                <c:set var="monthKey" value="${entry.key}" />
                                <c:forEach var="product" items="${entry.value}">
                                    <tr>
                                        <td>${monthKey}</td>
                                        <td>${product.tenSanPham}</td>
                                        <td>
                                            <img src="./assets/image_product/${product.link_anh}" alt="Product Image" style="width: 100px; height: 100px;">
                                        </td>
                                        <td>${product.soLuong}</td>
                                        <td><fmt:formatNumber value="${product.tongTien}" type="currency" currencySymbol="VND" pattern="#,##0" /> VND</td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Bootstrap JS & Datepicker -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

                <script>
                    $(document).ready(function () {
                        $('#monthPicker').datepicker({
                            format: 'mm/yyyy',
                            viewMode: "months",
                            minViewMode: "months",
                            autoclose: true
                        });
                    });

                    function exportTableToExcel(tableID, filename = '') {
                        var downloadLink;
                        var dataType = 'application/vnd.ms-excel';

                        // Lấy bảng tổng doanh thu
                        var totalRevenueTable = document.getElementById('revenueSummaryTable');
                        var totalRevenueHTML = totalRevenueTable.outerHTML.replace(/ /g, '%20');

                        // Lấy bảng chi tiết sản phẩm theo tháng
                        var productDetailsTable = document.getElementById(tableID);
                        var productDetailsHTML = productDetailsTable.outerHTML.replace(/ /g, '%20');

                        // Lấy tên file từ input
                        var fileName = document.getElementById('fileName').value.trim() || 'thong_ke_theo_thang';

                        // Tạo tên file mặc định
                        filename = filename ? filename + '.xls' : fileName + '.xls';

                        // Tạo link download
                        downloadLink = document.createElement("a");
                        document.body.appendChild(downloadLink);

                        if (navigator.msSaveOrOpenBlob) {
                            var blob = new Blob(['\ufeff', totalRevenueHTML, productDetailsHTML], {
                                type: dataType
                            });
                            navigator.msSaveOrOpenBlob(blob, filename);
                        } else {
                            // Các trình duyệt khác (Chrome, Firefox)
                            downloadLink.href = 'data:' + dataType + ', ' + totalRevenueHTML + '%0D%0A' + productDetailsHTML;

                            // Tên file
                            downloadLink.download = filename;

                            // Kích hoạt sự kiện click để tải file
                            downloadLink.click();
                        }
                    }

                    // Sự kiện click cho nút "Xuất Excel"
                    document.getElementById('exportButton').addEventListener('click', function () {
                        exportTableToExcel('revenueTable');
                    });
                </script>
            </body>
        </html>
