/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.security.SecureRandom;

public class OTPUtils {

    // Tạo OTP ngẫu nhiên
    public static String generateOTP() {
        int length = 6; // Độ dài OTP (số chữ số)
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder();

        // Tạo OTP gồm 6 chữ số ngẫu nhiên
        for (int i = 0; i < length; i++) {
            otp.append(random.nextInt(10)); // Chọn một số ngẫu nhiên từ 0 đến 9
        }

        return otp.toString();
    }
}
