<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Login - Mega City Cab</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" 
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Base styles */
        * { box-sizing: border-box; }
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }
        /* Container card */
        .container {
            width: 400px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.15);
            padding: 2rem;
        }
        h2 {
            text-align: center;
            color: #4e54c8;
            margin-bottom: 1.5rem;
        }
        /* Message styling */
        .message {
            padding: 0.8rem;
            margin-bottom: 1rem;
            border-radius: 4px;
            text-align: center;
        }
        .error {
            background: #ffdddd;
            color: #b30000;
        }
        /* Input groups */
        .input-group {
            position: relative;
            margin-bottom: 1.2rem;
        }
        .input-group label {
            display: block;
            margin-bottom: 0.4rem;
            font-weight: bold;
            color: #333;
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
            border-color: #4e54c8;
            outline: none;
        }
        /* Submit button */
        button {
            width: 100%;
            padding: 0.8rem;
            border: none;
            border-radius: 4px;
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            color: #fff;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 1rem;
            transition: background 0.3s;
        }
        button:hover {
            background: linear-gradient(135deg, #3b449c, #7d87e1);
        }
        /* Extra link */
        .extra-link {
            text-align: center;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        .extra-link a {
            text-decoration: none;
            color: #4e54c8;
            font-weight: bold;
        }
    </style>
</head>
<body>
   
    
    <div class="container">
        <h2>Admin Login</h2>
        <% 
            String error = request.getParameter("error");
            if (error != null) { 
        %>
            <div class="message error">
                <%= error.equals("mismatch") ? "Passwords do not match." : "Invalid username or password." %>
            </div>
        <% } %>
        <form action="<%= request.getContextPath() %>/AdminLoginServlet" method="post">
            <div class="input-group">
                <label for="username">Username</label>
                <i class="fas fa-user icon"></i>
                <input type="text" id="username" name="username" placeholder="Enter admin username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <i class="fas fa-lock icon"></i>
                <input type="password" id="password" name="password" placeholder="Enter password" required>
            </div>
            <div class="input-group">
                <label for="confirmPassword">Confirm Password</label>
                <i class="fas fa-lock icon"></i>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" required>
            </div>
            <button type="submit">Login</button>
        </form>
        <div class="extra-link">
            <p>Not an admin? <a href="login.jsp">User Login</a></p>
        </div>
    </div>
</body>


</html>
