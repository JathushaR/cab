<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>About - Mega City Cab</title>
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    /* Reset and Base */
    * {
      box-sizing: border-box;
    }
    body {
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
      background: #f4f4f4;
      color: #333;
    }
    header {
      margin-bottom: 2rem;
    }
    /* Main container */
    .container {
      max-width: 900px;
      margin: 0 auto;
      padding: 2rem;
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
    h1 {
      text-align: center;
      color: #4e54c8;
      margin-bottom: 1.5rem;
    }
    /* About Section Layout */
    .about-section {
      display: flex;
      flex-wrap: wrap;
      gap: 2rem;
      align-items: center;
    }
    .about-image {
      flex: 1 1 300px;
      max-width: 400px;
    }
    .about-image img {
      width: 100%;
      border-radius: 8px;
    }
    .about-text {
      flex: 2 1 400px;
    }
    .about-text h2 {
      display: flex;
      align-items: center;
      font-size: 1.8rem;
      margin-bottom: 0.5rem;
      color: #4e54c8;
    }
    .about-text h2 .icon {
      margin-right: 0.5rem;
      color: #8362f5;
      font-size: 1.5rem;
    }
    .about-text p {
      line-height: 1.6;
      margin-bottom: 1rem;
    }
    @media (max-width: 768px) {
      .about-section {
        flex-direction: column;
        text-align: center;
      }
      .about-text, .about-image {
        flex: 1 1 100%;
      }
      .about-text h2 {
        justify-content: center;
      }
    }
  </style>
</head>
<body>
  <!-- Include shared header -->
  <jsp:include page="header.jsp" />

  <div class="container">
    <h1>About Mega City Cab</h1>
    <div class="about-section">
      <!-- Image Section -->
      <div class="about-image">
        <img src="images/cab_fleet.jpg" alt="Our Fleet">
      </div>
      <!-- Text Section with Icons -->
      <div class="about-text">
        <h2><i class="fas fa-history icon"></i>Our Story</h2>
        <p>Mega City Cab started with a simple idea: to provide safe, reliable, and affordable transportation in Colombo. Over the years, we have grown into one of the city's most trusted cab services.</p>
        <h2><i class="fas fa-bullseye icon"></i>Our Mission</h2>
        <p>Our mission is to deliver a seamless and comfortable travel experience. We invest in a modern fleet, professional drivers, and customer-friendly technology to ensure every ride is a positive experience.</p>
        <h2><i class="fas fa-concierge-bell icon"></i>Our Services</h2>
        <p>We offer a range of transportation services—from everyday commutes to special event bookings. With 24/7 availability and an easy-to-use online booking system, we’re always ready to serve you.</p>
      </div>
    </div>
  </div>
  <jsp:include page="footer.jsp" />

</body>
</html>
