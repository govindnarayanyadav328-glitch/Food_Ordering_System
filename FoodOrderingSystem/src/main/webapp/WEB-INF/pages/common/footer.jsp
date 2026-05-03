    </div>
    
    <footer style="
        background: #2c3e50;
        color: white;
        padding: 3rem 0 1.5rem;
        margin-top: 3rem;
    ">
        <div style="
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
        ">
            <!-- Column 1: About FoodieHub -->
            <div>
                <h3 style="
                    margin-bottom: 1rem;
                    color: #ff6b35;
                    font-size: 1.25rem;
                ">
                    <i class="fas fa-utensils"></i> About FoodieHub
                </h3>
                <p style="color: #adb5bd; line-height: 1.6;">
                    Your favorite food delivery service. Fresh, fast, and delicious meals delivered to your doorstep.
                </p>
                <div style="margin-top: 1rem; display: flex; gap: 1rem;">
                    <a href="#" style="color: white; background: rgba(255,255,255,0.1); width: 35px; height: 35px; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; transition: all 0.3s;">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" style="color: white; background: rgba(255,255,255,0.1); width: 35px; height: 35px; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; transition: all 0.3s;">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" style="color: white; background: rgba(255,255,255,0.1); width: 35px; height: 35px; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; transition: all 0.3s;">
                        <i class="fab fa-twitter"></i>
                    </a>
                </div>
            </div>
            
            <!-- Column 2: Quick Links -->
            <div>
                <h3 style="
                    margin-bottom: 1rem;
                    color: #ff6b35;
                    font-size: 1.25rem;
                ">
                    <i class="fas fa-link"></i> Quick Links
                </h3>
                <ul style="list-style: none; padding: 0;">
                    <li style="margin-bottom: 0.5rem;">
                        <a href="${pageContext.request.contextPath}/Home" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                            <i class="fas fa-chevron-right" style="font-size: 0.75rem; margin-right: 0.5rem;"></i> Home
                        </a>
                    </li>
                    <% if (session.getAttribute("user") == null) { %>
                        <li style="margin-bottom: 0.5rem;">
                            <a href="${pageContext.request.contextPath}/Login" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                                <i class="fas fa-chevron-right" style="font-size: 0.75rem; margin-right: 0.5rem;"></i> Login
                            </a>
                        </li>
                        <li style="margin-bottom: 0.5rem;">
                            <a href="${pageContext.request.contextPath}/register" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                                <i class="fas fa-chevron-right" style="font-size: 0.75rem; margin-right: 0.5rem;"></i> Register
                            </a>
                        </li>
                    <% } else { %>
                        <li style="margin-bottom: 0.5rem;">
                            <a href="${pageContext.request.contextPath}/Cart" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                                <i class="fas fa-chevron-right" style="font-size: 0.75rem; margin-right: 0.5rem;"></i> Cart
                            </a>
                        </li>
                    <% } %>
                    <li style="margin-bottom: 0.5rem;">
                        <a href="#" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                            <i class="fas fa-chevron-right" style="font-size: 0.75rem; margin-right: 0.5rem;"></i> Offers
                        </a>
                    </li>
                </ul>
            </div>
            
            <!-- Column 3: Contact Us -->
            <div>
                <h3 style="
                    margin-bottom: 1rem;
                    color: #ff6b35;
                    font-size: 1.25rem;
                ">
                    <i class="fas fa-headset"></i> Contact Us
                </h3>
                <ul style="list-style: none; padding: 0;">
                    <li style="margin-bottom: 0.75rem; color: #adb5bd;">
                        <i class="fas fa-phone-alt" style="width: 25px; margin-right: 0.5rem; color: #ff6b35;"></i> 
                        +977 9800000000
                    </li>
                    <li style="margin-bottom: 0.75rem; color: #adb5bd;">
                        <i class="fas fa-envelope" style="width: 25px; margin-right: 0.5rem; color: #ff6b35;"></i> 
                        info@foodiehub.com
                    </li>
                    <li style="margin-bottom: 0.75rem; color: #adb5bd;">
                        <i class="fas fa-map-marker-alt" style="width: 25px; margin-right: 0.5rem; color: #ff6b35;"></i> 
                        Kathmandu, Nepal
                    </li>
                    <li style="margin-bottom: 0.75rem; color: #adb5bd;">
                        <i class="fas fa-clock" style="width: 25px; margin-right: 0.5rem; color: #ff6b35;"></i> 
                        Mon-Sun: 10AM - 10PM
                    </li>
                </ul>
            </div>
            
            <!-- Column 4: Follow Us -->
            <div>
                <h3 style="
                    margin-bottom: 1rem;
                    color: #ff6b35;
                    font-size: 1.25rem;
                ">
                    <i class="fas fa-share-alt"></i> Follow Us
                </h3>
                <ul style="list-style: none; padding: 0;">
                    <li style="margin-bottom: 0.5rem;">
                        <a href="#" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                            <i class="fab fa-facebook-f" style="width: 25px; margin-right: 0.5rem;"></i> Facebook
                        </a>
                    </li>
                    <li style="margin-bottom: 0.5rem;">
                        <a href="#" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                            <i class="fab fa-instagram" style="width: 25px; margin-right: 0.5rem;"></i> Instagram
                        </a>
                    </li>
                    <li style="margin-bottom: 0.5rem;">
                        <a href="#" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                            <i class="fab fa-twitter" style="width: 25px; margin-right: 0.5rem;"></i> Twitter
                        </a>
                    </li>
                    <li style="margin-bottom: 0.5rem;">
                        <a href="#" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                            <i class="fab fa-youtube" style="width: 25px; margin-right: 0.5rem;"></i> YouTube
                        </a>
                    </li>
                </ul>
                
                <!-- Newsletter -->
                <div style="margin-top: 1.5rem;">
                    <h4 style="font-size: 1rem; margin-bottom: 0.5rem; color: white;">Subscribe to our Daily Newsletter</h4>
                    <form action="#" method="post" style="display: flex; gap: 0.5rem;">
                        <input type="email" placeholder="Your email" style="flex: 1; padding: 0.5rem; border: none; border-radius: 4px;">
                        <button type="submit" style="padding: 0.5rem 1rem; background: #ff6b35; color: white; border: none; border-radius: 4px; cursor: pointer;">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Footer Bottom -->
        <div style="
            text-align: center;
            padding-top: 2rem;
            margin-top: 2rem;
            border-top: 1px solid rgba(255,255,255,0.1);
        ">
            <p style="color: #adb5bd; font-size: 0.875rem;">
                &copy; 2024 FoodieHub. All rights reserved. | 
                <a href="#" style="color: #adb5bd; text-decoration: none;">Privacy Policy</a> | 
                <a href="#" style="color: #adb5bd; text-decoration: none;">Terms of Service</a>
            </p>
        </div>
    </footer>
    
    <style>
        /* Hover effects for footer links */
        .footer-links:hover {
            color: #ff6b35 !important;
            transform: translateX(5px);
            display: inline-block;
        }
        
        .social-icon:hover {
            background: #ff6b35 !important;
            transform: translateY(-3px);
        }
        
        .newsletter-btn:hover {
            background: #e55a2b !important;
            transform: translateY(-2px);
        }
    </style>
    
    <script>
        // Auto-hide alerts after 3 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                alert.style.transition = 'opacity 0.5s ease';
                alert.style.opacity = '0';
                setTimeout(function() {
                    alert.remove();
                }, 500);
            });
        }, 3000);
        
        // Add loading effect on form submission
        document.querySelectorAll('form').forEach(function(form) {
            form.addEventListener('submit', function() {
                const button = form.querySelector('button[type="submit"]');
                if (button) {
                    const originalText = button.innerHTML;
                    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                    button.disabled = true;
                    
                    setTimeout(function() {
                        if (button.disabled) {
                            button.innerHTML = originalText;
                            button.disabled = false;
                        }
                    }, 5000);
                }
            });
        });
        
        // Confirm delete function
        function confirmDelete(url) {
            if (confirm('Are you sure you want to delete this item?')) {
                window.location.href = url;
            }
        }
        
        // Add hover effect for all footer links
        document.querySelectorAll('.footer-section a, .footer-section ul li a').forEach(function(link) {
            link.addEventListener('mouseenter', function() {
                this.style.color = '#ff6b35';
                this.style.transform = 'translateX(5px)';
                this.style.display = 'inline-block';
            });
            link.addEventListener('mouseleave', function() {
                this.style.color = '#adb5bd';
                this.style.transform = 'translateX(0)';
            });
        });
    </script>
</body>
</html>