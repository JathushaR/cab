package com.booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.example.util.DatabaseUtility;

@WebServlet("/BookCabServlet")
public class BookCabServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp?error=notLoggedIn");
            return;
        }

        String pickup = request.getParameter("pickup");
        String dropoff = request.getParameter("dropoff");
        String pickupDate = request.getParameter("date");
        String pickupTime = request.getParameter("time");
        String passengersStr = request.getParameter("passengers");
        String vehicleIdStr = request.getParameter("vehicleId");
        
        int passengers, vehicleId;
        try {
            passengers = Integer.parseInt(passengersStr);
            vehicleId = Integer.parseInt(vehicleIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("bookcab.jsp?error=invalidNumber");
            return;
        }

        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "INSERT INTO bookings (user_id, pickup_location, dropoff_location, pickup_date, pickup_time, passengers, vehicle_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, pickup);
            ps.setString(3, dropoff);
            ps.setString(4, pickupDate);
            ps.setString(5, pickupTime);
            ps.setInt(6, passengers);
            ps.setInt(7, vehicleId);
            ps.executeUpdate();
            response.sendRedirect("mybookings.jsp?success=true");
        } catch (SQLException e) {
            response.sendRedirect("bookcab.jsp?error=bookingFailed");
        }
    }
}
