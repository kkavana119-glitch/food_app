<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ page import="com.food.Model.Cart, com.food.Model.CartItem"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Secure Checkout - FoodieExpress</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght=300;400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

    <link rel="stylesheet" href="checkout.css" />
  </head>
  <body>
    
    <%
      // Retrieve cart and details from session
      Cart cart = (Cart) session.getAttribute("cart");
      Integer restaurantId = (Integer) session.getAttribute("restaurantId");

      double itemTotal = 0;
      if (cart != null && !cart.getItems().isEmpty()) {
          for (CartItem item : cart.getItems().values()) {
              itemTotal += item.getPrice() * item.getQuantity();
          }
      }

      double deliveryFee = itemTotal > 0 ? 40 : 0;
      double packagingFee = itemTotal > 0 ? 20 : 0;
      
      double grandTotal = itemTotal + deliveryFee + packagingFee;
    %>

    <div class="page-header">
      <h1>
        <i class="fa-solid fa-bag-shopping"></i> Checkout
      </h1>
      <p>Complete your order by providing your details and payment information</p>
    </div>

    <div class="checkout-container">
      
     <form id="checkoutForm" action="checkout" method="post" class="checkout-form-wrapper">
        <div class="checkout-left">
          
          <div class="card">
            <h2>
              <i class="fa-solid fa-location-dot"></i> Delivery Address
            </h2>

            <div class="input-row">
              <div class="input-box">
                <i class="fa-regular fa-user"></i>
                <input type="text" name="fullName" placeholder="Full Name" required />
              </div>

              <div class="input-box">
                <i class="fa-solid fa-phone"></i>
                <input type="tel" name="phone" placeholder="Phone Number" required />
              </div>
            </div>

            <div class="textarea-box">
              <i class="fa-solid fa-house"></i>
              <textarea name="address" placeholder="Enter Delivery Address" required></textarea>
            </div>

            <div class="input-row">
              <div class="input-box">
                <i class="fa-solid fa-building"></i>
                <input type="text" name="city" placeholder="City" required />
              </div>

              <div class="input-box">
                <i class="fa-solid fa-location-crosshairs"></i>
                <input type="text" name="pincode" placeholder="Pincode" required />
              </div>
            </div>
          </div>

          <div class="card">
            <h2>
              <i class="fa-regular fa-credit-card"></i> Payment Method
            </h2>

            <label class="payment-card">
              <input type="radio" name="paymentMethod" value="Cash" checked />
              <div class="radio-circle"></div>
              <div class="payment-icon"><i class="fa-solid fa-wallet"></i></div>
              <div class="payment-info">
                <h4>Cash on Delivery</h4>
                <p>Pay when your order is delivered</p>
              </div>
            </label>

            <label class="payment-card">
              <input type="radio" name="paymentMethod" value="UPI" />
              <div class="radio-circle"></div>
              <div class="payment-icon"><i class="fa-brands fa-google-pay"></i></div>
              <div class="payment-info">
                <h4>UPI Payment</h4>
                <p>Pay using any UPI app</p>
              </div>
            </label>

            <label class="payment-card">
              <input type="radio" name="paymentMethod" value="Card" />
              <div class="radio-circle"></div>
              <div class="payment-icon"><i class="fa-regular fa-credit-card"></i></div>
              <div class="payment-info">
                <h4>Credit / Debit Card</h4>
                <p>Visa, Mastercard, Rupay & more</p>
              </div>
            </label>

            <label class="payment-card">
              <input type="radio" name="paymentMethod" value="NETBANKING" />
              <div class="radio-circle"></div>
              <div class="payment-icon"><i class="fa-solid fa-building-columns"></i></div>
              <div class="payment-info">
                <h4>Net Banking</h4>
                <p>Pay using your preferred bank</p>
              </div>
            </label>
          </div>
        </div>

        <div class="checkout-right">
          <div class="summary-card">
            <h2>
              <i class="fa-regular fa-clipboard"></i> Order Summary
            </h2>

            <div class="order-items-list">
              <%
              if (cart != null && !cart.getItems().isEmpty()) {
                  for (CartItem item : cart.getItems().values()) {
              %>
              <div class="order-item">
                <img src="<%=item.getImagePath()%>" alt="<%=item.getName()%>" />
                <div class="order-details">
                  <h4><%=item.getName()%></h4>
                  <p>Qty: <%=item.getQuantity()%></p>
                </div>
                <span>₹<%=item.getPrice() * item.getQuantity()%></span>
              </div>
              <% 
                  }
              } else { 
              %>
              <p class="empty-msg">No items in cart.</p>
              <% } %>
            </div>

            <hr />

            <div class="summary-row">
              <span>Item Subtotal</span>
              <span>₹<%=String.format("%.2f", itemTotal)%></span>
            </div>

            <div class="summary-row">
              <span>Delivery Fee</span>
              <span>₹<%=String.format("%.2f", deliveryFee)%></span>
            </div>

            <div class="summary-row">
              <span>Packaging Fee</span>
              <span>₹<%=String.format("%.2f", packagingFee)%></span>
            </div>

            <div class="total-box">
              <span>Total Amount</span>
              <h3>₹<%=String.format("%.2f", grandTotal)%></h3>
            </div>

            <div class="secure-box">
              <i class="fa-solid fa-shield-heart"></i>
              <div>
                <h4>Safe and Secure Payments</h4>
                <p>Your payment information is protected</p>
              </div>
            </div>
            
            <%session.setAttribute("grandTotal", grandTotal); %>
            
            <input type="hidden" name="restaurantId" value="<%= restaurantId%>">
            <input type="hidden" name="grandTotal" value="<%= grandTotal%>">

          
            <button type="submit" id="placeOrderBtn" class="place-order" <%= (cart == null || cart.getItems().isEmpty()) ? "disabled style='opacity:0.5; cursor:not-allowed;'" : "" %>>
              <i class="fa-solid fa-lock" ></i> Place Order
            </button>
         
        

            <p class="terms">
              By placing an order, you agree to our Terms & Conditions
            </p>
          </div>
        </div>
      </form>

    </div>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script>

document.getElementById("checkoutForm").addEventListener("submit", function(e){

    var paymentMethod = document.querySelector("input[name='paymentMethod']:checked").value;

    // Cash on Delivery
    if(paymentMethod === "Cash"){
        return true;
    }

    e.preventDefault();

    fetch("CreateOrderServlet", {

        method: "POST",

        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },

        body: "amount=<%=grandTotal%>"

    })

    .then(response => response.json())

    .then(data => {

        console.log("Order Response:", data);

        var options = {

            key: "rzp_test_xxxxxxxxxxxxxxx",

            amount: data.amount,

            currency: data.currency,

            order_id: data.id,

            name: "FoodieExpress",

            description: "Food Order",

            prefill: {

                name: document.querySelector("input[name='fullName']").value,

                contact: document.querySelector("input[name='phone']").value,

                email: "test@example.com"

            },

            theme: {

                color: "#3399cc"

            },

            handler: function (response) {

                alert("Payment Successful");

                console.log(response);

                document.getElementById("checkoutForm").submit();

            }

        };

        var rzp = new Razorpay(options);

        rzp.on('payment.failed', function (response) {

            console.log(response);

            alert(
                "Error Code : " + response.error.code +
                "\nDescription : " + response.error.description +
                "\nSource : " + response.error.source +
                "\nStep : " + response.error.step +
                "\nReason : " + response.error.reason
            );

        });

        rzp.open();

    })

    .catch(function(error){

        console.log(error);

        alert("Unable to create Razorpay Order");

    });

});

</script>
  </body>
</html>