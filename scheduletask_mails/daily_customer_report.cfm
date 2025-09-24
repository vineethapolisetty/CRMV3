<!--- daily_customer_report.cfm --->
<cfquery name="downloadsToday" datasource="#application.datasource#">
    SELECT username, downloaded_at
    FROM report_downloads
    WHERE CAST(downloaded_at AS DATE) = <cfqueryparam value="#dateFormat(now(), 'yyyy-mm-dd')#" cfsqltype="cf_sql_date">
</cfquery>

<cfset today = dateFormat(now(), "dd-mmm-yyyy")>

<cfif downloadsToday.recordCount EQ 0>
    <cfset mailBody = "<p>No user downloaded the report today (" & today & ").</p>">
<cfelse>
    <cfset mailBody = "<p>The following users downloaded the customer report on " & today & ":</p><ul>">
    <cfoutput query="downloadsToday">
        <cfset mailBody &= "<li>" & username & " at " & timeFormat(downloaded_at, "hh:mm tt") & "</li>">
    </cfoutput>
    <cfset mailBody &= "</ul>">
</cfif>

<!-- Send email to admin -->
<cfmail 
    to="sainaidukottu@gmail.com"
    from="kottunarasimha22@gmail.com"
    subject="Daily Report Download Summary - #today#"
    type="html">
    #mailBody#
</cfmail>

