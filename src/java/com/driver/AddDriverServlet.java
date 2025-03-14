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

@WebServlet("/AddDriverServlet")
public class AddDriverServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String license = request.getParameter("license");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String status = request.getParameter("status");

        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "INSERT INTO drivers (name, license_number, phone, address, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, license);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, status);
            
            int rows = ps.executeUpdate();
            ps.close();

            if (rows > 0) {
                response.sendRedirect("drivers.jsp?success=added");
            } else {
                response.sendRedirect("addDriver.jsp?error=failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("addDriver.jsp?error=dbError");
        }
    }
}
