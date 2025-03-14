package com.login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.example.util.DatabaseUtility;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve admin login parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Check if password and confirmPassword match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("adminlogin.jsp?error=mismatch");
            return;
        }
        
        boolean isValidAdmin = false;
        
        try (Connection conn = DatabaseUtility.getConnection()) {
            String sql = "SELECT * FROM admins WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password); // Plain-text password (NOT RECOMMENDED)
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isValidAdmin = true;
                }
            }
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        if (isValidAdmin) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedAdmin", username);
            session.setAttribute("isAdmin", true);  // ✅ FIX: Setting isAdmin flag
            response.sendRedirect("adminpanel.jsp"); // Redirect to admin dashboard
        } else {
            response.sendRedirect("adminlogin.jsp?error=invalid");
        }
    }
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.sendRedirect("adminlogin.jsp");
    }
}
