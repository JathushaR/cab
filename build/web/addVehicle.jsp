<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Ensure only admin can access this page
    HttpSession sessionObj = request.getSession(false);
    Boolean isAdmin = (sessionObj != null) ? (Boolean) sessionObj.getAttribute("isAdmin") : false;

    if (!isAdmin) {
        response.sendRedirect("dashboard.jsp?error=notAuthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Vehicle - Admin Panel</title>
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
        h2 { text-align: center; color: #4e54c8; margin-bottom: 1.5rem; }
        form { display: flex; flex-direction: column; gap: 1rem; }
        label { font-weight: bold; }
        input, select { padding: 0.6rem; border: 1px solid #ccc; border-radius: 4px; font-size: 1rem; }
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
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Vehicle</h2>
        <form action="<%= request.getContextPath() %>/AddVehicleServlet" method="post">
            <label>Vehicle Type:</label>
            <select name="vehicleType" required>
                <option value="Car">Car</option>
                <option value="Van">Van</option>
            </select>
            
            <label>Model:</label>
            <input type="text" name="model" required>

            <label>Manufacturer:</label>
            <input type="text" name="manufacturer" required>

            <label>Registration Number:</label>
            <input type="text" name="registrationNumber" required>

            <label>Capacity:</label>
            <input type="number" name="capacity" required>

            <label>Color:</label>
            <input type="text" name="color" required>

            <label>Status:</label>
            <select name="status">
                <option value="Available">Available</option>
                <option value="Unavailable">Unavailable</option>
            </select>

            <label>Last Maintenance Date:</label>
            <input type="date" name="maintenanceDate">

            <label>Current Location:</label>
            <input type="text" name="currentLocation" required>

            <button type="submit">Add Vehicle</button>
        </form>
    </div>
</body>
</html>
