<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bill - Mega City Cab</title>
    <link rel="stylesheet" 
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
            text-align: center;
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
            color: #783CD3;
            margin-bottom: 1rem;
        }
        p {
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }
        .qr-code {
            margin: 2rem 0;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background: #783CD3;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1rem;
            margin-top: 1rem;
        }
        .btn:hover {
            background: #5a28a0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>🚕 Booking Bill</h2>
        <p><strong>Booking ID:</strong> <%= request.getAttribute("bookingId") %></p>
        <p><strong>User:</strong> <%= request.getAttribute("username") %></p>
        <p><strong>Pickup:</strong> <%= request.getAttribute("pickup") %></p>
        <p><strong>Dropoff:</strong> <%= request.getAttribute("dropoff") %></p>
        <p><strong>Date:</strong> <%= request.getAttribute("date") %></p>
        <p><strong>Time:</strong> <%= request.getAttribute("time") %></p>
        <p><strong>Vehicle:</strong> <%= request.getAttribute("vehicle") %></p>
        <p><strong>Total Payment:</strong> Rs. <%= request.getAttribute("payment") %></p>
        
        <div class="qr-code">
            <img src="<%= request.getContextPath() %>/<%= request.getAttribute("qrImage") %>" alt="QR Code for Payment">
        </div>

        <a href="mybookings.jsp" class="btn">Return to My Bookings</a>
    </div>
</body>
</html>
