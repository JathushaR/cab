<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - Mega City Cab</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" 
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Base styles */
        * {
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5; /* same background as signup page */
            margin: 0;
            padding: 0;
            color: #333;
        }
        /* Container styling matches signup */
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
            color: #783CD3; /* same heading color as signup */
            margin-bottom: 1.5rem;
        }
        /* Message boxes for error/success */
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
        /* Form & Inputs */
        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
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
        /* Submit button */
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
        /* Extra link (same style as signup) */
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
    <!-- Optionally include your header (like in signup page) -->
    <jsp:include page="header.jsp" />

    <div class="container">
        <h2>Login</h2>
        <% 
            // Check for error parameter (like in signup page)
            String error = request.getParameter("error"); 
            if (error != null) {
        %>
            <div class="message error">
                <%= error.equals("mismatch") 
                        ? "Passwords do not match." 
                        : "Invalid username or password." %>
            </div>
        <% } %>

        <!-- Adjust action to your LoginServlet or relevant path -->
        <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
            <div class="input-group">
                <label for="username">Username</label>
                <i class="fas fa-user icon"></i>
                <input type="text" id="username" name="username" placeholder="Enter username" required>
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
            <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p>
        </div>
    </div>
            <jsp:include page="footer.jsp" />

</body>
</html>
