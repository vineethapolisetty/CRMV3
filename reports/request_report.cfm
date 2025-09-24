<cfparam name="url.department" default="">

<cfif structKeyExists(url, "download") AND url.download EQ "true">

    <!--- Filtered query by department --->
    <cfif url.department EQ "">
    <!-- Show all requests -->
    <cfquery name="getRequests" datasource="#application.datasource#">
        SELECT id, title, description, department
        FROM requests
        ORDER BY id DESC
    </cfquery>
<cfelse>
    <!-- Filter requests by department securely -->
    <cfquery name="getRequests" datasource="#application.datasource#">
        SELECT id, title, description, department
        FROM requests
        WHERE department = <cfqueryparam value="#url.department#" cfsqltype="cf_sql_varchar">
        ORDER BY title
    </cfquery>
</cfif>


    <cfif getRequests.recordCount EQ 0>
        <cfset errorMsg = "No requests found for department: #url.department#">
        <cfset session.error = errorMsg>
        <cflocation url="index.cfm?crm=requestReport">
    </cfif>

    <!--- Set report path and date --->
    <cfset reportPath = expandPath("request_report.pdf")>
    <cfset reportDate = dateFormat(now(), "dd-mmm-yyyy")>

    <!--- Generate PDF to file --->
    <cfdocument format="pdf"
                filename="#reportPath#"
                overwrite="yes"
                fontembed="yes"
                marginTop="1" marginBottom="1" marginLeft="1" marginRight="1">

        <cfdocumentsection>
            <cfdocumentitem type="header">
                <h2 style="text-align:center;">Your Submitted Requests</h2>
                <p style="text-align:center;">Generated on <cfoutput>#reportDate#</cfoutput></p>
            </cfdocumentitem>

            <table style="width:100%; border-collapse:collapse; font-family:Arial;">
                <tr style="background-color:#003399; color:white;">
                    <th style="border:1px solid #000; padding:8px;">ID</th>
                    <th style="border:1px solid #000; padding:8px;">Title</th>
                    <th style="border:1px solid #000; padding:8px;">Description</th>
                    <th style="border:1px solid #000; padding:8px;">Department</th>
                </tr>

                <cfloop query="getRequests">
                    <tr>
                        <td style="border:1px solid #000; padding:8px;"><cfoutput>#id#</cfoutput></td>
                        <td style="border:1px solid #000; padding:8px;"><cfoutput>#title#</cfoutput></td>
                        <td style="border:1px solid #000; padding:8px;"><cfoutput>#description#</cfoutput></td>
                        <td style="border:1px solid #000; padding:8px;"><cfoutput>#department#</cfoutput></td>
                    </tr>
                </cfloop>
            </table>
        </cfdocumentsection>
    </cfdocument>

    <!--- Force browser download --->
    <cfheader name="Content-Disposition" value="attachment; filename=request_report.pdf">
    <cfcontent type="application/pdf" file="#reportPath#" deleteFile="true">
<cfelse>

<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/request_report.css">

<!DOCTYPE html>
<html>
<head>
  <title><cfoutput>CRM - Download Report</cfoutput></title>
  <meta charset="UTF-8">
</head>

<div class="request-wrapper">
    <div class="request-content">
        <cfoutput>
          <div class="home-btn">
            <cfif url.department EQ "">
                <p class="home-btn"><strong>All Requests</strong></p>
            <cfelse>
                <p>Filtering by Department: <strong>#url.department#</strong></p>
            </cfif>
            </div>

            <div class="success-msg">Customer PDF Report generated successfully</div>
            <div class="home-btn"><a href="index.cfm?crm=requestReport&download=true&department=#URLEncodedFormat(url.department)#" class="download-link">DOWNLOAD HERE</a></div>
        </cfoutput>

        <div class="home-btn">
            <a href="index.cfm?crm=viewRequests" class="home-link">Back to View Requests</a>
        </div>
    </div>
</div>
</cfif>