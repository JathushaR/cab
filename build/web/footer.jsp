<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer>
    <div class="footer-container">
        <div class="footer-content">
            <div class="footer-logo">
                <h2>Mega City Cab</h2>
                <p>Reliable & Affordable Rides</p>
            </div>
                        <div class="footer-contact">
                <p><i class="fas fa-phone"></i> +94 712 345 678</p>
                <p><i class="fas fa-envelope"></i> support@megacitycab.com</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 Mega City Cab. All Rights Reserved.</p>
        </div>
    </div>
</footer>

<!-- Font Awesome for Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
    /* Footer Styles */
    footer {
        background: linear-gradient(135deg, #783CD3, #4e54c8);
        color: #fff;
        padding: 1rem;
        font-family: Arial, sans-serif;
        font-size: 0.9rem;
    }
    .footer-container {
        max-width: 1100px;
        margin: 0 auto;
    }
    .footer-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        text-align: center;
    }
    .footer-logo h2 {
        font-size: 1.5rem;
        margin-bottom: 0.2rem;
    }
    .footer-logo p {
        font-size: 0.85rem;
        opacity: 0.8;
    }
    .footer-links ul {
        list-style: none;
        padding: 0;
        display: flex;
        gap: 1.2rem;
        margin-top: 0.5rem;
    }
    .footer-links ul li {
        display: inline;
    }
    .footer-links ul li a {
        color: #fff;
        text-decoration: none;
        transition: color 0.3s ease-in-out;
        font-size: 0.85rem;
    }
    .footer-links ul li a:hover {
        color: #ffcb57;
    }
    .footer-contact p {
        margin: 0.3rem 0;
        font-size: 0.85rem;
    }
    .footer-contact i {
        margin-right: 0.3rem;
    }
    .footer-bottom {
        text-align: center;
        margin-top: 0.8rem;
        font-size: 0.85rem;
    }
    @media (max-width: 768px) {
        .footer-content {
            flex-direction: column;
        }
        .footer-links ul {
            flex-direction: column;
            gap: 0.5rem;
        }
    }
</style>
