<cfcomponent>

    <!-- Add Customer -->
   <cffunction name="addCustomer" access="public" returntype="any">
        <cfargument name="info" type="struct" required="true">

        <cfset local.custid = 0>
        <cfquery datasource="#application.datasource#" result="res">
            INSERT INTO customers (name, email, phone)
            VALUES (
                <cfqueryparam value="#arguments.info.name#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.info.email#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#arguments.info.phone#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
        <cfset local.custid = res.GENERATEDKEY>
        <cfreturn local.custid>
    </cffunction>

    <!-- Update Customer -->
    <cffunction name="updateCustomer" access="public" returnType="void">
        <cfargument name="id" required="true" type="numeric">
        <cfargument name="name" required="true" type="string">
        <cfargument name="email" required="true" type="string">
        <cfargument name="phone" required="true" type="string">
        
        <cfquery datasource="#application.datasource#">
            UPDATE customers
            SET
                name = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
                email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
                phone = <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">
            WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cffunction>

    <!-- Delete Customer -->
    <cffunction name="deleteCustomer" access="public" returnType="void">
        <cfargument name="id" required="true" type="numeric">
        
        <cfquery datasource="#application.datasource#">
            DELETE FROM customers
            WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cffunction>

    <!-- Get All Customers -->
    <cffunction name="getAllCustomers" access="public" returnType="query">
        <cfquery name="getCustomers" datasource="#application.datasource#">
            SELECT * FROM customers ORDER BY id DESC
        </cfquery>
        <cfreturn getCustomers>
    </cffunction>

    <!-- Search Customers -->
    <cffunction name="searchCustomers" access="public" returnType="query">
        <cfargument name="keyword" required="true" type="string">
        
        <cfset var localKeyword = "%" & arguments.keyword & "%">
        
        <cfquery name="searchResults" datasource="#application.datasource#">
            SELECT * FROM customers
            WHERE name LIKE <cfqueryparam value="#localKeyword#" cfsqltype="cf_sql_varchar">
               OR email LIKE <cfqueryparam value="#localKeyword#" cfsqltype="cf_sql_varchar">
               OR phone LIKE <cfqueryparam value="#localKeyword#" cfsqltype="cf_sql_varchar">
            ORDER BY id DESC
        </cfquery>
        
        <cfreturn searchResults>
    </cffunction>

</cfcomponent>
