<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Ensure only admin can access this page
    HttpSession sessionObj = request.getSession(false);
    Boolean isAdmin = (sessionObj != null && sessionObj.getAttribute("isAdmin") != null) 
                      ? (Boolean) sessionObj.getAttribute("isAdmin") 
                      : false;

    if (!isAdmin) {
        response.sendRedirect("adminlogin.jsp?error=notAuthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Driver</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .container { max-width: 500px; margin: 3rem auto; background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 0 15px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #4e54c8; margin-bottom: 1.5rem; }
        label { font-weight: bold; display: block; margin-top: 10px; }
        input, select { width: 100%; padding: 0.6rem; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px; }
        button { width: 100%; padding: 0.8rem; margin-top: 1rem; background: #4e54c8; color: white; font-size: 1rem; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #3e4396; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Driver</h2>
        <form action="AddDriverServlet" method="post">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" required>
            
            <label for="license">License Number:</label>
            <input type="text" id="license" name="license" required>
            
            <label for="phone">Phone Number:</label>
            <input type="text" id="phone" name="phone" required>
            
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>

            <label for="status">Status:</label>
            <select id="status" name="status">
                <option value="Available">Available</option>
                <option value="Unavailable">Unavailable</option>
            </select>

            <button type="submit">Add Driver</button>
        </form>
    </div>
</body>
</html>
