<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.example.util.DatabaseUtility" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assign Driver & Payment - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 2rem;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background: #fff;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #4e54c8;
            margin-bottom: 1rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        select, input[type="number"], input[type="text"] {
            width: 100%;
            padding: 0.6rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            width: 100%;
            padding: 0.8rem;
            border: none;
            border-radius: 4px;
            background: #4e54c8;
            color: #fff;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background: #3b449c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Assign Driver & Payment</h2>
        <form action="<%= request.getContextPath() %>/ProcessBookingServlet" method="post">
            <input type="hidden" name="action" value="accept">
            <input type="hidden" name="booking_id" value="<%= request.getAttribute("booking_id") %>">
            <label for="driver">Select Driver</label>
            <select id="driver" name="driver_id" required>
                <option value="">--Select Driver--</option>
                <%
                    try {
                        Connection conn = DatabaseUtility.getConnection();
                        String sql = "SELECT driver_id, name FROM drivers";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                        while(rs.next()){
                            int driverId = rs.getInt("driver_id");
                            String driverName = rs.getString("name");
                %>
                <option value="<%= driverId %>"><%= driverName %></option>
                <%
                        }
                        rs.close();
                        ps.close();
                        conn.close();
                    } catch(Exception e) {
                        out.println("<option value=''>Error loading drivers</option>");
                        e.printStackTrace();
                    }
                %>
            </select>
            <label for="payment">Payment (Rs.)</label>
            <input type="number" id="payment" name="payment" placeholder="Enter payment amount" required step="0.01">
            <button type="submit">Submit</button>
        </form>
    </div>
</body>
</html>
