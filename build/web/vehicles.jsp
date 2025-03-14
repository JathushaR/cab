<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.example.util.DatabaseUtility" %>




<%
    // Ensure session exists
    HttpSession sessionObj = request.getSession(false);

    // Check if session is null or user is not an admin
    Boolean isAdmin = (sessionObj != null && sessionObj.getAttribute("isAdmin") != null) 
                      ? (Boolean) sessionObj.getAttribute("isAdmin") 
                      : false;

    if (!isAdmin) {
        response.sendRedirect("adminlogin.jsp?error=notAuthorized");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vehicle Management - Admin Panel</title>
</head>
<body>
    <h2>Vehicle Management</h2>
    <a href="adminpanel.jsp">Return to Admin Panel</a>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vehicle Management - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h2 { text-align: center; color: #4e54c8; margin-bottom: 1.5rem; }
        table { width: 100%; border-collapse: collapse; margin-top: 1.5rem; }
        table, th, td { border: 1px solid #ccc; }
        th, td { padding: 10px; text-align: center; }
        th { background: #4e54c8; color: white; }
        .status-available { color: green; font-weight: bold; }
        .status-unavailable { color: red; font-weight: bold; }
        .btn {
            padding: 5px 10px;
            border: none;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
            text-decoration: none;
        }
        .btn-update { background: #007bff; }
        .btn-delete { background: #dc3545; }
        .menu {
            display: flex;
            justify-content: space-between;
            padding: 1rem;
            background: #4e54c8;
            border-radius: 5px;
            color: white;
            margin-bottom: 1rem;
        }
        .menu a { color: white; text-decoration: none; font-size: 1rem; font-weight: bold; padding: 0.5rem 1rem; }
        .menu a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <h2>Vehicle Management</h2>

        <div class="menu">
            <a href="adminpanel.jsp"><i class="fas fa-home"></i> Admin Dashboard</a>
            <a href="addVehicle.jsp"><i class="fas fa-plus-circle"></i> Add Vehicle</a>
            <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <table>
            <tr>
                <th>Vehicle ID</th>
                <th>Type</th>
                <th>Model</th>
                <th>Manufacturer</th>
                <th>Registration No.</th>
                <th>Capacity</th>
                <th>Color</th>
                <th>Status</th>
                <th>Last Maintenance</th>
                <th>Current Location</th>
                <th>Actions</th>
            </tr>
            <%
                boolean hasVehicles = false;
                try {
                    Connection conn = DatabaseUtility.getConnection();
                    String sql = "SELECT * FROM vehicles";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        hasVehicles = true;
            %>
            <tr>
                <td><%= rs.getInt("vehicle_id") %></td>
                <td><%= rs.getString("vehicle_type") %></td>
                <td><%= rs.getString("model") %></td>
                <td><%= rs.getString("manufacturer") != null ? rs.getString("manufacturer") : "N/A" %></td>
                <td><%= rs.getString("registration_number") %></td>
                <td><%= rs.getInt("capacity") %> passengers</td>
                <td><%= rs.getString("color") != null ? rs.getString("color") : "N/A" %></td>
                <td>
                    <form action="UpdateVehicleStatusServlet" method="post" style="display:inline;">
                        <input type="hidden" name="vehicle_id" value="<%= rs.getInt("vehicle_id") %>">
                        <select name="status" onchange="this.form.submit()">
                            <option value="Available" <%= "Available".equalsIgnoreCase(rs.getString("status")) ? "selected" : "" %>>Available</option>
                            <option value="Unavailable" <%= "Unavailable".equalsIgnoreCase(rs.getString("status")) ? "selected" : "" %>>Unavailable</option>
                        </select>
                    </form>
                </td>
                <td><%= rs.getDate("last_maintenance_date") != null ? rs.getDate("last_maintenance_date") : "N/A" %></td>
                <td><%= rs.getString("current_location") != null ? rs.getString("current_location") : "N/A" %></td>
                <td>
                    <a href="deleteVehicleServlet?vehicle_id=<%= rs.getInt("vehicle_id") %>" class="btn btn-delete">Delete</a>
                </td>
            </tr>
            <%
                    }
                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='11' style='text-align:center;'>Error loading vehicles</td></tr>");
                    e.printStackTrace();
                }
            %>
        </table>

        <% if (!hasVehicles) { %>
            <p class="no-vehicles" style="text-align: center; font-size: 1.1rem; color: #666; margin-top: 2rem;">
                No vehicles found.
            </p>
        <% } %>
    </div>
</body>
</html>
