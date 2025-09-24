<cfif structKeyExists(url, "id") AND isNumeric(url.id)>
  
  <!-- Optional: Verify the record exists -->
  <cfquery name="checkRequest" datasource="#application.datasource#">
    SELECT id FROM requests
    WHERE id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
  </cfquery>

  <cfif checkRequest.recordcount EQ 1>
    <!-- Record exists, proceed to delete -->
    <cfquery name="deleteRequest" datasource="#application.datasource#">
      DELETE FROM requests
      WHERE id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfquery name="getID" datasource="#application.datasource#">
    SELECT LAST_INSERT_ID() AS requestID
  </cfquery>

  <cfset newRequestID = getID.requestID>
  <cflog file="ActivityLogs" text="User - #session.username# | Action - Delete Request | 
  RequestID - #newRequestID# | Delete Request ID #newRequestID#,">
  <cfquery name="logquery" datasource="#application.datasource#">
   INSERT INTO logs(user_id, username, request_id, action, details)
   VALUES (
      <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">,
      <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#newRequestID#" cfsqltype="cf_sql_integer">,
      <cfqueryparam value="DELETE" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="User #session.userid# Delete Request ID #newRequestID#" cfsqltype="cf_sql_varchar">
   )
  </cfquery>

    <!-- Redirect to request list with confirmation -->
    <cflocation url="index.cfm?crm=viewRequests&deleted=true">

  <cfelse>
    <!-- Record not found -->
    <cfoutput>
      <p style="color:red;">Request not found. Nothing was deleted.</p>
    </cfoutput>
  </cfif>

<cfelse>
  <!-- No ID passed -->
  <cfoutput>
    <p style="color:red;">Invalid or missing ID.</p>
  </cfoutput>
</cfif>
