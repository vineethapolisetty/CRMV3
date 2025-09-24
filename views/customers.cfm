
<cfset customerService = createObject("component", "components.customerservice")>

<!-- Search Support -->
<cfset localKeyword = "">
<cfif structKeyExists(form, "search_keyword")>
    <cfset localKeyword = trim(form.search_keyword)>
</cfif>

<!--- Add Customer
<cfif structKeyExists(form, "add")>
    <cfset customerService.addCustomer(trim(form.name), trim(form.email), trim(form.phone))>
    <cflocation url="index.cfm?crm=customers">
</cfif> --->

<!-- Edit Customer -->
<cfif structKeyExists(form, "edit_id")>
    <cfset customerService.updateCustomer(
        id = form.edit_id,
        name = trim(form.name),
        email = trim(form.email),
        phone = trim(form.phone)
    )>
    <cflocation url="index.cfm?crm=customers">
</cfif>

<!-- Delete Customer -->
<cfif structKeyExists(form, "delete_id")>
    <cfset customerService.deleteCustomer(form.delete_id)>
    <cflocation url="index.cfm?crm=customers">
</cfif>

<!-- Get all customers once -->
<cfif len(trim(localKeyword))>
    <cfset customers = customerService.searchCustomers(localKeyword)>
<cfelse>
    <cfset customers = customerService.getAllCustomers()>
</cfif>


<!-- Convert to JSON for JS pagination -->
<cfset customerArray = []>
<cfloop query="customers">
    <cfset arrayAppend(customerArray, {
        "id" = customers.id,
        "name" = customers.name,
        "email" = customers.email,
        "phone" = customers.phone
    })>
</cfloop>
<script>
    var customerData = <cfoutput>#serializeJSON(customerArray)#</cfoutput>;
</script>

<link rel="stylesheet" href="css/customers.css">
<!-- Top Bar -->
<div class="container">
<div class="top-bar-btn">
    <a href="index.cfm" class="home-btn">Back to Home</a>
    <button type="button" class="report-btn">Download Customers Report</button>
</div>

<h2>Customer Management</h2>
<!-- Search -->
<cfoutput>
<form method="post" class="search" style="margin-bottom: 15px;">
    <input type="text" id="searchKeyword" name="search_keyword" placeholder="Search by name, email, or phone"
        value="#HTMLEditFormat(localKeyword)#">
    <button class="search-btn" type="submit">Search</button>
</form>
</cfoutput>

<!-- Add Customer Form -->
<form method="post" style="margin-bottom: 30px;" action="index.cfm?crm=addcus">
    <input type="text" name="name" placeholder="Name" required>
    <input type="text" name="email" placeholder="Email" required>
    <input type="text" name="phone" placeholder="Phone">
    <button class="add-btn" type="submit" name="add">Add Customer</button>
</form>

<!-- Dynamic Table Container -->
<div id="customerResults"></div>

<!-- Empty pagination container for jQuery -->
<div class="pagination"></div>
</div>
<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/customers.js"></script>
<script src="js/sendmail.js"></script>

