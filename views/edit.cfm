<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/edit.css">

<!DOCTYPE html>
<html>
<head>
  <title><cfoutput>CRM - Edit Request</cfoutput></title>
  <meta charset="UTF-8">
</head>

<!-- CHECK FOR ID -->
<cfif NOT structKeyExists(url, "id")>
  <div class="error-msg">No ID provided to edit.</div>
  <cfabort>
</cfif>

<!-- SUCCESS ALERT -->
<cfif structKeyExists(url, "success") AND url.success EQ "true">
  <script>
    alert("Successfully Updated");
    window.location.href = "index.cfm?crm=viewRequests";
  </script>
</cfif>


<!-- FETCH EXISTING RECORD -->
<cfquery name="myquery" datasource="#application.datasource#">
  SELECT title, description, department
  FROM requests
  WHERE id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
</cfquery>

<!-- EDIT FORM -->
<div class="form-container">
  <h2>Edit Your Request</h2>
  
  <cfoutput>
    <form action="index.cfm?crm=update" method="post">
  <input type="hidden" name="id" value="#url.id#">

  <label>Title</label>
  <input type="text" name="title" value="#myquery.title#" required>

  <label>Description</label>
  <input type="text" name="description" value="#myquery.description#">

  <label>Department</label>
  <select name="department" class="dep-btn">
    <option value="">-- All Departments --</option>
    <option value="HR" <cfif #myquery.department# EQ "HR">selected</cfif>>HR</option>
    <option value="Finance" <cfif #myquery.department# EQ "Finance">selected</cfif>>Finance</option>
    <option value="IT" <cfif #myquery.department# EQ "IT">selected</cfif>>IT</option>
    <option value="Sales" <cfif #myquery.department# EQ "Sales">selected</cfif>>Sales</option>
    <option value="Admin" <cfif #myquery.department# EQ "Admin">selected</cfif>>Admin</option>
  </select>

  <input type="submit" value="Update">
</form>

  </cfoutput>
  <div class="home-btn">
    <a href="index.cfm?crm=viewRequests" class="home-link">Back to View Requests</a>
  </div>
</div>

