<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <link href="./assets/css/cart_oder.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Merriweather&display=swap" rel="stylesheet">
        <style>
            .spinner {
                border: 4px solid #f3f3f3; /* Màu viền nhạt */
                border-top: 4px solid #3498db; /* Màu viền trên */
                border-radius: 50%;
                width: 70px;
                height: 70px;
                animation: spin 1s linear infinite; /* Hiệu ứng xoay */
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            @keyframes spin {
                from {
                    transform: rotate(0deg);
                }
                to {
                    transform: rotate(360deg);
                }
            }

        </style>
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
        <!-- top navbar -->
        <!-- navbar -->

        <div class="container mt-4">
            <h2 class="my-4">Giỏ Hàng</h2>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">STT</th>
                            <th scope="col">Sản Phẩm</th>
                            <th hidden scope="col">Tên Sản Phẩm</th>
                            <th scope="col">Đơn Giá</th>
                            <th scope="col" style="width: 100px" >Số Lượng</th>
                            <th scope="col" style="width: 200px" >Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cartItems}" var="item" varStatus="loop">
                            <tr class="cart-item">
                                <td><strong>${loop.index + 1}</strong></td>
                                <td><img src="./assets/image_product/${item.link_anh}" alt="${item.id_sanpham}" class="img-fluid"></td>
                                <td hidden>${item.id_sanpham}</td>
                                <td><fmt:formatNumber value="${item.gia_ban}" type="currency" currencySymbol="VND" pattern="#,##0" /> VND</td>
                                <td>
                                    <input type="number" class="form-control quantity-input" value="${item.so_luong}" min="1" data-price="${item.gia_ban}" >
                                    <input type="hidden" name="idNguoiDung" value="${sessionScope.user.id_nguoidung}">
                                </td>
                                <td>
                                    <div class="text-end" style="width: 120px">
                                        <a href="delete_Cart?id=${item.id_cart}&id_nguoidung=${sessionScope.user.id_nguoidung}" class="btn btn-outline-secondary btn-sm" onclick="return confirmDelete()">Xóa</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div colspan="4" class="text-end cart-total">
                    Tổng Cộng: <span id="total-price">0VND</span><br>
                </div>
                <c:if test="${empty cartItems}">
                    <p> giỏ hàng của bạn chưa có gì !.</p>
                </c:if>
            </div>
            <% 
              Boolean customerExists = (Boolean) session.getAttribute("customerExists");
                    if (customerExists == null) {
                        customerExists = false;
             }
            %>
            <div class="text-end mt-4" style="margin-bottom: 10px ">
                <a href="loadhome" class="btn btn-outline-secondary me-2">Đóng</a>
                <button id="checkoutBtn" class="btn btn-primary">Thanh Toán</button>
            </div>
        </div>

        <!-- Customer Information Modal -->
        <div id="customerModal" class="modal" style="z-index: 1002">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h4>Thông Tin Đơn Đặt Hàng Và Thanh Toán</h4>
                <form action="ThanhToanServlet" id="payment-form" method="post">
                    <!--                <form id="orderForm" action="ThanhToanServlet2" method="post">-->
                    <%
                        if (!customerExists) {
                    %>

                    <table class="table table-bordered">

                        <thead class="table-light">
                            <tr>
                                <th scope="col">STT</th>
                                <th scope="col">Sản Phẩm</th>
                                <th hidden scope="col">Tên Sản Phẩm</th>
                                <th scope="col">Đơn Giá</th>
                                <th scope="col" style="width: 100px" >Số Lượng</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach items="${cartItems}" var="item" varStatus="loop">
                                <tr class="cart-item">
                                    <td><strong>${loop.index + 1}</strong></td>
                                    <td><img style="width: 50px; height: 35px" src="./assets/image_product/${item.link_anh}" alt="${item.id_sanpham}" class="img-fluid"></td>
                                    <td hidden>${item.id_sanpham}</td>
                                    <td><fmt:formatNumber value="${item.gia_ban}" type="currency" currencySymbol="VND" pattern="#,##0" /> VND</td>
                                    <td>
                                        <input type="number" class="form-control quantity-input" value="${item.so_luong}" min="1" >
                                        <input type="hidden" name="idNguoiDung" value="${sessionScope.user.id_nguoidung}">
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>

                    </table>
                    <%
        // Lấy tổng tiền từ session
        Double totalAmount = (Double) session.getAttribute("totalAmount");
        if (totalAmount == null) {
            totalAmount = 0.0; // Nếu không có giá trị, đặt mặc định là 0
        }
                    %>

<!--                    <p><strong>Tổng tiền:</strong> <%= String.format("%,.2f", totalAmount) %> VNĐ</p>-->
                    <!--                    <div colspan="4" class="text-end cart-total">
                                            Tổng Cộng: <span><%= String.format("%,.2f", totalAmount) %> VNĐ</span><br>
                                        </div>-->
                    <!--                 Thông tin khách -->
                    <div class="mb-3"><label for="ho_ten" class="form-label">Tên Khách Hàng</label>
                        <input type="text" class="form-control" id="ho_ten" name="ho_ten" value="${khachHang.ho_ten}" required>
                    </div>
                    <div class="mb-3"><label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="${user.email}" readonly>
                    </div>
                    <div class="mb-3"><label for="so_dien_thoai" class="form-label">Số Điện Thoại</label>
                        <input type="tel" class="form-control" id="so_dien_thoai" name="so_dien_thoai" value="${khachHang.so_dien_thoai}" required>
                    </div>
                    <div class="mb-3"><label for="dia_chi" class="form-label">Địa Chỉ</label>
                        <input type="text" class="form-control" id="dia_chi" name="dia_chi" value="${khachHang.dia_chi}" required>
                    </div>
                    <% 
                        } 
                    %>
                    <h6>Chọn phương thức thanh toán</h6>
                    <div class="form-group">
                        <input type="radio" name="hinh_thuc_thanh_toan" value="Thanh toán khi nhận hàng">
                        <label for="hinh_thuc_thanh_toan">Thanh toán tiền mặt</label><br>

                        <input type="radio" name="hinh_thuc_thanh_toan" value="Thanh toán bằng vnpay" checked>
                        <label for="hinh_thuc_thanh_toan">Cổng thanh toán VNPAYQR</label><br>

                    </div>
                    <input type="hidden" id="id_nguoidung" value="${sessionScope.user.id_nguoidung}" name="id_nguoidung">
                    <input type="hidden" id="customerExists" value="<%= customerExists %>" name="customerExists">

                    <button type="submit"id="btnThanhToan" class="btn btn-primary" >Thanh toán</button>
                    <div id="loadingSpinner" class="spinner" style="display: none;"></div>
                </form>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="/views/client/home/footer.jsp" %>
        <!-- Footer -->

        <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
        <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
        <script src="./assets/bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                            document.addEventListener('DOMContentLoaded', function () {
                                                var quantityInputs = document.querySelectorAll('.quantity-input');
                                                var totalElement = document.getElementById('total-price');
                                                var checkoutBtn = document.getElementById('checkoutBtn'); // Nút thanh toán

                                                // Tính tổng tiền ban đầu
                                                calculateTotal();

                                                // Bắt sự kiện khi thay đổi số lượng
                                                quantityInputs.forEach(function (input) {
                                                    input.addEventListener('input', function () {
                                                        calculateTotal();
                                                    });
                                                });

                                                // Hàm tính tổng tiền
                                                function calculateTotal() {
                                                    var total = 0;
                                                    quantityInputs.forEach(function (input) {
                                                        var price = parseFloat(input.getAttribute('data-price')); // Lấy giá của sản phẩm từ thuộc tính data-price
                                                        var quantity = parseInt(input.value); // Lấy số lượng từ input

                                                        // Kiểm tra nếu giá và số lượng hợp lệ
                                                        if (!isNaN(price) && !isNaN(quantity)) {
                                                            total += price * quantity; // Cộng tổng tiền
                                                        }
                                                    });

                                                    // Định dạng tổng tiền với dấu phân cách nghìn và hiển thị VND
                                                    totalElement.textContent = formatCurrency(total) + ' VND';
                                                    // Kiểm tra nếu tổng tiền = 0 thì vô hiệu hóa nút thanh toán
                                                    if (total === 0) {
                                                        checkoutBtn.disabled = true; // Vô hiệu hóa nút
                                                    } else {
                                                        checkoutBtn.disabled = false; // Kích hoạt nút
                                                    }
                                                }

                                                // Hàm định dạng số tiền với dấu phân cách nghìn
                                                function formatCurrency(amount) {
                                                    return amount.toLocaleString('vi-VN'); // Định dạng theo chuẩn Việt Nam
                                                }

                                                // Modal handling
                                                var modal = document.getElementById('customerModal');
                                                var btn = document.getElementById('checkoutBtn');
                                                var span = document.getElementsByClassName('close')[0];

                                                btn.onclick = function () {
                                                    modal.style.display = 'block';
                                                }

                                                span.onclick = function () {
                                                    modal.style.display = 'none';
                                                }

                                                window.onclick = function (event) {
                                                    if (event.target == modal) {
                                                        modal.style.display = 'none';
                                                    }
                                                }
                                            });


        </script>
        <script>
            function confirmDelete() {
                return confirm("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?");

            }

        </script>
<!--        <script>
            document.getElementById("btnThanhToan").addEventListener("click", function (e) {
                e.preventDefault(); // Ngăn chặn hành động mặc định của nút (submit)

                // Hiển thị spinner
                const spinner = document.getElementById("loadingSpinner");
                spinner.style.display = "block";

                // Ẩn spinner sau 2 giây
                setTimeout(() => {
                    spinner.style.display = "none";
                }, 2000);
            });



        </script>-->
        <script>
        </script>
    </body>
</html>
