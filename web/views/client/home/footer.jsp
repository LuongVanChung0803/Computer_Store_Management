<%-- 
    Document   : footer
    Created on : Oct 30, 2024, 11:27:07 AM
    Author     : hc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<footer class="footer">
    <div class="container">
        <div class="row">
            <!-- Left Section: Shipping and Policies -->
            <div class="col-md-3 mb-4">
                <div class="mb-3">
                    <p><strong>CHÍNH SÁCH GIAO HÀNG</strong><br>Nhận hàng và thanh toán tại nhà</p>
                </div>
                <div class="mb-3">
                    <p><strong>ĐỔI TRẢ DỄ DÀNG</strong><br>Đổi mới trong 7 ngày đầu</p>
                </div>
                <div class="mb-3">
                    <p><strong>THANH TOÁN TIỆN LỢI</strong><br>Trả tiền mặt, CK, trả góp 0%</p>
                </div>
                <div class="mb-3">
                    <p><strong>HỖ TRỢ NHIỆT TÌNH</strong><br>Tư vấn, giải đáp mọi thắc mắc</p>
                </div>
            </div>

            <!-- Center Section: Links and Social Media -->
            <div class="col-md-6 mb-4">
                <div class="row">
                    <!-- Company Info -->
                    <div class="col-md-4">
                        <h6 class="section-title">GIỚI THIỆU</h6>
                        <ul class="list-unstyled">
                            <li><a href="#">Giới thiệu về công ty</a></li>
                            <li><a href="#">Thông tin liên hệ</a></li>
                            <li><a href="#">Thông tin tuyển dụng</a></li>
                            <li><a href="#">Tin tức</a></li>
                        </ul>
                        <div class="social-icons mt-2">
                            <a href="#"><i class="fab fa-facebook"></i></a>
                            <a href="#"><i class="fab fa-youtube"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                        </div>
                    </div>

                    <!-- Customer Support -->
                    <div class="col-md-4">
                        <h6 class="section-title">HỖ TRỢ KHÁCH HÀNG</h6>
                        <ul class="list-unstyled">
                            <li><a href="#">Hướng dẫn mua hàng trực tuyến</a></li>
                            <li><a href="#">Hướng dẫn thanh toán</a></li>
                            <li><a href="#">Hướng dẫn mua hàng trả góp</a></li>
                            <li><a href="#">Tổng đài hỗ trợ trực tuyến</a></li>
                            <li><a href="#">Thông tin tài khoản ngân hàng</a></li>
                            <li><a href="#">Góp ý khiếu nại</a></li>
                        </ul>
                    </div>

                    <!-- General Policies -->
                    <div class="col-md-4">
                        <h6 class="section-title">CHÍNH SÁCH CHUNG</h6>
                        <ul class="list-unstyled">
                            <li><a href="#">Chính sách vận chuyển</a></li>
                            <li><a href="#">Chính sách bảo hành</a></li>
                            <li><a href="#">Chính sách đổi trả & hoàn tiền</a></li>
                            <li><a href="#">Chính sách cho doanh nghiệp</a></li>
                            <li><a href="#">Bảo mật thông tin khách hàng</a></li>
                            <li><a href="#">Tạo mức trả góp lãi suất 0%</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Right Section: Payment Methods and Support -->
            <div class="col-md-3">
                <h6 class="section-title">HÌNH THỨC THANH TOÁN</h6>
                <div class="payment-methods">
                    <img style="width: 220px ;height: 90px" src="./assets/img/pay.webp" alt="Visa">
                </div>
                
                <h6 class="section-title">ĐƯỢC CHỨNG NHẬN BỞI</h6>
                <div class="bct">
                    <img style="width: 220px ;height: 90px" src="./assets/img/logoSaleNoti.png" alt="BCT">
                </div>

            </div>
        </div>
    </div>
</footer>
       <script>
            function confirmAddToCart() {
                // Show a confirmation dialog
                const isConfirmed = confirm("Product added to cart successfully! Press OK to continue shopping.");
                // Proceed with form submission if OK is clicked
                return isConfirmed;
            }
            function showResults() {
                const input = document.querySelector('.search-input');
                const results = document.querySelector('.search-results');
                if (input.value.length > 0) {
                    results.style.display = 'block';
                } else {
                    results.style.display = 'none';
                }
            }
        </script>
                       

