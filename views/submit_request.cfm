<link rel="stylesheet" href="css/submit_request.css">
<div class="form-container">
  <h2 class="home-btn">Submit a New Request</h2>
  <label>Department</label>
  <div class="home-btn">
  <form method="post" class="dep-btn" action="index.cfm?crm=addreq">
    <select name="department" required>
      <option value="">-- All Departments --</option>
      <option value="HR">HR</option>
      <option value="Finance">Finance</option>
      <option value="IT">IT</option>
      <option value="Sales">Sales</option>
      <option value="Admin">Admin</option>
    </select>
    </div>

    <label>Title</label>
    <input type="text" name="title" placeholder="Enter Title" required>

    <label>Description</label>
    <textarea name="description" placeholder="Enter Description" rows="4" required></textarea>

    <input type="submit" name="submit" value="Submit">
  </form>

  <div class="home-btn">
    <a href="index.cfm" class="home-link">Back to Home</a>
  </div>
</div>

<cfparam name="form.title" default="">
<cfparam name="form.description" default="">
<cfparam name="form.department" default="">


<cfif structkeyexists(form, "submit")>

  <cfquery name="getID" datasource="#application.datasource#">
    SELECT LAST_INSERT_ID() AS requestID
  </cfquery>

  <cfset newRequestID = getID.requestID>

  <cflog file="ActivityLogs" text="User - #session.username# | Action - Submit Request | 
  RequestID - #newRequestID# | create request with title - #form.title#,">
  
  <cfquery name="logquery" datasource="#application.datasource#">
   INSERT INTO logs(user_id, username, action, request_id, details)
   VALUES (
      <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">,
      <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="Submit Request" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#newRequestID#" cfsqltype="cf_sql_integer">,
      <cfqueryparam value="Created Request with Title #form.title#" cfsqltype="cf_sql_varchar">
   )
  </cfquery>
   
</cfif>
<script src="js/submit_request.js"></script>