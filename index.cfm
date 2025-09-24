<cfinclude template="/CRMv2/includes/header.cfm">
<!DOCTYPE html>
<html>
<head>
  <title><cfoutput>CRM Application</cfoutput></title>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/home.css">
</head>
<div class="page-content">
  <div class="sidebar" id="menu">
    <ul>
      <li><a href="index.cfm?crm=profile" class="menu-link">Go to my Profile</a></li>
      <li><a href="index.cfm?crm=submitRequest" class="menu-link" id="submitRequestLink">Submit Request</a> </li>
      <li><a href="index.cfm?crm=viewRequests" class="menu-link">View Requests</a></li>
      <cfif session.username EQ "admin">
        <li><a href="index.cfm?crm=logs" class="menu-link">View Logs</a></li>
        <li><a href="index.cfm?crm=customers" class="menu-link">Customers</a></li>
        <li><a href="index.cfm?crm=users" class="menu-link">Registered Users</a></li>
      </cfif>
    </ul>
  </div>
</div>
<cfinclude template="router.cfm">
<cfinclude template="/CRMv2/includes/footer.cfm">
<script src="js/home.js"></script>
