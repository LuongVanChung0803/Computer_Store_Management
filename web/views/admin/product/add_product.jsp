
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Product</title>
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
                    <h1 class="mb-4 text-center">Add Product</h1>
                    <form id="productForm" action="add_product" method="post" class="needs-validation" novalidate>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="productName">Product Name</label>
                                <input type="text" class="form-control" id="productName" name="productName" required>
                                <div class="invalid-feedback">Please enter the product name.</div>
                            </div>
                        </div>
                        <div class="form-row">


                            <div class="form-group col-md-6">
                                <label for="nhacungcap">Nhà Cung Cấp</label>
                                <select class="form-control" id="nhacungcap" name="nhacungcap" required>
                                    <!--                                    <option value=""></option>-->
                                    <c:forEach items="${nhaCungCaps}" var="nhaCungCap">
                                        <option value="${nhaCungCap.id_nhacungcap}">${nhaCungCap.ten_nhacungcap}</option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">Please select a supplier.</div>
                            </div>

                            <div class="form-group col-md-6">

                                <div class="invalid-feedback">Please select a supplier.</div>
                            </div>

                            <div class="form-group col-md-6">
                                <label for="productPrice">Price</label>
                                <input type="number" class="form-control" id="productPrice" name="productPrice" required>
                                <div class="invalid-feedback">Please enter the product price.</div>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="priceIncrease">Increase (%)</label>
                                <select class="form-control" id="priceIncrease" name="priceIncrease" required>
                                    <option value="1.1">10%</option>
                                    <option value="1.2">20%</option>
                                    <option value="1.30">30%</option>
                                    <option value="1.40">40%</option>
                                    <option value="1.50">50%</option>
                                    <option value="1.60">60%</option>
                                    <option value="1.70">70%</option>
                                    <option value="1.80">80%</option>
                                    <option value="1.90">90%</option>
                                </select>
                                <div class="invalid-feedback">Please select an increase percentage.</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productDescription">Description</label>
                            <textarea class="form-control" id="productDescription" name="productDescription" rows="3" required></textarea>
                            <div class="invalid-feedback">Please enter a product description.</div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="productQuantity">Quantity</label>
                                <input type="number" class="form-control" id="productQuantity" name="productQuantity" required>
                                <div class="invalid-feedback">Please enter the product quantity.</div>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="productImage">Image</label>
                                <input type="file" class="form-control-file" id="productImage" name="productImage" required>
                                <div class="invalid-feedback">Please upload a product image.</div>
                            </div>
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
                                var confirmed = confirm("Are you sure you want to add this product?");
                                if (!confirmed) {
                                    event.preventDefault();
                                    return false;
                                }
                                // Show success message
                                alert("Product added successfully!");
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
