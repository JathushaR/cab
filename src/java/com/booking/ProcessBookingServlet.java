/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.example.util.DatabaseUtility;

@WebServlet("/ProcessBookingServlet")
public class ProcessBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Handle GET requests: used to forward to assignDriver.jsp for accepting a booking.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));
        
        if("accept".equals(action)) {
            request.setAttribute("booking_id", bookingId);
            request.getRequestDispatcher("assignDriver.jsp").forward(request, response);
        } else if("cancel".equals(action)) {
            processCancellation(bookingId);
            response.sendRedirect("adminbookings.jsp?msg=BookingCanceled");
        }
    }
    
    // Handle POST requests: used to process acceptance with driver assignment and payment details.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));
        
        if("accept".equals(action)) {
            int driverId = Integer.parseInt(request.getParameter("driver_id"));
            double payment = Double.parseDouble(request.getParameter("payment"));
            processAcceptance(bookingId, driverId, payment);
            response.sendRedirect("adminbookings.jsp?msg=BookingAccepted");
        } else if("cancel".equals(action)) {
            processCancellation(bookingId);
            response.sendRedirect("adminbookings.jsp?msg=BookingCanceled");
        }
    }
    
    private void processAcceptance(int bookingId, int driverId, double payment) {
        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "UPDATE bookings SET booking_status = 'Accepted', driver_id = ?, payment = ? WHERE booking_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, driverId);
            ps.setDouble(2, payment);
            ps.setInt(3, bookingId);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private void processCancellation(int bookingId) {
        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "UPDATE bookings SET booking_status = 'Canceled' WHERE booking_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookingId);
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
