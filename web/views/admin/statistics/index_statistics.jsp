<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.css" rel="stylesheet">
        <link href="./assets/css/admin.css" rel="stylesheet">
    </head>
    <body>
        <script>
            // JavaScript to get the message from the URL and display it (if any)
            window.onload = function () {
            var urlParams = new URLSearchParams(window.location.search);
            var message = urlParams.get('message');
            if (message) {
            alert(decodeURIComponent(message));
            }
            };
        </script>
        <%@ include file="/views/admin/navbar.jsp" %>
        <div class="d-flex">
            <%@ include file="/views/admin/menu.jsp" %>
            <div class="content p-4">
                <!-- Bootstrap Navbar -->
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="margin-bottom: 10px">
                 <%@ include file="/views/admin/statistics/nav.jsp" %>
                </nav>
                <!-- Dashboard metrics -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card text-white bg-primary mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Tổng Tài Khoản</h5>
                                <p class="card-text">${totalUsers}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-success mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Tổng Doanh Thu </h5>
                                
                                <p class="card-text"><fmt:formatNumber value="${totalSales}" type="currency" currencySymbol="" pattern="#,##0" /> VND</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-warning mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Đơn Hàng Mới</h5>
                                <p class="card-text">${newOrders}</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-danger mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Đơn Hàng Bị Hủy</h5>
                                <p class="card-text">${pendingIssues}</p> 
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-warning mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Tổng Sản Phẩm</h5>
                                <p class="card-text">${totalProductss}</p> 
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-warning mb-3">
                            <div class="card-body">
                                <h5 class="card-title">Số Đơn Hàng Giao Thành Công</h5>
                                <p class="card-text">${receivedOders}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container mt-5">
            <div class="row">
                <!-- Cột cho biểu đồ thứ nhất -->
                <div class="col-md-6">
                    <div style="width: 100%; height: 300px;">
                        <h1 class="text-center">Đơn hàng hàng tháng</h1>
                        <canvas id="monthlyOrdersChart"></canvas>
                    </div>
                </div>

                <!-- Cột cho biểu đồ thứ hai -->
                <div class="col-md-6">
                    <div style="width: 70%; height: 200px;">
                        <canvas id="myPieChart"></canvas>
                    </div>
                </div>

            </div>
        </div>



        <!-- Bootstrap JS and dependencies -->
        <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>


        <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
        <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>
        <!-- Chart.js JS -->
        <script src="./assets/js/chart.min.js"></script>

        <script>
            $(document).ready(function () {
            var ctx = document.getElementById('monthlyOrdersChart').getContext('2d');
            var monthlyOrdersChart = new Chart(ctx, {
            type: 'bar',
                    data: {
                    labels: [<c:forEach var="entry" items="${monthlyOrders}">${entry.key}, </c:forEach>],
                            datasets: [{
                            label: 'Total Orders',
                                    data: [<c:forEach var="entry" items="${monthlyOrders}">${entry.value}, </c:forEach>],
                                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                    borderColor: 'rgba(54, 162, 235, 1)',
                                    borderWidth: 1
                            }]
                    },
                    options: {
                    scales: {
                    y: {
                    beginAtZero: true
                    }
                    }
                    }
            });
            });
            </script>
            <script>
                // Dữ liệu từ servlet
                var pieData = {
                labels: [
            <% // Loop through orderStatusCounts keys to generate labels %>
            <% for (String status : ((Map<String, Integer>) request.getAttribute("orderStatusCounts")).keySet()) { %>
                '<%= status %>',
            <% } %>
                ],
                        datasets: [{
                        label: 'Trạng thái đơn hàng',
                                data: [
            <% // Loop through orderStatusCounts values to generate data points %>
            <% for (Integer count : ((Map<String, Integer>) request.getAttribute("orderStatusCounts")).values()) { %>
            <%= count %>,
            <% } %>
                                ],
                                backgroundColor: [
                                        'rgba(255, 99, 132, 0.8)',
                                        'rgba(54, 162, 235, 0.8)',
                                        'rgba(255, 205, 86, 0.8)',
                                        'rgba(75, 192, 192, 0.8)'
                                ],
                                borderWidth: 1
                        }]
                };
                // Lấy context của canvas và vẽ biểu đồ tròn
                var ctx = document.getElementById('myPieChart').getContext('2d');
                var myPieChart = new Chart(ctx, {
                type: 'pie',
                        data: pieData,
                        options: {
                        responsive: true,
                                plugins: {
                                legend: {
                                position: 'top',
                                },
                                        tooltip: {
                                        callbacks: {
                                        label: function(tooltipItem) {
                                        return tooltipItem.label + ': ' + tooltipItem.formattedValue + ' đơn hàng';
                                        }
                                        }
                                        }
                                }
                        }
                });
        </script>

    </body>
</html>
