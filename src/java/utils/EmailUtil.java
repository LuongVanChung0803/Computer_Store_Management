package utils;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import model.CartItem;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class EmailUtil {

    // Phương thức gửi OTP đến email
    public static boolean sendOTPEmail(String toEmail, String otp) {
        String from = "chungvan704@gmail.com"; // Email người gửi
        String host = "smtp.gmail.com"; // SMTP host của Gmail
        final String username = "chungvan704@gmail.com"; // Tài khoản Gmail của bạn
        final String appPassword = "bsao pvpe rbrk jdvt"; // App Password mới tạo (không phải mật khẩu tài khoản Gmail)

        // Thiết lập các thuộc tính SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        // Tạo session
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, appPassword);
            }
        });

        try {
            // Tạo email

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã OTP cho việc khôi phục mật khẩu");
            message.setText("Mã OTP của bạn để thay đổi mật khẩu là: " + otp);

            // Gửi email
            Transport.send(message);
            System.out.println("Email đã được gửi thành công!");
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("Gửi email thất bại. Vui lòng kiểm tra lại cấu hình.");
            return false;
        }
    }

    // Phương thức gửi mật khẩu mới sau khi người dùng thay đổi thành công
    public static boolean sendPasswordEmail(String toEmail, String password) {
        String from = "chungvan704@gmail.com";
        String host = "smtp.gmail.com";
        final String username = "chungvan704@gmail.com";
        final String appPassword = "bsao pvpe rbrk jdvt";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, appPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mật khẩu mới của bạn");
            message.setText("Mật khẩu mới của bạn là: " + password);

            Transport.send(message);
            System.out.println("Email đã được gửi thành công!");
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("Gửi email thất bại. Vui lòng kiểm tra lại cấu hình.");
            return false;
        }
    }

    // Phương thức gửi email xác nhận đơn hàng
    public static boolean sendOrder_Vnpay_ConfirmationEmail(String email, String ho_ten, List<CartItem> cartItems) {
        String host = "smtp.gmail.com"; // Sử dụng SMTP host của bạn
        final String user = "chungvan704@gmail.com"; // Email của bạn
        final String password = "bsao pvpe rbrk jdvt"; // Mật khẩu email của bạn

        // Cấu hình các thuộc tính cho email
        Properties properties = System.getProperties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Lấy đối tượng Session
        Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Xác nhận đơn hàng", "UTF-8");  // Mã hóa tiêu đề theo UTF-8
            // Lấy thời gian hiện tại
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatterDateTime = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            String formattedDateTime = now.format(formatterDateTime);
            // Tạo nội dung email
            StringBuilder emailContent = new StringBuilder();

// CSS cho email
            emailContent.append("<style>")
                    .append("body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }")
                    .append("h2 { color: #2c3e50; }")
                    .append("p { margin: 0 0 10px; }")
                    .append("table { width: 100%; border-collapse: collapse; margin-top: 20px; }")
//                    .append("th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }")
                    .append("th, td { border: 2px solid #eee; padding: 8px; text-align: left; }") // Viền nhỏ hơn
                    .append("th { background-color: #f4f4f4; color: #2c3e50; }")
                    .append("tr:nth-child(even) { background-color: #f9f9f9; }")
                    .append(".total { font-weight: bold; color: #e74c3c; font-size: 16px; }")
                    .append("</style>");

// Nội dung email
            emailContent.append("<body>");
            emailContent.append("<h2>Chào ").append(ho_ten).append(",</h2>");
            emailContent.append("<p>Cảm ơn bạn đã đặt hàng. Dưới đây là chi tiết đơn hàng của bạn:</p>");
            emailContent.append("<table border='1'>")
                    .append("<tr><th>Mã Sản phẩm</th><th>Số lượng</th><th>Giá</th></tr>");

            DecimalFormat formatter = new DecimalFormat("#,###"); // Định dạng giá
            for (CartItem item : cartItems) {
                emailContent.append("<tr>")
                        .append("<td>").append(item.getId_sanpham()).append("</td>")
                        .append("<td>").append(item.getSo_luong()).append("</td>")
                        .append("<td>").append(formatter.format(item.getGia_ban())).append(" VND</td>")
                        .append("</tr>");
            }
            emailContent.append("</table>");
            emailContent.append("<p class='total'>Tổng giá trị: ")
                    .append(formatter.format(calculateTotal(cartItems))).append(" VND</p>");
            emailContent.append("<p>Chúng tôi sẽ xử lý đơn hàng của bạn sớm.</p>");
            emailContent.append("<p>Đơn hàng đã thanh toán thành công qua : <strong>VNPAY</strong></p>");
            emailContent.append("<p>Thời gian thanh toán: <strong>").append(formattedDateTime).append("</strong></p>");
            emailContent.append("<p>Cảm ơn bạn đã mua sắm với chúng tôi!</p>");
            emailContent.append("</body>");

            // Cài đặt nội dung email với mã hóa UTF-8
            message.setContent(emailContent.toString(), "text/html; charset=UTF-8");

            // Gửi email
            Transport.send(message);
            System.out.println("Email đã được gửi thành công!");
            return true;  // Return true if email was sent successfully
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("Gửi email thất bại. Vui lòng kiểm tra lại cấu hình.");
            return false; // Return false if there was an error
        }
    }
    // Phương thức gửi email xác nhận đơn hàng
    public static boolean sendOrder_Cash_ConfirmationEmail(String email, String ho_ten, List<CartItem> cartItems) {
        String host = "smtp.gmail.com"; // Sử dụng SMTP host của bạn
        final String user = "chungvan704@gmail.com"; // Email của bạn
        final String password = "bsao pvpe rbrk jdvt"; // Mật khẩu email của bạn

        // Cấu hình các thuộc tính cho email
        Properties properties = System.getProperties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Lấy đối tượng Session
        Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Xác nhận đơn hàng", "UTF-8");  // Mã hóa tiêu đề theo UTF-8
            // Lấy thời gian hiện tại
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter formatterDateTime = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            String formattedDateTime = now.format(formatterDateTime);
            // Tạo nội dung email
            StringBuilder emailContent = new StringBuilder();

// CSS cho email
            emailContent.append("<style>")
                    .append("body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }")
                    .append("h2 { color: #2c3e50; }")
                    .append("p { margin: 0 0 10px; }")
                    .append("table { width: 100%; border-collapse: collapse; margin-top: 20px; }")
                    .append("th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }")
                    .append("th { background-color: #f4f4f4; color: #2c3e50; }")
                    .append("tr:nth-child(even) { background-color: #f9f9f9; }")
                    .append(".total { font-weight: bold; color: #e74c3c; font-size: 16px; }")
                    .append("</style>");

// Nội dung email
            emailContent.append("<body>");
            emailContent.append("<h2>Chào ").append(ho_ten).append(",</h2>");
            emailContent.append("<p>Cảm ơn bạn đã đặt hàng. Dưới đây là chi tiết đơn hàng của bạn:</p>");
            emailContent.append("<table border='1' >")
                    .append("<tr><th>Mã Sản phẩm</th><th>Số lượng</th><th>Giá</th></tr>");

            DecimalFormat formatter = new DecimalFormat("#,###"); // Định dạng giá
            for (CartItem item : cartItems) {
                emailContent.append("<tr>")
                        .append("<td>").append(item.getId_sanpham()).append("</td>")
                        .append("<td>").append(item.getSo_luong()).append("</td>")
                        .append("<td>").append(formatter.format(item.getGia_ban())).append(" VND</td>")
                        .append("</tr>");
            }
            emailContent.append("</table>");
            emailContent.append("<p class='total'>Tổng giá trị: ")
                    .append(formatter.format(calculateTotal(cartItems))).append(" VND</p>");
            emailContent.append("<p>Chúng tôi sẽ xử lý đơn hàng của bạn sớm.</p>");
            emailContent.append("<p>Thời gian đặt hàng: <strong>").append(formattedDateTime).append("</strong></p>");
            emailContent.append("<p>Phương thức : <strong>Thanh Toán Khi Nhận Hàng</strong></p>");
            
            emailContent.append("<p>Cảm ơn bạn đã mua sắm với chúng tôi!</p>");
            emailContent.append("</body>");

            // Cài đặt nội dung email với mã hóa UTF-8
            message.setContent(emailContent.toString(), "text/html; charset=UTF-8");

            // Gửi email
            Transport.send(message);
            System.out.println("Email đã được gửi thành công!");
            return true;  // Return true if email was sent successfully
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("Gửi email thất bại. Vui lòng kiểm tra lại cấu hình.");
            return false; // Return false if there was an error
        }
    }

// Calculate total price
    private static double calculateTotal(List<CartItem> cartItems) {
        double total = 0;
        for (CartItem item : cartItems) {
            total += item.getGia_ban() * item.getSo_luong();
        }
        return total;
    }

}
