<%-- 
    Document   : delete_supplier
    Created on : Oct 23, 2024, 9:46:40 AM
    Author     : hc
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Supplier</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link href="./assets/css/admin.css" rel="stylesheet">

    </head>
    <body>
        <%@ include file="/views/admin/navbar.jsp" %>
        <div class="d-flex">
            <%@ include file="/views/admin/menu.jsp" %>
            <div class="content">
                <div class="container mt-5">
                    <h1 class="mb-4 text-center">Add Supplier</h1>
                    <form id="supplierForm" action="add_supplier" method="post" class="needs-validation" novalidate>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="Supplier_Name">Supplier Name</label>
                                <input type="text" class="form-control" id="ten_nhacungcap" name="ten_nhacungcap" required>
                                <div class="invalid-feedback">Please enter the supplier name.</div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="dia_chi">Address</label>
                                <input type="text" class="form-control" id="dia_chi" name="dia_chi" required>
                                <div class="invalid-feedback">Please enter the supplier address.</div>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="productPrice">Phone number</label>
                                <input type="number" class="form-control" id="so_dien_thoai" name="so_dien_thoai" required>
                                <div class="invalid-feedback">Please enter the supplier phone number.</div>
                            </div>

                            <div class="form-row">
                                <div class="col-md-12 text-center">
                                    <button type="submit" class="btn btn-primary">Add</button>
                                    <button type="reset" class="btn btn-secondary">Reset</button>
                                </div>
                            </div>
                    </form>
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
                            } else {
                                // Confirmation prompt
                                var confirmed = confirm("Are you sure you want to add this supplier?");
                                if (!confirmed) {
                                    event.preventDefault();
                                    return false;
                                }
                                // Show success message
                                alert("Supplier added successfully!");
                                // You can optionally reset the form after successful submission
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();
        </script>
    </body>
</html>
