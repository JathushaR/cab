<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.example.util.DatabaseUtility" %>

<%
    // Ensure the user is logged in
    HttpSession sessionObj = request.getSession(false); // Don't create a new session if not exists
    Integer userId = (sessionObj != null) ? (Integer) sessionObj.getAttribute("user_id") : null;
    String username = (sessionObj != null) ? (String) sessionObj.getAttribute("loggedUser") : null;

    if (userId == null) {
        response.sendRedirect("login.jsp?error=notLoggedIn");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - Mega City Cab</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 900px;
            margin: 3rem auto;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #783CD3;
            margin-bottom: 1.5rem;
        }
        .welcome-msg {
            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 2rem;
        }
        .menu {
            display: flex;
            justify-content: space-between;
            padding: 1rem;
            background: #783CD3;
            border-radius: 5px;
            color: white;
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
            text-align: left;
        }
        th {
            background: #783CD3;
            color: white;
        }
        .action-btn {
            padding: 5px 10px;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 4px;
            text-decoration: none;
        }
        .btn-book {
            background: #4CAF50;
        }
        .btn-logout {
            background: #d9534f;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <h2>User Dashboard</h2>
        <p class="welcome-msg">Welcome, <%= username %>!</p>

        <div class="menu">
            <a href="bookcab.jsp"><i class="fas fa-taxi"></i> Book a Cab</a>
            <a href="mybookings.jsp"><i class="fas fa-list"></i> My Bookings</a>
            <a href="LogoutServlet" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <h3>Recent Bookings</h3>
        <table>
            <tr>
                <th>Booking ID</th>
                <th>Pickup Location</th>
                <th>Drop-off Location</th>
                <th>Pickup Date</th>
                <th>Pickup Time</th>
                <th>Passengers</th>
                <th>Vehicle</th>
            </tr>
            <%
                try {
                    Connection conn = DatabaseUtility.getConnection();
                    String sql = "SELECT b.booking_id, b.pickup_location, b.dropoff_location, b.pickup_date, b.pickup_time, b.passengers, v.model " +
                                 "FROM bookings b JOIN vehicles v ON b.vehicle_id = v.vehicle_id WHERE b.user_id = ? ORDER BY b.booking_timestamp DESC LIMIT 5";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, userId);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("booking_id") %></td>
                <td><%= rs.getString("pickup_location") %></td>
                <td><%= rs.getString("dropoff_location") %></td>
                <td><%= rs.getDate("pickup_date") %></td>
                <td><%= rs.getTime("pickup_time") %></td>
                <td><%= rs.getInt("passengers") %></td>
                <td><%= rs.getString("model") %></td>
            </tr>
            <%
                    }
                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='7' style='text-align:center;'>Error loading bookings</td></tr>");
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
</body>
<jsp:include page="footer.jsp" />

</html>
