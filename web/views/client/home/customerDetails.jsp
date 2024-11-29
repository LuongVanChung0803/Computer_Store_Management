<%-- 
    Document   : customerInformation
    Created on : Jun 17, 2024, 12:52:42 AM
    Author     : hc
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${product.ten_sanpham} - Product Details</title>
        <link rel="stylesheet" href="./assets/bootstrap-5.0.2-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link rel="stylesheet" href="./assets/css/index2.css">
        <link href="./assets/css/custommer.css" rel="stylesheet">

        <link href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap" rel="stylesheet">
        <!--        <link href="./assets/css/index_product.css" rel="stylesheet">-->
    </head>
    <body>
        <!-- Top Bar -->
        <div class="top-bar py-2">
            <%@ include file="/views/client/home/top_bar.jsp" %>
        </div>

        <!-- Main Header -->
        <div class="container my-4">
            <%@ include file="/views/client/home/header.jsp" %>
        </div>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-navbar">
            <%@ include file="/views/client/home/navigation_bar.jsp" %>
        </nav>
        <!--contact_and_cart-->
        <%@ include file="/views/client/home/contact_and_cart.jsp" %>

        <div class="container">
            <div class="customer-details">
                <h2>Thông Tin Khách Hàng</h2>
                <c:if test="${not empty khachHang}">
                    <p hidden><strong>ID:</strong> ${khachHang.id_khachhang}</p>
                    <p><strong>Name:</strong> ${khachHang.ho_ten}</p>
                    <p><strong>Email:</strong> ${khachHang.email}</p>
                    <p><strong>Phone:</strong> ${khachHang.so_dien_thoai}</p>
                    <p><strong>Address:</strong> ${khachHang.dia_chi}</p>
                    <button class="btn btn-warning" onclick="toggleUpdateForm()">Update</button>
                </c:if>
                <c:if test="${empty khachHang}">
                    <p>No customer found with the provided ID.</p>
                </c:if>
            </div>

            <div id="updateForm" class="modal" style="z-index: 1002">
                <div class="modal-content">
                    <span class="close" onclick="toggleUpdateForm()">&times;</span>
                    <form action="update_information_custommerServlet" method="post">
                        <input type="hidden" name="id_khachhang" value="${khachHang.id_khachhang}">
                        <div class="mb-3">
                            <label for="ho_ten" class="form-label">Name</label>
                            <input type="text" class="form-control" id="ho_ten" name="ho_ten" value="${khachHang.ho_ten}" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${khachHang.email}" required>
                        </div>
                        <div class="mb-3">
                            <label for="so_dien_thoai" class="form-label">Phone</label>
                            <input type="text" class="form-control" id="so_dien_thoai" name="so_dien_thoai" value="${khachHang.so_dien_thoai}" required>
                        </div>
                        <div class="mb-3">
                            <label for="dia_chi" class="form-label">Address</label>
                            <input type="text" class="form-control" id="dia_chi" name="dia_chi" value="${khachHang.dia_chi}" required>
                        </div>
                        <button type="submit" class="btn btn-success">Update</button>
                        <button type="button" class="btn btn-secondary" onclick="toggleUpdateForm()">Cancel</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- footer -->
 <%@ include file="/views/client/home/footer.jsp" %>
        <!-- Footer -->

        <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
        <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
        <script src="./assets/bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function toggleUpdateForm() {
                var updateForm = document.getElementById("updateForm");
                if (updateForm.style.display === "none" || updateForm.style.display === "") {
                    updateForm.style.display = "block";
                } else {
                    updateForm.style.display = "none";
                }
            }
        </script>
    </body>
</html>
