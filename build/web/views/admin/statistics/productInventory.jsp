<%-- 
    Document   : productInventory
    Created on : Nov 11, 2024, 1:55:11 PM
    Author     : hc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sản Phẩm Tồn Kho</title>
        <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link href="./assets/css/admin.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/views/admin/navbar.jsp" %>
        <div class="d-flex">
            <%@ include file="/views/admin/menu.jsp" %>
            <div class="content p-4">
                <!-- Thanh Menu Ngang -->
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-3">
                    <%@ include file="/views/admin/statistics/nav.jsp" %>
                </nav>

                <!-- Các nút xuất báo cáo -->
                <nav class="navbar navbar-expand-lg navbar-light bg-light mb-3">
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item" style="margin-right: 100px">
                                <form action="sptk" method="get" class="form-inline mb-4">
                                    <input class="form-control mr-2" type="number" name="so_luong" placeholder="Nhập số lượng" required>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="condition" value="greater" checked>
                                        <label class="form-check-label">Lớn hơn</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="condition" value="less">
                                        <label class="form-check-label">Nhỏ hơn</label>
                                    </div>
                                    <button class="btn btn-primary ml-2" type="submit">Tìm Kiếm</button>
                                </form>
                            </li>
                            <li class="nav-item">
                                <button class="btn btn-primary mr-2" onclick="exportToExcel()">Xuất Báo Cáo Excel</button>
                            </li>
                            <li class="nav-item">
                                <button class="btn btn-danger mr-2" onclick="exportToPDF()">Xuất Báo Cáo PDF</button>
                            </li>
                            <li class="nav-item">
                                <button class="btn btn-secondary" onclick="exportToWord()">Xuất Báo Cáo Word</button>
                            </li>
                        </ul>
                    </div>
                </nav>

                <!-- Bảng Sản Phẩm Tồn Kho --> 
                <h2 class="mt-4">Sản Phẩm Tồn Kho</h2>
                <table class="table table-bordered" id="productTable">
                    <thead class="thead-dark">
                        <tr>
                            <th>Name Product</th>
                            <th>Image</th>
                            <th>Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>${product.ten_sanpham}</td>
                                <td>
                                    <img src="./assets/image_product/${product.link_anh}" 
                                         alt="Product Image" style="width: 50px; height: 50px;">
                                </td>
                                <td>${product.so_luong}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
        <!-- Thêm link để sử dụng thư viện jsPDF với hỗ trợ Unicode -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>

        <script>
                                        async function exportToPDF() {
                                            const {jsPDF} = window.jspdf;

                                            // Khởi tạo jsPDF và cài đặt font hỗ trợ UTF-8
                                            const pdf = new jsPDF('p', 'pt', 'a4');
                                            pdf.setFont("helvetica", "normal");

                                            // Tiêu đề của PDF
                                            pdf.text("Danh Sach San Pham Ton Kho", 40, 30);

                                            // Lấy bảng HTML
                                            const table = document.getElementById('productTable');

                                            // Dùng autoTable để xuất PDF, giúp xử lý font Unicode và định dạng bảng
                                            pdf.autoTable({
                                                html: '#productTable',
                                                startY: 50,
                                                styles: {
                                                    font: 'helvetica', // font hỗ trợ UTF-8
                                                    fontSize: 10,
                                                    cellPadding: 5,
                                                    overflow: 'linebreak', // tránh đè chữ
                                                    halign: 'left'
                                                },
                                                headStyles: {
                                                    fillColor: [0, 0, 0], // màu nền cho header
                                                    textColor: [255, 255, 255], // màu chữ cho header
                                                },
                                                theme: 'grid'
                                            });

                                            // Lưu file PDF với tên
                                            pdf.save("SanPhamTonKho.pdf");
                                        }
        </script>

        <script>
            // Xuất Excel
            function exportToExcel() {
                let table = document.getElementById('productTable');
                let wb = XLSX.utils.table_to_book(table, {sheet: "San Pham Tan Kho"});
                XLSX.writeFile(wb, 'SanPhamTonKho.xlsx');
            }

            // Xuất Word
            function exportToWord() {
                let content = document.getElementById('productTable').outerHTML;
                let header = `
                    <html xmlns:o='urn:schemas-microsoft-com:office:office' 
                          xmlns:w='urn:schemas-microsoft-com:office:word' 
                          xmlns='http://www.w3.org/TR/REC-html40'>
                    <head><meta charset='utf-8'><title>Export HTML To Doc</title></head><body>`;
                let footer = "</body></html>";
                let sourceHTML = header + content + footer;

                let source = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(sourceHTML);
                let fileDownload = document.createElement("a");
                document.body.appendChild(fileDownload);
                fileDownload.href = source;
                fileDownload.download = 'SanPhamTonKho.doc';
                fileDownload.click();
                document.body.removeChild(fileDownload);
            }
        </script>

    </body>
</html>
