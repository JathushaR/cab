<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign Up - Mega City Cab</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Base styles */
        * { box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 450px;
            margin: 2rem auto;
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
        .message {
            padding: 0.8rem;
            margin-bottom: 1rem;
            border-radius: 4px;
            text-align: center;
        }
        .error { background: #ffdddd; color: #b30000; }
        .success { background: #ddffdd; color: #006600; }
        .input-group {
            position: relative;
            margin-bottom: 1.2rem;
        }
        .input-group label {
            display: block;
            margin-bottom: 0.4rem;
            font-weight: bold;
        }
        .input-group .icon {
            position: absolute;
            top: 37px;
            left: 10px;
            color: #aaa;
            font-size: 1.1rem;
            pointer-events: none;
        }
        .input-group input {
            width: 100%;
            padding: 0.7rem 0.7rem 0.7rem 2.4rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 0.95rem;
        }
        .input-group input:focus {
            border-color: #783CD3;
            outline: none;
        }
        button {
            width: 100%;
            padding: 0.8rem;
            border: none;
            border-radius: 4px;
            background: #783CD3;
            color: #fff;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 1rem;
            transition: background 0.3s;
        }
        button:hover {
            background: #5a28a0;
        }
        .extra-link {
            text-align: center;
            margin-top: 1rem;
        }
        .extra-link a {
            text-decoration: none;
            color: #783CD3;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <h2>Sign Up</h2>
        <% 
            String error = request.getParameter("error");
            String registerSuccess = (String) session.getAttribute("registerSuccess");
            if (error != null) { 
        %>
            <div class="message error">
                <%= error.equals("emptyFields") ? "Please fill all the fields." : 
                    error.equals("failed") ? "Registration failed. Please try again." : 
                    error.equals("dbError") ? "Database error. Please try again later." : error %>
            </div>
        <% } else if (registerSuccess != null) { %>
            <div class="message success">
                <%= registerSuccess %>
            </div>
        <% session.removeAttribute("registerSuccess"); } %>
        <form action="<%= request.getContextPath() %>/RegisterServlet" method="post">
            <div class="input-group">
                <label for="name">Full Name</label>
                <i class="fas fa-user icon"></i>
                <input type="text" id="name" name="name" placeholder="e.g. John Smith" required>
            </div>
            <div class="input-group">
                <label for="address">Address</label>
                <i class="fas fa-map-marker-alt icon"></i>
                <input type="text" id="address" name="address" placeholder="123 Main St" required>
            </div>
            <div class="input-group">
                <label for="nic">NIC</label>
                <i class="fas fa-id-card icon"></i>
                <input type="text" id="nic" name="nic" placeholder="National ID / NIC Number" required>
            </div>
            <div class="input-group">
                <label for="phone">Phone Number</label>
                <i class="fas fa-phone-alt icon"></i>
                <input type="text" id="phone" name="phone" placeholder="e.g. +94 712345678" required>
            </div>
            <div class="input-group">
                <label for="email">Email Address</label>
                <i class="fas fa-envelope icon"></i>
                <input type="email" id="email" name="email" placeholder="yourname@example.com" required>
            </div>
            <div class="input-group">
                <label for="username">Username</label>
                <i class="fas fa-user-tag icon"></i>
                <input type="text" id="username" name="username" placeholder="Enter username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <i class="fas fa-lock icon"></i>
                <input type="password" id="password" name="password" placeholder="Enter password" required>
            </div>
            <button type="submit">Sign Up</button>
        </form>
        <div class="extra-link">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>
</body>
<jsp:include page="footer.jsp" />

</html>
