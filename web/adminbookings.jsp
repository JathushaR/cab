<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.example.util.DatabaseUtility" %>

<%
    // Ensure the admin is logged in
    HttpSession sessionObj = request.getSession(false);
    String adminUser = (sessionObj != null) ? (String) sessionObj.getAttribute("loggedAdmin") : null;

    if (adminUser == null) {
        response.sendRedirect("adminlogin.jsp?error=notLoggedIn");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Manage Bookings</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 1100px;
            margin: 2rem auto;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #4e54c8;
            margin-bottom: 1.5rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background: #4e54c8;
            color: white;
        }
        .status-pending { color: #ffc107; font-weight: bold; }
        .status-accepted { color: #28a745; font-weight: bold; }
        .status-canceled { color: #dc3545; font-weight: bold; }
        .status-completed { color: #007bff; font-weight: bold; }
        .btn {
            padding: 5px 10px;
            border: none;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
            text-decoration: none;
        }
        .btn-accept { background: #28a745; }
        .btn-cancel { background: #dc3545; }
        .menu {
            display: flex;
            justify-content: space-between;
            padding: 1rem;
            background: #4e54c8;
            border-radius: 5px;
            color: white;
            margin-bottom: 1rem;
        }
        .menu a {
            color: white;
            text-decoration: none;
            font-size: 1rem;
            font-weight: bold;
            padding: 0.5rem 1rem;
        }
        .menu a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <h2>Manage Bookings</h2>

        <div class="menu">
            <a href="adminpanel.jsp"><i class="fas fa-arrow-left"></i> Return to Dashboard</a>
        </div>

        <table>
            <tr>
                <th>Booking ID</th>
                <th>User</th>
                <th>Pickup</th>
                <th>Drop-off</th>
                <th>Date</th>
                <th>Time</th>
                <th>Passengers</th>
                <th>Vehicle</th>
                <th>Status</th>
                <th>Driver</th>
                <th>Payment (Rs.)</th>
                <th>Actions</th>
            </tr>
            <%
                try {
                    Connection conn = DatabaseUtility.getConnection();
                    String sql = "SELECT b.booking_id, u.username AS user_name, b.pickup_location, b.dropoff_location, b.pickup_date, b.pickup_time, b.passengers, " +
                                 "v.model AS vehicle_model, b.booking_status, d.name AS driver_name, b.payment " +
                                 "FROM bookings b " +
                                 "LEFT JOIN users u ON b.user_id = u.user_id " +
                                 "LEFT JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                                 "LEFT JOIN drivers d ON b.driver_id = d.driver_id " +
                                 "ORDER BY b.booking_timestamp DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    boolean hasBookings = false;
                    while (rs.next()) {
                        hasBookings = true;
                        int bookingId = rs.getInt("booking_id");
                        String status = rs.getString("booking_status");
            %>
            <tr>
                <td><%= bookingId %></td>
                <td><%= rs.getString("user_name") %></td>
                <td><%= rs.getString("pickup_location") %></td>
                <td><%= rs.getString("dropoff_location") %></td>
                <td><%= rs.getDate("pickup_date") %></td>
                <td><%= rs.getTime("pickup_time") %></td>
                <td><%= rs.getInt("passengers") %></td>
                <td><%= rs.getString("vehicle_model") != null ? rs.getString("vehicle_model") : "N/A" %></td>
                <td>
                    <% if ("Pending".equals(status)) { %>
                        <span class="status-pending">Pending</span>
                    <% } else if ("Accepted".equals(status)) { %>
                        <span class="status-accepted">Accepted</span>
                    <% } else if ("Canceled".equals(status)) { %>
                        <span class="status-canceled">Canceled</span>
                    <% } else { %>
                        <span class="status-completed">Completed</span>
                    <% } %>
                </td>
                <td><%= rs.getString("driver_name") != null ? rs.getString("driver_name") : "Not Assigned" %></td>
                <td><%= rs.getDouble("payment") != 0.0 ? rs.getDouble("payment") : "Not Set" %></td>
                <td>
                    <% if ("Pending".equals(status)) { %>
                        <a href="<%= request.getContextPath() %>/ProcessBookingServlet?action=accept&booking_id=<%= bookingId %>" class="btn btn-accept">Accept</a>
                        <a href="<%= request.getContextPath() %>/ProcessBookingServlet?action=cancel&booking_id=<%= bookingId %>" class="btn btn-cancel">Cancel</a>
                    <% } else { %>
                        <span>N/A</span>
                    <% } %>
                </td>
            </tr>
            <%
                    }
                    rs.close();
                    ps.close();
                    conn.close();

                    if (!hasBookings) {
                        out.println("<tr><td colspan='12' style='text-align:center;'>No bookings available</td></tr>");
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='12' style='text-align:center;'>Error loading bookings</td></tr>");
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
</body>
</html>
