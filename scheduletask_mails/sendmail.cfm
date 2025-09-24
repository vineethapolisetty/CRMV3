<cfquery datasource="#application.datasource#" name="logDownload">
    INSERT INTO report_downloads(user_id, username, downloaded_at)
    VALUES (
        <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
    )
</cfquery>

<!-- Send email -->
<cfmail 
    to="sainaidukottu@gmail.com"
    from="kottunarasimha22@gmail.com"
    subject="Customer Report Downloaded"
    type="html">
    <p>User <strong>#session.username#</strong> downloaded the customer report on <strong>#dateFormat(now(), "dd-mmm-yyyy")#</strong> at <strong>#timeFormat(now(), "hh:mm tt")#</strong>.</p>
</cfmail>
<cfoutput>mail page reached</cfoutput>