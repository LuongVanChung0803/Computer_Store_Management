
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
                    <h2 class="mb-4 text-center">Update Product</h2>
                    <form id="updateForm" action="update_product" method="post" class="needs-validation" novalidate>
                        <div class="form-group">
                            <label for="productName">Product Name:</label>
                            <input type="text" class="form-control" id="productName" name="productName" value="${product.ten_sanpham}" required>
                            <div class="invalid-feedback">Please enter the product name.</div>
                        </div>
                            <div class="form-group" hidden="hidden">
                            <label for="productBrand">Brand:</label>
                            <input type="text" class="form-control" id="productBrand" name="productBrand" value="${product.id_nhacungcap}">
                        </div>
                        <div class="form-group">
                            <label for="productPrice">Price:</label>
                            <input type="number" class="form-control" id="productPrice" name="productPrice" value="${product.gia}" required>
                            <div class="invalid-feedback">Please enter the product price.</div>
                        </div > 
                        <div class="form-group" hidden="hidden" >
                            <label for="gia_ban">Price:</label>
                            <input type="number" class="form-control" id="gia_ban" name="gia_ban" value="${product.gia_ban}" required>
                            <div class="invalid-feedback">Please enter the product price.</div>
                        </div> 
                        <div class="form-group">
                            <label for="productDescription">Description:</label>
                            <textarea class="form-control" id="productDescription" name="productDescription" rows="3" required>${product.mo_ta}</textarea>
                            <div class="invalid-feedback">Please enter a product description.</div>
                        </div>
                        <div class="form-group">
                            <label for="productQuantity">Quantity:</label>
                            <input type="number" class="form-control" id="productQuantity" name="productQuantity" value="${product.so_luong}" required>
                            <div class="invalid-feedback">Please enter the product quantity.</div>
                        </div>
                        <div class="form-group">
                            <label for="productImage">Current Image:</label><br>
                            <img src="./assets/image_product/${product.link_anh}" alt="Product Image" class="img-thumbnail mb-2" style="max-width: 200px;">
                            <input hidden="hidden" type="text" class="form-control-file" id="productImage" value="${product.link_anh}" name="productImage" >
                            <small class="form-text text-muted">Leave blank if you don't want to change the image.</small>
                        </div>
                        <input type="hidden" name="productId" value="${product.id_sanpham}">
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
                            if (confirm("Are you sure you want to update this product?")) {
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
