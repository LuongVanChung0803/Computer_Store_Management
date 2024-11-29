<%-- 
    Document   : update_supplier
    Created on : Oct 23, 2024, 10:11:08 AM
    Author     : hc
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Product</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link href="./assets/css/admin.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/views/admin/navbar.jsp" %>
    <div class="d-flex">
        <%@ include file="/views/admin/menu.jsp" %>
            <div class="content" style="width: 1000px ;padding-left: 300px ;margin-bottom:150px" >
                <div class="container mt-5"> 
                    <h2 class="mb-4 text-center">Update Supplier</h2>
                    <form id="updateForm" action="update_supplier" method="post" class="needs-validation" novalidate>
                        
                            <div class="form-group ">
                                <label for="Supplier_Name">Supplier Name</label>
                                <input type="text" class="form-control" id="ten_nhacungcap" name="ten_nhacungcap" value="${supplier.ten_nhacungcap}" required>
                                <div class="invalid-feedback">Please enter the supplier name.</div>
                            </div>
                        
                            <div class="form-group ">
                                <label for="dia_chi">Address</label>
                                <input type="text" class="form-control" id="dia_chi" name="dia_chi" value="${supplier.dia_chi}" required>
                                <div class="invalid-feedback">Please enter the supplier address.</div>
                            </div>
                            <div class="form-group ">
                                <label for="phone">Phone number</label>
                                <input type="number" class="form-control" id="so_dien_thoai" name="so_dien_thoai" value="${supplier.so_dien_thoai}" required>
                                <div class="invalid-feedback">Please enter the supplier phone number.</div>
                            </div>
                            <input hidden type="hidden" name="id_nhacungcap" id="id_nhacungcap" value="${supplier.id_nhacungcap}">
                            <div class="text-center">
                                <button type="button" class="btn btn-primary" onclick="confirmUpdate()">Update</button>
                                <button type="button" class="btn btn-secondary" onclick="cancelUpdate()">Cancel</button>
                            </div>
                    </form>
                </div>
            </div>
        </div>


    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
    <script src="./assets/js/popper.min.js"></script>  
<script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
<script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>

<!-- Custom JS for validation and confirmation -->
<script>
                                (function () {
                                    'use strict';
                                    window.addEventListener('load', function () {
                                        var forms = document.getElementsByClassName('needs-validation');
                                        var validation = Array.prototype.filter.call(forms, function (form) {
                                            form.addEventListener('submit', function (event) {
                                                if (form.checkValidity() === false) {
                                                    event.preventDefault();
                                                    event.stopPropagation();
                                                }
                                                form.classList.add('was-validated');
                                            }, false);
                                        });
                                    }, false);
                                })();

                                function confirmUpdate() {
                                    if (confirm("Are you sure you want to update this supplier?")) {
                                        document.getElementById("updateForm").submit();
                                    }
                                }

                                function cancelUpdate() {
                                    if (confirm("Are you sure you want to cancel the update?")) {
                                        // Redirect to the previous page or perform any other action
                                        window.history.back();
                                    }
                                }
</script>
</body>
</html>

