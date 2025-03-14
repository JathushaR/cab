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

@WebServlet("/UpdateVehicleStatusServlet")
public class UpdateVehicleStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));
        String status = request.getParameter("status");

        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "UPDATE vehicles SET status = ? WHERE vehicle_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, vehicleId);
            ps.executeUpdate();
            ps.close();
            response.sendRedirect("vehicles.jsp?success=statusUpdated");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("vehicles.jsp?error=dbError");
        }
    }
}
