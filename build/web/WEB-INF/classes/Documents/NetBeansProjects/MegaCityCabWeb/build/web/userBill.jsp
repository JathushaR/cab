<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment - Mega City Cab</title>
    <style>
        * { box-sizing: border-box; text-align: center; }
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 500px;
            margin: 3rem auto;
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        h2 { color: #4e54c8; }
        .amount {
            font-size: 1.5rem;
            font-weight: bold;
            color: #28a745;
            margin: 1rem 0;
        }
        .qr-code img {
            max-width: 250px;
            margin: 1rem 0;
        }
        .return-btn {
            display: inline-block;
            margin-top: 1.5rem;
            padding: 10px 20px;
            background: #4e54c8;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1rem;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Scan to Pay</h2>
    <p class="amount">Total Amount: Rs. <%= request.getAttribute("amount") %></p>
    
    <div class="qr-code">
        <img src="<%= request.getAttribute("qrPath") %>" alt="QR Code">
    </div>

    <a href="dashboard.jsp" class="return-btn">Return to Dashboard</a>
</div>

</body>
</html>
