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

@WebServlet("/deleteVehicle")
public class deleteVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));

        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "DELETE FROM vehicles WHERE vehicle_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, vehicleId);
            ps.executeUpdate();
            ps.close();
            response.sendRedirect("vehicles.jsp?success=vehicleDeleted");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("vehicles.jsp?error=dbError");
        }
    }
}
