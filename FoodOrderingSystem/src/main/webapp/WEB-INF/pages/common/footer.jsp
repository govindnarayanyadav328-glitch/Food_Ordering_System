 </div>
    
    <footer class="footer">
        <div class="footer-content">
            <!-- Column 1: About FoodieHub -->
            <div class="footer-section">
                <h3><i class="fas fa-utensils"></i> About FoodieHub</h3>
                <p>Your favorite food delivery service. Fresh, fast, and delicious meals delivered to your doorstep.</p>
                <div class="footer-social" style="margin-top: 1rem;">
                    <a href="#" style="margin-right: 1rem;"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" style="margin-right: 1rem;"><i class="fab fa-instagram"></i></a>
                    <a href="#" style="margin-right: 1rem;"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            
            <!-- Column 2: Quick Links -->
            <div class="footer-section">
                <h3><i class="fas fa-link"></i> Quick Links</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/Home"><i class="fas fa-chevron-right"></i> Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/menu"><i class="fas fa-chevron-right"></i> Menu</a></li>
                    <% if (session.getAttribute("user") == null) { %>
                        <li><a href="${pageContext.request.contextPath}/Login"><i class="fas fa-chevron-right"></i> Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/register"><i class="fas fa-chevron-right"></i> Register</a></li>
                    <% } else { %>
                        <li><a href="${pageContext.request.contextPath}/Cart"><i class="fas fa-chevron-right"></i> Cart</a></li>
                    <% } %>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Offers</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Blog</a></li>
                </ul>
            </div>
            
            <!-- Column 3: Contact Us -->
            <div class="footer-section">
                <h3><i class="fas fa-headset"></i> Contact Us</h3>
                <ul class="contact-info">
                    <li><i class="fas fa-phone-alt"></i> <a href="tel:+9779800000000">+977 9800000000</a></li>
                    <li><i class="fas fa-envelope"></i> <a href="mailto:info@foodiehub.com">info@foodiehub.com</a></li>
                    <li><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</li>
                    <li><i class="fas fa-clock"></i> Mon-Sun: 10:00 AM - 10:00 PM</li>
                </ul>
            </div>
            
            <!-- Column 4: Newsletter Subscription -->
            <div class="footer-section">
                <h3><i class="fas fa-envelope-open-text"></i> Subscribe to Our Daily Newsletter</h3>
                <p style="margin-bottom: 1rem;">Get latest updates about new dishes, offers and events!</p>
                
                <form id="newsletterForm" onsubmit="return subscribeNewsletter(event)">
                    <div style="display: flex; gap: 0.5rem; margin-bottom: 0.5rem;">
                        <input type="email" id="newsletterEmail" placeholder="Your email address" required 
                               style="flex: 1; padding: 0.75rem; border: none; border-radius: 8px; background: #f8f9fa;">
                        <button type="submit" style="padding: 0.75rem 1.5rem; background: #ff6b35; color: white; border: none; border-radius: 8px; cursor: pointer; transition: all 0.3s;">
                            <i class="fas fa-paper-plane"></i> Subscribe
                        </button>
                    </div>
                    <div id="newsletterMessage" style="font-size: 0.75rem; margin-top: 0.5rem;"></div>
                </form>
                
                <div style="margin-top: 1rem; font-size: 0.75rem; color: #adb5bd;">
                    <i class="fas fa-lock"></i> We never share your email with anyone
                </div>
            </div>
        </div>
        
        <!-- Footer Bottom -->
        <div class="footer-bottom">
            <p>&copy; 2024 FoodieHub. All rights reserved. | <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a></p>
        </div>