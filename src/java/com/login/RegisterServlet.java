package com.login;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.example.util.DatabaseUtility;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form parameters for user registration
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Check for empty fields
        if(name == null || name.isEmpty() ||
           address == null || address.isEmpty() ||
           nic == null || nic.isEmpty() ||
           phone == null || phone.isEmpty() ||
           username == null || username.isEmpty() ||
           password == null || password.isEmpty()) {
            response.sendRedirect("signup.jsp?error=emptyFields");
            return;
        }
        
        boolean isInserted = false;
        
        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "INSERT INTO users (name, address, nic, email, phone, username, password) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, address);
            stmt.setString(3, nic);
            stmt.setString(4, request.getParameter("email")); // assuming email field exists in form
            stmt.setString(5, phone);
            stmt.setString(6, username);
            stmt.setString(7, password);  // plain-text for demo
            int rowsInserted = stmt.executeUpdate();
            stmt.close();
            if (rowsInserted > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("registerSuccess", "Registration successful! You can now log in.");
                isInserted = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=dbError");
            return;
        }
        
        if (isInserted) {
            response.sendRedirect("login.jsp?signup=success");
        } else {
            response.sendRedirect("signup.jsp?error=failed");
        }
    }
}
