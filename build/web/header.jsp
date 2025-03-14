<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 
    header.jsp 
    This file can be included in other JSP pages to display a consistent
    navigation bar and optional styles/scripts across your application.
-->

<!-- Optional: Font Awesome for icons -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

<style>
  /* Basic reset for included styles */
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  /* Navigation Bar (Gradient) */
  nav {
    background: linear-gradient(135deg, #D18FF7, #783CD3);
    padding: 0.8rem 1.5rem;
    display: flex;
    align-items: center;
  }

  /* Left: Logo / Title */
  .nav-left {
    font-size: 1.5rem;
    font-weight: bold;
    color: #fff;
    text-decoration: none;
    margin-right: 1.5rem;
  }

  /* Middle: Home, About, Book Your Cab */
  .nav-middle {
    flex: 1; /* fill remaining space */
    text-align: center;
  }
  .nav-middle ul {
    display: inline-flex;
    list-style: none;
    gap: 2rem;
  }
  .nav-middle ul li a {
    color: #fff;
    text-decoration: none;
    font-size: 1rem;
    padding: 0.4rem 0.8rem;
    border-radius: 4px;
    transition: background 0.3s;
  }
  .nav-middle ul li a:hover {
    background: rgba(255, 255, 255, 0.2);
  }

  /* Right: Login & Sign Up (Icons + Names) */
  .nav-right ul {
    list-style: none;
    display: flex;
    gap: 1.2rem;
  }
  .nav-right li a {
    color: #fff;
    text-decoration: none;
    font-size: 1rem;
    padding: 0.4rem 0.6rem;
    border-radius: 4px;
    transition: background 0.3s;
    display: inline-flex;
    align-items: center;
  }
  .nav-right li a i {
    margin-right: 0.4rem; /* space between icon and text */
  }
  .nav-right li a:hover {
    background: rgba(255, 255, 255, 0.2);
  }

</style>

<!-- Header / Navigation -->
<header>
  <nav>
    <!-- Left: Logo/Title -->
    <a href="<%= request.getContextPath() %>/index.html" class="nav-left">
      Mega City Cab
    </a>

    <!-- Middle: Home, About, Book Your Cab -->
    <div class="nav-middle">
      <ul>
        <li><a href="<%= request.getContextPath() %>/index.html"><i class="fas fa-home"></i> Home</a></li>
        <li><a href="<%= request.getContextPath() %>/about.jsp"><i class="fas fa-info-circle"></i> About</a></li>
        <li><a href="<%= request.getContextPath() %>/bookcab.jsp"><i class="fas fa-car"></i> Book Your Cab</a></li>
      </ul>
    </div>

    <!-- Right: Icons + Names for Login & Sign Up -->
    <div class="nav-right">
      <ul>
        <li>
          <a href="<%= request.getContextPath() %>/login.jsp" title="Login">
            <i class="fas fa-sign-in-alt"></i> Login
          </a>
        </li>
        <li>
          <a href="<%= request.getContextPath() %>/signup.jsp" title="Sign Up">
            <i class="fas fa-user-plus"></i> Sign Up
          </a>
        </li>
      </ul>
    </div>
  </nav>
</header>
