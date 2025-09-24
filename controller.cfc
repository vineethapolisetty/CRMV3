<cfcomponent >
    <cffunction name="dashboard" access="public" returntype="struct">
        <cfset var data = {}/>
        <cfset data.message = "Welcome user"/>
        <cfreturn data/>
    </cffunction>

    <cffunction name="createCustomer" access="public" returntype="string">
        <cfargument name="info" type="struct" required="true">
        <cfset errMsg ="Errors: \n">
        <cfif not len(arguments.info.name)>
            <cfset errMsg = errMsg&"Please enter Customer Name \n">
        </cfif>
        <cfif not len(arguments.info.email)>
            <cfset errMsg = errMsg& "Please enter Contact Email \n">
        </cfif>
        <cfif len(arguments.info.email) GT 0>
           <cfquery name="emailcheck" datasource=#application.datasource#>
              SELECT email FROM customers
              WHERE email = <cfqueryparam value="#arguments.info.email#" cfsqltype="cf_sql_varchar">
           </cfquery>
           <cfif emailcheck.recordCount GT 0>
              <cfset errMsg = errMsg&"Please enter another Email \n">
           </cfif>
        </cfif>
        <cfif len(arguments.info.phone) GT 12 OR len(arguments.info.phone) LT 10>
           <cfset errMsg = errMsg& "Please enter a valid Phone Number \n">
        </cfif>
        <cfif len(errMsg) lt 11>
            <cfset custId = application.customers.addCustomer(info=arguments.info) />
        </cfif>
        <cfreturn errMsg>
    </cffunction>

    <!-- Edit Customer -->
    <cffunction name="editCustomer" access="public" returntype="string">
        <cfargument name="info" type="struct" required="true">
        <cfset var errMsg = "Errors: \n">

        <cfif not len(arguments.info.name)>
            <cfset errMsg &= "Please enter Customer Name \n">
        </cfif>
        <cfif not len(arguments.info.email)>
            <cfset errMsg &= "Please enter Contact Email \n">
        </cfif>

        <cfif len(errMsg) LT 11>
            <cfset application.customers.updateCustomer(
                id    = arguments.info.edit_id,
                name  = arguments.info.name,
                email = arguments.info.email,
                phone = arguments.info.phone
            ) />
        </cfif>

        <cfreturn errMsg>
    </cffunction>

    <!-- Delete Customer -->
    <cffunction name="deleteCustomer" access="public" returntype="string">
        <cfargument name="id" type="numeric" required="true">
        <cfset var errMsg = "">

        <cfif arguments.id LTE 0>
            <cfset errMsg = "Invalid customer ID" />
        <cfelse>
            <cfset application.customers.deleteCustomer(id=arguments.id) />
        </cfif>

        <cfreturn errMsg>
    </cffunction>

    <cffunction name="fetchlogs" access="public" returntype="any">
        <cfquery name="myquery" datasource="#application.datasource#">
          SELECT * FROM logs ORDER BY id DESC
        </cfquery>
        <cfreturn myquery/>
    </cffunction>

    <cffunction name="fetchusers" access="public" returntype="any">
        <cfquery name="userfetch" datasource="#application.datasource#">
         SELECT * FROM users
          ORDER BY id DESC
        </cfquery>
      <cfreturn userfetch/>
    </cffunction>

    <cffunction name="fetchrequests" access="public" returntype="any">
        <cfquery name="getreq" datasource="#application.datasource#">
            SELECT * FROM requests
            WHERE 1=1
         <cfif structKeyExists(form, "department") AND len(trim(form.department))>
            AND department LIKE <cfqueryparam value="#form.department#" cfsqltype="cf_sql_varchar">
         </cfif>
         <cfif structKeyExists(form, "search") AND len(trim(form.search))>
            AND (title LIKE <cfqueryparam value="%#form.search#%" cfsqltype="cf_sql_varchar">
            OR description LIKE <cfqueryparam value="%#form.search#%" cfsqltype="cf_sql_varchar">)
         </cfif>
           ORDER BY id DESC
        </cfquery>
      <cfreturn getreq/>
    </cffunction>

    <cffunction name="createRequest" access="public" returntype="string">
        <cfargument name="info" type="struct" required="true">
        <cfset errMsg ="Errors: \n">
        <cfif not len(arguments.info.department)>
            <cfset errMsg = errMsg&"Please enter Department \n">
        </cfif>
        <cfif not len(arguments.info.title)>
            <cfset errMsg = errMsg& "Please enter Title \n">
        </cfif>
        <cfif not len(arguments.info.description)>
            <cfset errMsg = errMsg& "Please enter Description \n">
        </cfif>
        <cfif len(errMsg) lt 11>
            <cfquery name="ourquery" datasource="#application.datasource#">
              INSERT INTO requests (title, description, department)
              VALUES (
               <cfqueryparam value="#arguments.info.title#" cfsqltype="cf_sql_varchar">,
               <cfqueryparam value="#arguments.info.description#" cfsqltype="cf_sql_varchar">,
               <cfqueryparam value="#arguments.info.department#" cfsqltype="cf_sql_varchar">
              )
            </cfquery>
        </cfif>
        <cfreturn errMsg>
    </cffunction>


</cfcomponent>