<cfparam name="form.id" default="0">
<cfparam name="form.title" default="">
<cfparam name="form.description" default="">
<cfparam name="form.department" default="">

<cfif structkeyexists(form, "id") AND structkeyexists(form, "title") AND structkeyexists(form, "description")>
  <cfquery name="upquery" datasource="#application.datasource#">
    UPDATE requests
    SET title = <cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">,
        description = <cfqueryparam value="#form.description#" cfsqltype="cf_sql_varchar">,
        department = <cfqueryparam value="#form.department#" cfsqltype="cf_sql_varchar">
    WHERE id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer">
  </cfquery>

  <cfquery name="getID" datasource="#application.datasource#">
    SELECT LAST_INSERT_ID() AS requestID
  </cfquery>

  <cfset newRequestID = getID.requestID>
  <cflog file="ActivityLogs" text="User - #session.username# | Action - Update Request | 
  RequestID - #newRequestID# | Updates Request ID #newRequestID#,">
  <cfquery name="logquery" datasource="#application.datasource#">
   INSERT INTO logs(user_id, username, request_id, action, details)
   VALUES (
      <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">,
      <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#newRequestID#" cfsqltype="cf_sql_integer">,
      <cfqueryparam value="UPDATE" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="User #session.userid# Updated Request ID #newRequestID#" cfsqltype="cf_sql_varchar">
   )
  </cfquery>

  <!-- Redirect back to edit with success -->
  <cflocation url="index.cfm?crm=edit&id=#form.id#&success=true">

<cfelse>
  <!-- Redirect with error -->
  <cflocation url="index.cfm?crm=edit&id=#form.id#&error=true">
</cfif>
