<cfset  crm = structKeyExists(url, "crm") ? url.crm : "dashboard">
<cfset  data = {} />

<cfif crm eq "dashboard">
    <cfset data = application.controller.dashboard() />
    <cfinclude template="views/dashboard.cfm" />
<cfelseif crm eq "profile">
    <cfinclude template="views/profile.cfm" />
<cfelseif crm eq "viewRequests">
    <cfset data = application.controller.fetchrequests() />
    <cfinclude template="views/view_requests.cfm" />
<cfelseif crm eq "submitRequest">
    <cfinclude template="views/submit_request.cfm" />
<cfelseif crm eq "addreq"> 
    <cfset variables.formRes = application.controller.createRequest(info=form) />
    <cfif len(variables.formRes) lt 11>
        <cflocation url="index.cfm?crm=viewRequests" addtoken="no">
    <cfelse>
        <cfinclude  template="formValidationFailed.cfm">
    </cfif>
<cfelseif crm eq "requestReport">
    <cfinclude template="reports/request_report.cfm" />
<cfelseif crm eq "edit">
    <cfinclude template="views/edit.cfm" />
<cfelseif crm eq "update">
    <cfinclude template="views/update.cfm" />
<cfelseif crm eq "delete">
    <cfinclude template="views/delete.cfm" />
<cfelseif crm eq "logs">
    <cfset data = application.controller.fetchlogs() />
    <cfinclude template="views/logs.cfm" />
<cfelseif crm eq "users">
    <cfset data = application.controller.fetchusers() />
    <cfinclude template="views/user.cfm" />
<cfelseif crm eq "customers">
    <cfinclude template="views/customers.cfm" />
<cfelseif crm eq "addcus">
    <cfset variables.formRes = application.controller.createCustomer(info=form) />
    <cfif len(variables.formRes) lt 11>
        <cflocation url="index.cfm?crm=customers" addtoken="no">
    <cfelse>
        <cfinclude  template="formValidationFailed.cfm">
    </cfif>
<cfelseif crm eq "editcus">
    <cfset variables.formRes = application.controller.editCustomer(info=form) />
    <cfif len(variables.formRes) lt 11>
        <cflocation url="index.cfm?crm=customers" addtoken="no">
    <cfelse>
        <cfinclude template="formValidationFailed.cfm">
    </cfif>

<cfelseif crm eq "deletecus">
    <cfset variables.formRes = application.controller.deleteCustomer(id=form.delete_id) />
    <cflocation url="index.cfm?crm=customers" addtoken="no">
</cfif>