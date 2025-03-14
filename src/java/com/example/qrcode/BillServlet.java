package com.example.qrcode;




import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.example.util.DatabaseUtility;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
  
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("booking_id");

        if (bookingId == null || bookingId.isEmpty()) {
            response.sendRedirect("mybookings.jsp?error=InvalidBooking");
            return;
        }

        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "SELECT b.booking_id, u.username, b.pickup_location, b.dropoff_location, " +
                         "b.pickup_date, b.pickup_time, b.payment, v.model " +
                         "FROM bookings b " +
                         "JOIN users u ON b.user_id = u.user_id " +
                         "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                         "WHERE b.booking_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(bookingId));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String qrData = "Mega City Cab\n"
                        + "Booking ID: " + rs.getInt("booking_id") + "\n"
                        + "User: " + rs.getString("username") + "\n"
                        + "Pickup: " + rs.getString("pickup_location") + "\n"
                        + "Dropoff: " + rs.getString("dropoff_location") + "\n"
                        + "Date: " + rs.getDate("pickup_date") + "\n"
                        + "Time: " + rs.getTime("pickup_time") + "\n"
                        + "Vehicle: " + rs.getString("model") + "\n"
                        + "Total Payment: Rs. " + rs.getDouble("payment");

                String qrPath = generateQRCode(qrData, "qr_bill_" + bookingId + ".png");

                request.setAttribute("bookingId", rs.getInt("booking_id"));
                request.setAttribute("username", rs.getString("username"));
                request.setAttribute("pickup", rs.getString("pickup_location"));
                request.setAttribute("dropoff", rs.getString("dropoff_location"));
                request.setAttribute("date", rs.getDate("pickup_date"));
                request.setAttribute("time", rs.getTime("pickup_time"));
                request.setAttribute("vehicle", rs.getString("model"));
                request.setAttribute("payment", rs.getDouble("payment"));
                request.setAttribute("qrImage", qrPath);

                request.getRequestDispatcher("bill.jsp").forward(request, response);
            } else {
                response.sendRedirect("mybookings.jsp?error=BookingNotFound");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("mybookings.jsp?error=DBError");
        }
    }

    private String generateQRCode(String data, String filename) throws IOException {
        int width = 300;
        int height = 300;
        QRCodeWriter qrCodeWriter = new QRCodeWriter();

        try {
            BitMatrix bitMatrix = qrCodeWriter.encode(data, BarcodeFormat.QR_CODE, width, height);
            BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(bitMatrix);

            String qrPath = getServletContext().getRealPath("/") + "qr_codes/" + filename;
            File outputFile = new File(qrPath);
            outputFile.getParentFile().mkdirs();
            ImageIO.write(qrImage, "png", outputFile);

            return "qr_codes/" + filename;
        } catch (WriterException e) {
            e.printStackTrace();
            return null;
        }
    }
}
