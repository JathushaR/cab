<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation - Mega City Cab</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }
        .container {
            max-width: 500px;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        h2 {
            color: #4e54c8;
            margin-bottom: 1rem;
        }
        p {
            font-size: 1rem;
            margin-bottom: 1rem;
        }
        a {
            text-decoration: none;
            color: #4e54c8;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Booking Confirmed!</h2>
        <p>Your cab booking has been successfully registered.</p>
        <p><a href="dashboard.jsp">Go to Dashboard</a></p>
    </div>
</body>
</html>
