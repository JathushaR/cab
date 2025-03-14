package com.example.qrcode;



import java.io.IOException;
import java.io.OutputStream;
import java.awt.image.BufferedImage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.qrcode.QRCodeWriter;

@WebServlet("/GenerateQRCodeServlet")
public class GenerateQRCode extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String qrData = request.getParameter("data");

        if (qrData == null || qrData.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid QR Code data");
            return;
        }

        try {
            // Generate QR Code
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(qrData, BarcodeFormat.QR_CODE, 200, 200);

            // Set response type to image
            response.setContentType("image/png");
            OutputStream outputStream = response.getOutputStream();
            BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(bitMatrix);
            javax.imageio.ImageIO.write(qrImage, "PNG", outputStream);
            outputStream.close();
        } catch (WriterException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating QR Code");
        }
    }
}
