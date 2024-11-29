<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật đơn hàng </title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./assets/bootstrap-4.5.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/fontawesome-free-6.5.2-web/css/all.min.css">
        <link href="./assets/css/admin.css" rel="stylesheet">
        <link href="./assets/css/update_oder.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/views/admin/navbar.jsp" %>
    <div class="d-flex">
        <%@ include file="/views/admin/menu.jsp" %>
            <div class="content" style="width: 1000px ;padding-left: 300px ;margin-bottom:150px">

                <div class="container">
                    <div class="alert alert-success mt-4" id="successAlert">
                        Order updated successfully.
                    </div>
                    <h2 class="my-4">Xử lý đơn hàng</h2>
                    <form id="updateForm" action="update_oder" method="post">
                        <div class="form-group mb-3">
                            <label for="id_donhang">Mã Đơn Hàng:</label>
                            <input type="text" class="form-control" id="id_donhang" name="id_donhang" value="${dhss.id_donhang}" readonly >
                        </div>

                        <div class="form-group mb-3" hidden="hidden">
                            <label for="id_khachhang">Mã Khách Hàng:</label>
                            <input type="text" class="form-control" id="id_khachhang" name="id_khachhang" value="${dhss.id_khachhang}" readonly>
                        </div>

                        <div class="form-group mb-3" hidden="hidden">
                            <label for="id_sanpham">Mã Sản Phẩm:</label>
                            <input type="text" class="form-control" id="id_sanpham" name="id_sanpham" value="${dhss.id_sanpham}" readonly>
                        </div>

                        <div class="form-group mb-3" hidden="hidden">
                            <label for="so_luong">Số Lượng:</label>
                            <input type="number" class="form-control" id="so_luong" name="so_luong" value="${dhss.so_luong}" readonly>
                        </div>

                        <div class="form-group mb-3">
                            <label for="ngay_dat">Ngày Đặt:</label>
                            <input type="date" class="form-control" id="ngay_dat" name="ngay_dat" value="${dhss.ngay_dat}" readonly>
                        </div>

                        <div class="form-group mb-3">
                            <label for="trang_thai">Tình Trạng</label>
                            <select class="form-control" id="trang_thai" name="trang_thai" required>
                                <option value="dang_xu_ly" ${dhss.trang_thai == 'dang_xu_ly' ? 'selected' : ''}>Đang xử lý</option>
                                <option value="da_giao" ${dhss.trang_thai == 'da_giao' ? 'selected' : ''}>Đã giao bên vận chuyển</option>
                                <option value="da_nhan" ${dhss.trang_thai == 'da_nhan' ? 'selected' : ''}> Khách Hàng Đã nhận</option>
                                <option value="huy" ${dhss.trang_thai == 'huy' ? 'selected' : ''}>Hủy</option>
                            </select>
                        </div>

                        <div class="form-group mb-3">
                            <label for="hinh_thuc_thanh_toan">Phương Thức Thanh Toán:</label>
                            <input type="text" class="form-control" id="hinh_thuc_thanh_toan" name="hinh_thuc_thanh_toan" value="${dhss.hinh_thuc_thanh_toan}" readonly>
                        </div>

                        <div class="form-group mb-3"hidden="hidden">
                            <label for="tong_tien">Total Amount:</label>
                            <input type="number" class="form-control" id="tong_tien" name="tong_tien" value="${dhss.tong_tien}" readonly>
                        </div>

                        <button type="button" class="btn btn-primary" onclick="confirmUpdate();">Xử Lý</button>
                        <a href="loadoder" class="btn btn-secondary">Hủy</a>
                    </form>
                </div>

            </div>
        </div> 

        <!-- Bootstrap JS and dependencies -->
        <script src="./assets/js/jquery-3.5.1.slim.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>
            <script src="./assets/bootstrap-4.5.3-dist/js/bootstrap.min.js"></script>
            <script src="./assets/fontawesome-free-6.5.2-web/js/all.min.js" crossorigin="anonymous"></script>

        <script>
            // Hàm xử lý xác nhận cập nhật
            function confirmUpdate() {
                // Hiển thị hộp thoại Yes/No
                let confirmation = confirm("Bạn có chắc chắn muốn cập nhật đơn hàng này không?");

                // Nếu người dùng chọn Yes
                if (confirmation) {
                    // Gọi lại việc submit form
                    document.getElementById("updateForm").submit();
                } else {
                    // Nếu chọn No, không làm gì cả (giữ nguyên form)
                    return false;
                }
            }
        </script>

    </body>
</html>
