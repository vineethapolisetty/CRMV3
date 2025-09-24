<cfcomponent>
 <cfset this.name = "CRMv3"> 
    <cfset this.sessionManagement = true>
    <cfset this.applicationTimeout = createTimeSpan(0, 2, 0, 0)>
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0)>
    <cfset this.mappings["/components"] = getDirectoryFromPath(getCurrentTemplatePath()) & "components">

    <!-- Runs when the application starts -->
    <cffunction name="onApplicationStart" returnType="boolean">
      <cfset application.datasource = "user">
      <cfset application.controller = new controller() />
      <cfset application.customers = new components.customerservice()/ >
      <cfset application.logoutPath = "logout.cfm">
      <cfreturn true>
    </cffunction>

    <!-- Runs when a session starts -->
    <cffunction name="onSessionStart" returnType="void">
        <cfset session.started = now()>
    </cffunction>

    <!-- Runs when a session ends -->
    <cffunction name="onSessionEnd" returnType="void">
        <cfargument name="sessionScope" required="true">
        <cfargument name="ApplicationScope" required="true">
        <!-- Example: Log session end -->
        <cflog text="Session ended for user ID: #SessionScope.userid#" file="sessionLog">
    </cffunction>

    <cffunction name="onApplicationEnd" returnType="void">
      <cfargument name="applicationScope" required="true">
      <cflog file="appLog" text="Application CRMApp ended at #now()#">
    </cffunction>

    <cffunction name="onRequestStart" access="public" returnType="boolean">
     <cfargument name="targetPage" type="string" required="true">   

     <cfif structKeyExists(url, "init")>
       <cfset onApplicationStart()>
     </cfif>

     <cfset var publicPages = "login.cfm,forgot.cfm,register.cfm">
     <cfset var thisPage = lCase(getFileFromPath(arguments.targetPage))>

     <cfif listFind(publicPages, thisPage)>
       <cfreturn true>
     </cfif>

     <cfif NOT structKeyExists(session, "userid")>
       <cflocation url="/CRMv3/login.cfm?error=login" addtoken="false">
       <cfreturn false>
      </cfif>

      
      <cfreturn true>
  </cffunction>

  <cffunction name="onRequestEnd" access="public" returnType="boolean">
    <cfargument name="targetPage" type="string" required="true">

    <cfset var publicPages = "login.cfm,forgot.cfm,register.cfm">
    <cfset var thisPage = lCase(getFileFromPath(arguments.targetPage))>

    <cfif listFind(publicPages, thisPage)>
      <cfreturn true>
    </cfif>

    

    <cfreturn true>
  </cffunction>
</cfcomponent>

