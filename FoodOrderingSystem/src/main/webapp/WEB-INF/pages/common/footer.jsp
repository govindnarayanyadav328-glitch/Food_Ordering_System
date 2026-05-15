    </div>
    
    <footer style="
        background: #2c3e50;
        color: #ffffff;
        padding: 3rem 0 1.5rem;
        margin-top: 3rem;
        width: 100%;
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
                <h3 style="margin-bottom: 1rem; color: #ff6b35; font-size: 1.2rem;">
                    <i class="fas fa-utensils"></i> About FoodieHub
                </h3>
                <p style="color: #adb5bd; font-size: 0.9rem; line-height: 1.6; margin-bottom: 1rem;">
                    Your favorite food delivery service. Fresh, fast, and delicious meals delivered to your doorstep.
                </p>
                <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                    <a href="#" style="display: inline-flex; align-items: center; justify-content: center; width: 38px; height: 38px; background: rgba(255,255,255,0.1); border-radius: 50%; transition: all 0.3s; color: white; text-decoration: none;">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" style="display: inline-flex; align-items: center; justify-content: center; width: 38px; height: 38px; background: rgba(255,255,255,0.1); border-radius: 50%; transition: all 0.3s; color: white; text-decoration: none;">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" style="display: inline-flex; align-items: center; justify-content: center; width: 38px; height: 38px; background: rgba(255,255,255,0.1); border-radius: 50%; transition: all 0.3s; color: white; text-decoration: none;">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" style="display: inline-flex; align-items: center; justify-content: center; width: 38px; height: 38px; background: rgba(255,255,255,0.1); border-radius: 50%; transition: all 0.3s; color: white; text-decoration: none;">
                        <i class="fab fa-youtube"></i>
                    </a>
                </div>
            </div>
            
            <!-- Column 2: Quick Links -->
            <div>
                <h3 style="margin-bottom: 1rem; color: #ff6b35; font-size: 1.2rem;">
                    <i class="fas fa-link"></i> Quick Links
                </h3>
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <li style="margin-bottom: 0.5rem;">
                        <a href="${pageContext.request.contextPath}/Home" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                            <i class="fas fa-chevron-right" style="font-size: 0.75rem; margin-right: 0.5rem;"></i> Home
                        </a>
                    </li>
                    <li style="margin-bottom: 0.5rem;">
                        <a href="${pageContext.request.contextPath}/menu" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                            <i class="fas fa-chevron-right" style="font-size: 0.75rem; margin-right: 0.5rem;"></i> Menu
                        </a>
                    </li>
                    <li style="margin-bottom: 0.5rem;">
                        <a href="${pageContext.request.contextPath}/Cart" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                            <i class="fas fa-chevron-right" style="font-size: 0.75rem; margin-right: 0.5rem;"></i> Cart
                        </a>
                    </li>
                    <li style="margin-bottom: 0.5rem;">
                        <a href="#" style="color: #adb5bd; text-decoration: none; transition: all 0.3s;">
                            <i class="fas fa-chevron-right" style="font-size: 0.75rem; margin-right: 0.5rem;"></i> Offers
                        </a>
                    </li>
                </ul>
            </div>
            
            <!-- Column 3: Contact Us -->
            <div>
                <h3 style="margin-bottom: 1rem; color: #ff6b35; font-size: 1.2rem;">
                    <i class="fas fa-headset"></i> Contact Us
                </h3>
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <li style="margin-bottom: 0.5rem; color: #adb5bd;">
                        <i class="fas fa-phone-alt" style="width: 25px; margin-right: 0.5rem; color: #ff6b35;"></i> +977 9800000000
                    </li>
                    <li style="margin-bottom: 0.5rem; color: #adb5bd;">
                        <i class="fas fa-envelope" style="width: 25px; margin-right: 0.5rem; color: #ff6b35;"></i> info@foodiehub.com
                    </li>
                    <li style="margin-bottom: 0.5rem; color: #adb5bd;">
                        <i class="fas fa-map-marker-alt" style="width: 25px; margin-right: 0.5rem; color: #ff6b35;"></i> Kathmandu, Nepal
                    </li>
                    <li style="margin-bottom: 0.5rem; color: #adb5bd;">
                        <i class="fas fa-clock" style="width: 25px; margin-right: 0.5rem; color: #ff6b35;"></i> Mon-Sun: 10AM - 10PM
                    </li>
                </ul>
            </div>
            
            <!-- Column 4: Newsletter Subscription -->
            <div>
                <h3 style="margin-bottom: 1rem; color: #ff6b35; font-size: 1.2rem;">
                    <i class="fas fa-envelope-open-text"></i> Subscribe to Our Daily Newsletter
                </h3>
                <p style="color: #adb5bd; font-size: 0.9rem; margin-bottom: 0.5rem;">Get latest updates about new dishes, offers and events!</p>
                <form class="newsletter-form" onsubmit="subscribeNewsletter(event)" style="display: flex; gap: 0.5rem; margin-top: 0.5rem;">
                    <input type="email" id="newsletterEmail" placeholder="Your email address" required style="flex: 1; padding: 0.6rem 0.8rem; border: none; border-radius: 8px; font-size: 0.85rem; background: #f8f9fa; outline: none;">
                    <button type="submit" style="padding: 0.6rem 1rem; background: #ff6b35; color: white; border: none; border-radius: 8px; cursor: pointer; transition: all 0.3s;">
                        <i class="fas fa-paper-plane"></i> Subscribe
                    </button>
                </form>
                <div id="newsletterMessage" style="font-size: 0.7rem; margin-top: 0.5rem;"></div>
                <div style="margin-top: 0.8rem; font-size: 0.7rem; color: #adb5bd;">
                    <i class="fas fa-lock"></i> We never share your email
                </div>
            </div>
        </div>
        
        <div style="
            text-align: center;
            padding-top: 2rem;
            margin-top: 2rem;
            border-top: 1px solid rgba(255,255,255,0.1);
            font-size: 0.8rem;
            color: #adb5bd;
        ">
            <p>&copy; 2024 FoodieHub. All rights reserved. | <a href="#" style="color: #adb5bd; text-decoration: none;">Privacy Policy</a> | <a href="#" style="color: #adb5bd; text-decoration: none;">Terms of Service</a></p>
        </div>
    </footer>

    <style>
        /* Hover effects for social icons */
        .footer-social-icons a:hover {
            transform: translateY(-3px);
        }
        
        /* Newsletter button hover */
        .newsletter-btn:hover {
            background: #e55a2b !important;
            transform: translateY(-2px);
        }
        
        /* Link hover effects */
        .footer-links a:hover {
            color: #ff6b35 !important;
            padding-left: 5px;
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
        
        // Confirm delete function
        function confirmDelete(url) {
            if (confirm('Are you sure you want to delete this item?')) {
                window.location.href = url;
            }
        }
        
        // Newsletter Subscription Function
        function subscribeNewsletter(event) {
            event.preventDefault();
            const email = document.getElementById('newsletterEmail').value;
            const messageDiv = document.getElementById('newsletterMessage');
            
            if (!email) {
                messageDiv.innerHTML = '<span style="color: #e74c3c;"><i class="fas fa-exclamation-circle"></i> Please enter your email</span>';
                return false;
            }
            
            if (!email.includes('@') || !email.includes('.')) {
                messageDiv.innerHTML = '<span style="color: #e74c3c;"><i class="fas fa-exclamation-circle"></i> Enter a valid email</span>';
                return false;
            }
            
            messageDiv.innerHTML = '<span style="color: #27ae60;"><i class="fas fa-spinner fa-spin"></i> Subscribing...</span>';
            
            setTimeout(function() {
                messageDiv.innerHTML = '<span style="color: #27ae60;"><i class="fas fa-check-circle"></i> Subscribed successfully!</span>';
                document.getElementById('newsletterEmail').value = '';
                
                setTimeout(function() {
                    messageDiv.innerHTML = '';
                }, 5000);
            }, 1500);
            
            return false;
        }
        
        // Social icon hover effects
        document.querySelectorAll('.footer-social-icons a').forEach(icon => {
            icon.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-3px)';
            });
            icon.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    </script>
</body>
</html>