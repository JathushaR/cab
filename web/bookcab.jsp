<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.example.util.DatabaseUtility" %>

<%
    // Ensure the user is logged in
    HttpSession sessionObj = request.getSession(false);
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
    <title>Book a Cab - Mega City Cab</title>
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
            max-width: 600px;
            margin: 3rem auto;
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
        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        label { font-weight: bold; }
        input, select {
            padding: 0.6rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }
        button {
            background: #4e54c8;
            color: white;
            padding: 0.8rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
        }
        button:hover { background: #3b449c; }
        .error-msg {
            text-align: center;
            color: #b30000;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <h2>Book Your Cab</h2>
        
        <% 
            String error = request.getParameter("error");
            if(error != null) { 
        %>
            <div class="error-msg"><%= error %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/BookCabServlet" method="post">
            <input type="hidden" name="user_id" value="<%= userId %>">

            <label for="pickup">Pickup Location:</label>
            <input type="text" id="pickup" name="pickup" placeholder="Enter pickup location" required>

            <label for="dropoff">Drop-off Location:</label>
            <input type="text" id="dropoff" name="dropoff" placeholder="Enter drop-off location" required>

            <label for="date">Pickup Date:</label>
            <input type="date" id="date" name="date" required>

            <label for="time">Pickup Time:</label>
            <input type="time" id="time" name="time" required>

            <label for="passengers">Passengers Count:</label>
            <input type="number" id="passengers" name="passengers" min="1" placeholder="Number of passengers" required>

            <label for="vehicle">Select Vehicle:</label>
            <select id="vehicle" name="vehicleId" required>
                <option value="">--Select Vehicle--</option>
                <%
                    try {
                        Connection conn = DatabaseUtility.getConnection();
                        String sql = "SELECT vehicle_id, model, registration_number FROM vehicles WHERE status = 'Available'";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                            int vehicleId = rs.getInt("vehicle_id");
                            String model = rs.getString("model");
                            String regNum = rs.getString("registration_number");
                %>
                            <option value="<%= vehicleId %>"><%= model %> (Plate: <%= regNum %>)</option>
                <%
                        }
                        rs.close();
                        ps.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<option value=''>Error loading vehicles</option>");
                        e.printStackTrace();
                    }
                %>
            </select>

            <button type="submit">Book Cab</button>
        </form>
    </div>
</body>
<jsp:include page="footer.jsp" />

</html>
