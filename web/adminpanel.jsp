<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String loggedAdmin = (String) session.getAttribute("loggedAdmin");
    if (loggedAdmin == null) {
        response.sendRedirect("adminlogin.jsp?error=notLoggedIn");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel - Mega City Cab</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.15);
        }
        h1 {
            color: #4e54c8;
        }
        .logout {
            text-align: right;
            margin-bottom: 1rem;
        }
        .logout a {
            color: #4e54c8;
            text-decoration: none;
            font-weight: bold;
        }
        .logout a:hover {
            text-decoration: underline;
        }
        .menu {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .menu a {
            background: #4e54c8;
            color: #fff;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 4px;
            transition: background 0.3s;
        }
        .menu a:hover {
            background: #3b449c;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <div class="logout">
            <a href="LogoutServlet">Logout</a>
        </div>
        <h1>Welcome, <%= loggedAdmin %>!</h1>
        <div class="menu">
            <a href="adminbookings.jsp"><i class="fas fa-list"></i> Pending Bookings</a>
            <a href="vehicles.jsp"><i class="fas fa-car"></i> Manage Vehicles</a>
            <a href="drivers.jsp"><i class="fas fa-user"></i> Manage Drivers</a>
        </div>
        <p>Admin panel content goes here.</p>
    </div>
</body>
</html>
