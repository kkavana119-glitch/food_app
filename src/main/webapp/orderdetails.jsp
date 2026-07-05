<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.food.Model.*"%>

<%
Orders order = (Orders) request.getAttribute("order");
List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");

if (order == null || items == null) {
%>
    <h2 style="text-align:center; color:red;">
        No Order Data Found. Please try again.
    </h2>
<%
    return;
}

String currentStatus = "";
if (order.getStatus() != null) {
    currentStatus = order.getStatus().trim().toLowerCase();
} else {
    currentStatus = "pending";
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Invoice Summary | FoodExpress</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<style>
    :root {
        --brand-gradient: linear-gradient(135deg, #ff6b35 0%, #ff4f14 100%);
        --primary: #ff5a36;
        --primary-light: #fff0ec;
        --bg-main: #f4f7fa;
        --surface: #ffffff;
        
        /* Modern UI Slate Colors */
        --text-heading: #0f172a;
        --text-body: #334155;
        --text-muted: #64748b;
        --border: #e2e8f0;
        
        /* Status Dynamic Colors */
        --success: #10b981;
        --success-bg: #ecfdf5;
        --warning: #f59e0b;
        --warning-bg: #fffbeb;
        --danger: #ef4444;
        --danger-bg: #fef2f2;
        
        --radius-lg: 16px;
        --radius-md: 12px;
        --shadow-sm: 0 4px 6px -1px rgba(15, 23, 42, 0.05);
        --shadow-md: 0 10px 25px -5px rgba(15, 23, 42, 0.08);
        --transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
    }

    html, body {
        background-color: var(--bg-main);
        min-height: 100vh;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: 'Plus Jakarta Sans', sans-serif;
        color: var(--text-body);
        -webkit-font-smoothing: antialiased;
    }

    .container {
        max-width: 900px;
        margin: 0 auto;
        padding: 50px 24px;
    }

    /* Top Layout Navbar/Header wrapper */
    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 32px;
    }

    /* Changed Main Title to Orange Gradient */
    .page-title h2 {
        margin: 0 0 4px 0;
        font-size: 32px;
        font-weight: 800;
        background: var(--brand-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        letter-spacing: -0.5px;
    }

    .page-title p {
        margin: 0;
        color: var(--text-muted);
        font-size: 14px;
    }

    .order-id-pill {
        background: var(--surface);
        padding: 10px 18px;
        border-radius: var(--radius-md);
        box-shadow: var(--shadow-sm);
        border: 1px solid var(--border);
        font-weight: 700;
        font-size: 14px;
        color: var(--text-heading);
    }
    
    .order-id-pill span {
        color: var(--primary);
    }

    /* Info Grid Layout Cards */
    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
        gap: 24px;
        margin-bottom: 32px;
    }

    .card {
        background: var(--surface);
        border-radius: var(--radius-lg);
        padding: 28px;
        box-shadow: var(--shadow-md);
        border: 1px solid rgba(226, 232, 240, 0.8);
        transition: var(--transition);
        position: relative;
        overflow: hidden;
    }

    .card:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 30px -5px rgba(15, 23, 42, 0.12);
    }

    /* Fixed header layout rules for smaller grid cards */
    .card-header-group {
        display: flex;
        align-items: center;
        gap: 12px;
        margin: -28px -28px 20px -28px;
        padding: 16px 24px;
        background-color: #f8fafc;
        border-bottom: 1px solid var(--border);
    }

    /* Fixed header layout rules for the large Checklist Card */
    .checklist-card-header {
        display: flex;
        align-items: center;
        gap: 14px;
        margin: 0;
        padding: 24px 28px;
        background-color: #fff7ed;
        border-bottom: 1px solid #ffedd5;
    }

    .card-icon-wrapper {
        width: 32px;
        height: 32px;
        border-radius: 6px;
        background: var(--primary-light);
        color: var(--primary);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .card h3 {
        margin: 0;
        font-size: 15px;
        font-weight: 700;
        color: var(--text-heading);
    }

    .data-row {
        display: flex;
        flex-direction: column;
        gap: 4px;
    }

    .data-label {
        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: var(--text-muted);
        font-weight: 600;
    }

    .data-value {
        font-size: 16px;
        font-weight: 600;
        color: var(--text-heading);
    }

    /* Smart Status Pill Rules Engine */
    .status-badge {
        display: inline-flex;
        align-items: center;
        padding: 6px 14px;
        border-radius: 30px;
        font-size: 13px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    /* Dynamic styling via status state classes */
    .status-delivered { background-color: var(--success-bg); color: var(--success); }
    .status-pending, .status-processing { background-color: var(--warning-bg); color: var(--warning); }
    .status-cancelled { background-color: var(--danger-bg); color: var(--danger); }
    .status-default { background-color: var(--border); color: var(--text-body); }

    /* Modern Minimalist Table View */
    .table-container {
        width: 100%;
        overflow-x: auto;
    }

    table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        text-align: left;
    }

    th {
        background-color: #f8fafc;
        color: var(--text-muted);
        font-weight: 700;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        padding: 16px 24px;
        border-bottom: 2px solid var(--border);
    }

    td {
        padding: 20px 24px;
        border-bottom: 1px solid var(--border);
        color: var(--text-body);
        font-size: 15px;
        vertical-align: middle;
    }

    tr:last-child td {
        border-bottom: none;
    }

    .item-title-meta {
        font-weight: 700;
        color: var(--text-heading);
    }

    .text-right { text-align: right; }
    .text-center { text-align: center; }

    /* Summary Financials Segment */
    .summary-bill-box {
        display: flex;
        justify-content: flex-end;
        margin-top: 24px;
        padding: 24px;
        background: #f8fafc;
        border-radius: var(--radius-md);
        border: 1px dashed var(--border);
    }

    .total-wrapper {
        text-align: right;
    }

    .total-label {
        font-size: 13px;
        font-weight: 600;
        color: var(--text-muted);
        text-transform: uppercase;
    }

    .total-val {
        font-size: 32px;
        font-weight: 800;
        color: var(--text-heading);
        margin-top: 4px;
        background: var(--brand-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    /* Back Button Animations */
    .footer-actions {
        margin-top: 36px;
    }

    .btn-return {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        padding: 14px 28px;
        background: var(--surface);
        color: var(--text-heading);
        text-decoration: none;
        border-radius: var(--radius-md);
        font-weight: 700;
        font-size: 15px;
        border: 1px solid var(--border);
        box-shadow: var(--shadow-sm);
        transition: var(--transition);
    }

    .btn-return:hover {
        background: var(--text-heading);
        color: var(--surface);
        border-color: var(--text-heading);
        transform: translateX(-4px);
        box-shadow: 0 8px 20px rgba(15, 23, 42, 0.15);
    }

    .btn-return svg {
        transition: var(--transition);
    }
    .btn-return:hover svg {
        transform: translateX(-3px);
    }
</style>
</head>
<body>

    <div class="container">

        <div class="top-bar">
            <div class="page-title">
                <h2>Order Invoice</h2>
                <p>Thank you for ordering with us!</p>
            </div>
            <div class="order-id-pill">
                Order ID: <span>#<%= order.getOrdersId() %></span>
            </div>
        </div>

        <div class="info-grid">
            <div class="card">
                <div class="card-header-group" style="background-color: #f0f4f8; border-bottom-color: #dbeafe;">
                    <div class="card-icon-wrapper" style="background: #dbeafe; color: #1e40af;">
                        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
                    </div>
                    <h3 style="color: #1e3a8a;">Customer Account</h3>
                </div>
                <div class="data-row">
                    <span class="data-label">User Reference ID</span>
                    <span class="data-value"><%= order.getUserId() %></span>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header-group" style="background-color: #f5f3ff; border-bottom-color: #ddd6fe;">
                    <div class="card-icon-wrapper" style="background: #ede9fe; color: #5b21b6;">
                        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                    </div>
                    <h3 style="color: #4c1d95;">Purchase Date</h3>
                </div>
                <div class="data-row">
                    <span class="data-label">Timestamp</span>
                    <span class="data-value"><%= order.getOrdersDate() %></span>
                </div>
            </div>

            <div class="card">
                <div class="card-header-group" style="background-color: #fffbeb; border-bottom-color: #fef3c7;">
                    <div class="card-icon-wrapper" style="background: #fef3c7; color: #92400e;">
                        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    </div>
                    <h3 style="color: #78350f;">Delivery Status</h3>
                </div>
                <div class="data-row" style="align-items: flex-start;">
                    <span class="data-label" style="margin-bottom: 6px;">Live State</span>
                    
                    <span class="status-badge 
                        <%= currentStatus.contains("deliver") ? "status-delivered" : 
                            (currentStatus.contains("pend") || currentStatus.contains("process")) ? "status-pending" : 
                            currentStatus.contains("cancel") ? "status-cancelled" : "status-default" %>">
                        <%= order.getStatus() %>
                    </span>
                </div>
            </div>
        </div>

        <div class="card" style="padding: 0 0 24px 0;">
            
            <div class="checklist-card-header">
                <div class="card-icon-wrapper" style="background: #ffedd5; color: #ea580c;">
                    <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path></svg>
                </div>
                <div>
                    <h3 style="font-size: 16px; color: #c2410c;">Items Checklist</h3>
                    <p style="color: #9a3412; font-size: 12px; margin: 2px 0 0 0; font-weight: 500; opacity: 0.85;">Review individual items and calculation breakdown.</p>
                </div>
            </div>
            
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Menu Item Description</th>
                            <th class="text-center">Rate</th>
                            <th class="text-center">Qty</th>
                            <th class="text-right">Net Amnt</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        double grandTotal = 0;
                        for (OrderItem item : items) {
                            grandTotal += item.getItemTotal();
                            double singleRate = item.getItemTotal() / item.getQuantity();
                        %>
                        <tr>
                            <td>
                                <div class="item-title-meta">Food Item Entry</div>
                                <div style="font-size: 12px; color: var(--text-muted); margin-top: 2px;">Kitchen Standard</div>
                            </td>
                            <td class="text-center" style="font-weight: 500;">₹<%= String.format("%.2f", singleRate) %></td>
                            <td class="text-center"><span style="background: #f1f5f9; padding: 4px 10px; border-radius: 6px; font-weight: 600; font-size: 14px;"><%= item.getQuantity() %></span></td>
                            <td class="text-right" style="font-weight: 700; color: var(--text-heading);">₹<%= String.format("%.2f", item.getItemTotal()) %></td>
                        </tr>
                        <%
                        }
                        if(items.isEmpty()) {
                        %>
                        <tr>
                            <td colspan="4" class="text-center" style="color: var(--text-muted); padding: 48px 24px; font-weight: 500;">
                                Empty Order Bucket List.
                            </td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>

            <div style="padding: 0 28px;">
                <div class="summary-bill-box">
                    <div class="total-wrapper">
                        <span class="total-label">Payable Amount</span>
                        <div class="total-val">₹<%= String.format("%.2f", grandTotal) %></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer-actions">
            <a href="OrderHistoryServlet" class="btn-return">
                <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                Return to Order History
            </a>
        </div>

    </div>

</body>
</html>