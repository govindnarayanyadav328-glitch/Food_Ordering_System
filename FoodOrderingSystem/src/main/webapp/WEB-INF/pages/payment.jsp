<%@ page import="java.util.*, com.food.model.CartItem" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("pageTitle", "Payment");
    
    // Get cart from session
    ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
    
    // Calculate total
    double grandTotal = 0;
    if (cart != null) {
        for (CartItem item : cart) {
            grandTotal += item.getPrice() * item.getQuantity();
        }
    }
    
    // Get user from session - use different variable name to avoid conflict
    String loggedInUser = (String) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect("Login");
        return;
    }
    
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("Cart");
        return;
    }
%>
<%@ include file="common/header.jsp" %>

<style>
    .payment-container {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 2rem;
        margin: 2rem 0;
    }
    
    .payment-methods {
        background: white;
        border-radius: 16px;
        padding: 1.5rem;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .order-summary {
        background: white;
        border-radius: 16px;
        padding: 1.5rem;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        position: sticky;
        top: 100px;
        height: fit-content;
    }
    
    .payment-method {
        border: 2px solid #e9ecef;
        border-radius: 12px;
        padding: 1rem;
        margin-bottom: 1rem;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        gap: 1rem;
    }
    
    .payment-method:hover {
        border-color: #ff6b35;
        background: #fff8f5;
    }
    
    .payment-method.selected {
        border-color: #ff6b35;
        background: #fff8f5;
        box-shadow: 0 0 0 3px rgba(255,107,53,0.1);
    }
    
    .payment-method-icon {
        font-size: 2rem;
        width: 60px;
        text-align: center;
    }
    
    .payment-method-info h4 {
        margin: 0 0 0.25rem 0;
        color: #2c3e50;
    }
    
    .payment-method-info p {
        margin: 0;
        font-size: 0.875rem;
        color: #6c757d;
    }
    
    .payment-details {
        margin-top: 1.5rem;
        padding-top: 1.5rem;
        border-top: 1px solid #e9ecef;
    }
    
    .form-group {
        margin-bottom: 1rem;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 600;
        color: #2c3e50;
    }
    
    .form-group input, .form-group select {
        width: 100%;
        padding: 0.75rem;
        border: 2px solid #e9ecef;
        border-radius: 8px;
        font-size: 1rem;
        transition: all 0.3s;
    }
    
    .form-group input:focus, .form-group select:focus {
        outline: none;
        border-color: #ff6b35;
    }
    
    .order-item {
        display: flex;
        justify-content: space-between;
        padding: 0.75rem 0;
        border-bottom: 1px solid #e9ecef;
    }
    
    .order-total {
        margin-top: 1rem;
        padding-top: 1rem;
        border-top: 2px solid #ff6b35;
        font-size: 1.25rem;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
    }
    
    .pay-btn {
        width: 100%;
        padding: 1rem;
        background: #ff6b35;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 1.1rem;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s;
        margin-top: 1rem;
    }
    
    .pay-btn:hover {
        background: #e55a2b;
        transform: translateY(-2px);
    }
    
    .bank-logos {
        display: flex;
        gap: 1rem;
        flex-wrap: wrap;
        margin-top: 1rem;
    }
    
    .bank-btn {
        flex: 1;
        padding: 0.75rem;
        background: #f8f9fa;
        border: 2px solid #e9ecef;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s;
        text-align: center;
    }
    
    .bank-btn:hover, .bank-btn.selected {
        border-color: #ff6b35;
        background: #fff8f5;
    }
    
    @media (max-width: 768px) {
        .payment-container {
            grid-template-columns: 1fr;
        }
        
        .order-summary {
            position: static;
        }
    }
</style>

<div class="payment-container">
    <!-- Payment Methods -->
    <div class="payment-methods">
        <h2><i class="fas fa-credit-card"></i> Select Payment Method</h2>
        <p style="color: #6c757d; margin-bottom: 1.5rem;">Choose your preferred payment option</p>
        
        <!-- Khalti -->
        <div class="payment-method" data-method="khalti" onclick="selectMethod('khalti')">
            <div class="payment-method-icon">
                <i class="fas fa-wallet" style="color: #5c2d91;"></i>
            </div>
            <div class="payment-method-info">
                <h4>Khalti Digital Wallet</h4>
                <p>Pay using Khalti wallet - Fast & Secure</p>
            </div>
        </div>
        
        <!-- eSewa -->
        <div class="payment-method" data-method="esewa" onclick="selectMethod('esewa')">
            <div class="payment-method-icon">
                <i class="fas fa-rupee-sign" style="color: #2c8c3e;"></i>
            </div>
            <div class="payment-method-info">
                <h4>eSewa</h4>
                <p>Pay with eSewa digital wallet</p>
            </div>
        </div>
        
        <!-- Credit/Debit Card -->
        <div class="payment-method" data-method="card" onclick="selectMethod('card')">
            <div class="payment-method-icon">
                <i class="fas fa-credit-card" style="color: #1a73e8;"></i>
            </div>
            <div class="payment-method-info">
                <h4>Credit / Debit Card</h4>
                <p>Visa, MasterCard, American Express</p>
            </div>
        </div>
        
        <!-- eBanking -->
        <div class="payment-method" data-method="ebanking" onclick="selectMethod('ebanking')">
            <div class="payment-method-icon">
                <i class="fas fa-university" style="color: #d4af37;"></i>
            </div>
            <div class="payment-method-info">
                <h4>eBanking</h4>
                <p>Direct bank transfer from your account</p>
            </div>
        </div>
        
        <!-- Payment Details Section (Dynamic) -->
        <div id="paymentDetails" class="payment-details">
            <p style="text-align: center; color: #6c757d;">
                <i class="fas fa-hand-pointer"></i> Please select a payment method above
            </p>
        </div>
    </div>
    
    <!-- Order Summary -->
    <div class="order-summary">
        <h3><i class="fas fa-shopping-bag"></i> Order Summary</h3>
        
        <div style="margin-top: 1rem;">
            <% if (cart != null) {
                for (CartItem item : cart) { %>
                    <div class="order-item">
                        <span><%= item.getName() %> x <%= item.getQuantity() %></span>
                        <span>Rs. <%= item.getPrice() * item.getQuantity() %></span>
                    </div>
            <% } } %>
        </div>
        
        <div class="order-total">
            <span>Total Amount:</span>
            <span style="color: #ff6b35;">Rs. <%= grandTotal %></span>
        </div>
        
        <form id="paymentForm" action="${pageContext.request.contextPath}/process-payment" method="post">
            <input type="hidden" name="paymentMethod" id="paymentMethod" value="">
            <input type="hidden" name="totalAmount" value="<%= grandTotal %>">
            
            <button type="button" id="payBtn" class="pay-btn" onclick="processPayment()">
                <i class="fas fa-lock"></i> Pay Rs. <%= grandTotal %>
            </button>
        </form>
        
        <p style="text-align: center; font-size: 0.75rem; color: #6c757d; margin-top: 1rem;">
            <i class="fas fa-shield-alt"></i> Secure payment processing
        </p>
    </div>
</div>

<script>
    let selectedPaymentMethod = '';
    
    function selectMethod(method) {
        selectedPaymentMethod = method;
        
        // Remove selected class from all methods
        document.querySelectorAll('.payment-method').forEach(el => {
            el.classList.remove('selected');
        });
        
        // Add selected class to clicked method
        document.querySelector(`[data-method="${method}"]`).classList.add('selected');
        
        // Update hidden input
        document.getElementById('paymentMethod').value = method;
        
        // Show payment details based on method
        showPaymentDetails(method);
    }
    
    function showPaymentDetails(method) {
        const detailsDiv = document.getElementById('paymentDetails');
        
        if (method === 'khalti') {
            detailsDiv.innerHTML = `
                <h4 style="margin-bottom: 1rem;"><i class="fas fa-wallet"></i> Khalti Payment</h4>
                <div class="form-group">
                    <label>Khalti Mobile Number</label>
                    <input type="tel" id="khaltiNumber" placeholder="98XXXXXXXX" pattern="[0-9]{10}">
                </div>
                <div class="form-group">
                    <label>Khalti PIN</label>
                    <input type="password" id="khaltiPin" placeholder="Enter your Khalti PIN" maxlength="4">
                </div>
                <div class="bank-logos">
                    <div style="text-align: center; width: 100%; padding: 1rem; background: #f8f9fa; border-radius: 8px;">
                        <i class="fas fa-shield-alt"></i> Powered by Khalti Digital Wallet
                    </div>
                </div>
            `;
        } 
        else if (method === 'esewa') {
            detailsDiv.innerHTML = `
                <h4 style="margin-bottom: 1rem;"><i class="fas fa-rupee-sign"></i> eSewa Payment</h4>
                <div class="form-group">
                    <label>eSewa Mobile Number / Email</label>
                    <input type="text" id="esewaId" placeholder="98XXXXXXXX or email@example.com">
                </div>
                <div class="form-group">
                    <label>eSewa Password</label>
                    <input type="password" id="esewaPassword" placeholder="Enter your eSewa password">
                </div>
                <div class="bank-logos">
                    <div style="text-align: center; width: 100%; padding: 1rem; background: #f8f9fa; border-radius: 8px;">
                        <i class="fas fa-check-circle"></i> Pay with eSewa - Instant & Secure
                    </div>
                </div>
            `;
        }
        else if (method === 'card') {
            detailsDiv.innerHTML = `
                <h4 style="margin-bottom: 1rem;"><i class="fas fa-credit-card"></i> Card Details</h4>
                <div class="form-group">
                    <label>Card Number</label>
                    <input type="text" id="cardNumber" placeholder="1234 5678 9012 3456" maxlength="19">
                </div>
                <div class="form-group">
                    <label>Cardholder Name</label>
                    <input type="text" id="cardName" placeholder="Name on card">
                </div>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                    <div class="form-group">
                        <label>Expiry Date</label>
                        <input type="text" id="expiryDate" placeholder="MM/YY" maxlength="5">
                    </div>
                    <div class="form-group">
                        <label>CVV</label>
                        <input type="password" id="cvv" placeholder="123" maxlength="4">
                    </div>
                </div>
                <div class="bank-logos">
                    <div class="bank-btn"><i class="fab fa-cc-visa"></i> Visa</div>
                    <div class="bank-btn"><i class="fab fa-cc-mastercard"></i> MasterCard</div>
                    <div class="bank-btn"><i class="fab fa-cc-amex"></i> Amex</div>
                </div>
            `;
        }
        else if (method === 'ebanking') {
            detailsDiv.innerHTML = `
                <h4 style="margin-bottom: 1rem;"><i class="fas fa-university"></i> Select Your Bank</h4>
                <div class="bank-logos" style="flex-direction: column;">
                    <div class="bank-btn" onclick="selectBank('nabil')">
                        <i class="fas fa-building"></i> Nabil Bank
                    </div>
                    <div class="bank-btn" onclick="selectBank('prabhu')">
                        <i class="fas fa-building"></i> Prabhu Bank
                    </div>
                    <div class="bank-btn" onclick="selectBank('global')">
                        <i class="fas fa-building"></i> Global IME Bank
                    </div>
                    <div class="bank-btn" onclick="selectBank('siddhartha')">
                        <i class="fas fa-building"></i> Siddhartha Bank
                    </div>
                    <div class="bank-btn" onclick="selectBank('nepal')">
                        <i class="fas fa-building"></i> Nepal Bank Limited
                    </div>
                </div>
                <input type="hidden" id="selectedBank" value="">
                <div class="form-group" style="margin-top: 1rem;">
                    <label>Account Number</label>
                    <input type="text" id="accountNumber" placeholder="Enter your account number">
                </div>
            `;
        }
    }
    
    function selectBank(bank) {
        document.getElementById('selectedBank').value = bank;
        // Remove selected class from all bank buttons
        document.querySelectorAll('.bank-btn').forEach(btn => {
            btn.classList.remove('selected');
        });
        // Add selected class to clicked button
        event.target.classList.add('selected');
    }
    
    function processPayment() {
        if (!selectedPaymentMethod) {
            alert('Please select a payment method');
            return;
        }
        
        // Validate based on payment method
        if (selectedPaymentMethod === 'khalti') {
            const khaltiNumber = document.getElementById('khaltiNumber')?.value;
            const khaltiPin = document.getElementById('khaltiPin')?.value;
            if (!khaltiNumber || !khaltiPin) {
                alert('Please enter your Khalti number and PIN');
                return;
            }
            if (khaltiNumber.length !== 10) {
                alert('Please enter a valid 10-digit Khalti number');
                return;
            }
        }
        
        if (selectedPaymentMethod === 'esewa') {
            const esewaId = document.getElementById('esewaId')?.value;
            const esewaPassword = document.getElementById('esewaPassword')?.value;
            if (!esewaId || !esewaPassword) {
                alert('Please enter your eSewa ID/Number and password');
                return;
            }
        }
        
        if (selectedPaymentMethod === 'card') {
            const cardNumber = document.getElementById('cardNumber')?.value;
            const cardName = document.getElementById('cardName')?.value;
            const expiryDate = document.getElementById('expiryDate')?.value;
            const cvv = document.getElementById('cvv')?.value;
            
            if (!cardNumber || !cardName || !expiryDate || !cvv) {
                alert('Please fill all card details');
                return;
            }
            if (cardNumber.replace(/\s/g, '').length < 15) {
                alert('Please enter a valid card number');
                return;
            }
            if (cvv.length < 3) {
                alert('Please enter a valid CVV');
                return;
            }
        }
        
        if (selectedPaymentMethod === 'ebanking') {
            const bank = document.getElementById('selectedBank')?.value;
            const accountNumber = document.getElementById('accountNumber')?.value;
            if (!bank || !accountNumber) {
                alert('Please select a bank and enter account number');
                return;
            }
        }
        
        // Show loading
        const payBtn = document.getElementById('payBtn');
        const originalText = payBtn.innerHTML;
        payBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing Payment...';
        payBtn.disabled = true;
        
        // Simulate payment processing (in real implementation, this would call actual API)
        setTimeout(() => {
            // Submit the form to process order
            document.getElementById('paymentForm').submit();
        }, 2000);
    }
</script>

<%@ include file="common/footer.jsp" %>