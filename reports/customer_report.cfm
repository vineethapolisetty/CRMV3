<!-- Step 1: Generate PDF to disk -->
<cfset reportFileName = "customer_report.pdf">
<cfset reportFilePath = ExpandPath("./" & reportFileName)>

<cfquery name="getCustomers" datasource="#application.datasource#">
    SELECT id, name, email, phone
    FROM customers
    ORDER BY id ASC
</cfquery>

<cfdocument format="PDF" filename="#reportFilePath#" overwrite="yes" pagetype="A4" orientation="portrait">
    <h2 style="text-align:center;">Customer Report</h2>
    <cfoutput>
        <p>Report Date: #dateFormat(now(), "dd-mmm-yyyy")#</p>
    </cfoutput>
    <table border="1" cellpadding="6" cellspacing="0" width="100%">
        <tr style="background-color: #ddd;">
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
        </tr>
        <cfoutput query="getCustomers">
            <tr>
                <td>#id#</td>
                <td>#htmlEditFormat(name)#</td>
                <td>#htmlEditFormat(email)#</td>
                <td>#htmlEditFormat(phone)#</td>
            </tr>
        </cfoutput>
    </table>
</cfdocument>


<!-- Step 4: Redirect immediately to download the PDF -->
<cflocation url="customer_report.pdf" addtoken="false">
