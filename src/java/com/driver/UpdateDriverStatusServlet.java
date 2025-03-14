package com.driver;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.example.util.DatabaseUtility;

@WebServlet("/UpdateDriverStatusServlet")
public class UpdateDriverStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int driverId = Integer.parseInt(request.getParameter("driver_id"));
        String status = request.getParameter("status");

        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "UPDATE drivers SET status = ? WHERE driver_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, driverId);

            int rows = ps.executeUpdate();
            ps.close();

            if (rows > 0) {
                response.sendRedirect("drivers.jsp?success=updated");
            } else {
                response.sendRedirect("drivers.jsp?error=failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("drivers.jsp?error=dbError");
        }
    }
}
