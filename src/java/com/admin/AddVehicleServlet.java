package com.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.util.DatabaseUtility;

@WebServlet("/AddVehicleServlet")
public class AddVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vehicleType = request.getParameter("vehicleType");
        String model = request.getParameter("model");
        String manufacturer = request.getParameter("manufacturer");
        String registrationNumber = request.getParameter("registrationNumber");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String color = request.getParameter("color");
        String status = request.getParameter("status");
        String maintenanceDate = request.getParameter("maintenanceDate");
        String currentLocation = request.getParameter("currentLocation");

        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "INSERT INTO vehicles (vehicle_type, model, manufacturer, registration_number, capacity, color, status, last_maintenance_date, current_location) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, vehicleType);
            ps.setString(2, model);
            ps.setString(3, manufacturer);
            ps.setString(4, registrationNumber);
            ps.setInt(5, capacity);
            ps.setString(6, color);
            ps.setString(7, status);
            ps.setString(8, maintenanceDate);
            ps.setString(9, currentLocation);

            ps.executeUpdate();
            ps.close();
            response.sendRedirect("vehicles.jsp?success=vehicleAdded");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("addVehicle.jsp?error=dbError");
        }
    }
}
