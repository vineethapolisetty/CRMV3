<link rel="stylesheet" href="css/view_requests.css">
<script src="js/view_requests.js"></script>

<cfif structKeyExists(url, "success") AND url.success EQ "true">
  <script>alert("Successfully submitted a request!");</script>
</cfif>

<cfif structKeyExists(url, "deleted") AND url.deleted EQ "true">
  <script>alert("Successfully deleted a request!");</script>
</cfif>

<!---<cfparam name="url.search" default="">
<cfset searchTerm = trim(url.search)>--->

<cfif structkeyexists(form, "reset")>
 <cflocation url="index.cfm?crm=viewRequests">
</cfif>

<!-- MAIN CONTENT -->
<div class="container">
  <h2>Your Submitted Requests</h2>

  <div class="top-row">
    <div class="left-side">
      <form method="post" action="index.cfm?crm=viewRequests">
        <select name="department">
          <option value="">-- All Departments --</option>
          <option value="HR" <cfif structKeyExists(form, "department") AND form.department EQ "HR">selected</cfif>>HR</option>
          <option value="Finance" <cfif structKeyExists(form, "department") AND form.department EQ "finance">selected</cfif>>Finance</option>
          <option value="IT" <cfif structKeyExists(form, "department") AND form.department EQ "it">selected</cfif>>IT</option>
          <option value="Sales" <cfif structKeyExists(form, "department") AND form.department EQ "sales">selected</cfif>>Sales</option>
          <option value="Admin" <cfif structKeyExists(form, "department") AND form.department EQ "admin">selected</cfif>>Admin</option>
        </select>
        <input type="submit" value="filter">
        <input type="submit" value="reset" name="reset">
      </form>
    </div>
    <div class="right-side">
      <cfoutput>
        <a href="index.cfm?crm=requestReport&department=#URLEncodedFormat(structKeyExists(form, 'department') ? form.department : '')#" class="download-btn">Download Report</a>
      </cfoutput>
    </div>
  </div>

  <!-- Search Row -->
  <div class="search-row">
    <form method="post" action="index.cfm?crm=viewRequests">
      <input type="text" name="search" placeholder="Search title or description">
      <input type="submit" value="search" class="search-btn">
    </form>
    <!---<form method="get" action="index.cfm">
      <input type="hidden" name="crm" value="viewRequests">
      <input type="text" name="search" placeholder="Search title or description" value="<cfoutput>#url.search#</cfoutput>">
      <input type="submit" value="Search" class="search-btn">
    </form>--->
  </div>

  <!-- Records Table -->
  <table id="viewRequestsTable">
    <thead>
      <tr>
        <th>Title</th>
        <th>Description</th>
        <th>Department</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <cfoutput query="data">
        <tr>
          <td>#title#</td>
          <td>#description#</td>
          <td>#department#</td>
          <td>
            <a href="index.cfm?crm=edit&id=#id#" class="btn-edit">Edit</a>
            <a href="index.cfm?crm=delete&id=#id#" class="btn-delete" onclick="return confirm('Are you sure you want to delete this request?')">Delete</a>
          </td>
        </tr>
      </cfoutput>

      <cfif data.recordcount EQ 0>
        <tr><td colspan="4">No records found</td></tr>
      </cfif>
    </tbody>
  </table>

  <!-- Pagination Container -->
  <div class="pagination" id="pagination"></div>

  <!-- Back Button -->
  <div class="home-btn">
    <a href="index.cfm" class="home-link">Back to Home</a>
  </div>
</div>
