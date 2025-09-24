$(document).ready(function () {
    // Delegate edit button click
    $(document).on("click", ".edit-btn", function () {
        var id = $(this).data("id");
        $(".editmodel").slideUp(); // Hide all edit forms
        $("#editForm" + id).slideToggle(); // Toggle current form
    });

    // Delegate cancel button click
    $(document).on("click", ".cancel-btn", function () {
        $(this).closest(".editmodel").slideUp();
    });

    // Search AJAX
$('#searchInput').on('input', function () {
    var keyword = $(this).val();

    $.ajax({
        url: '/CRMv2/components/customerService.cfc?method=searchCustomers&localKeyword=' + encodeURIComponent(keyword),
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            let tableBody = '';
            if (data && data.DATA && data.DATA.length > 0) {
                for (let i = 0; i < data.DATA[0].length; i++) {
                    tableBody += `<tr>
                        <td>${data.DATA[0][i]}</td> <!-- assuming fullname is first column -->
                        <td>${data.DATA[1][i]}</td> <!-- update index based on actual DB columns -->
                        <td><button class="edit-btn">Edit</button></td>
                        <td><button class="delete-btn">Delete</button></td>
                    </tr>`;
                }
            } else {
                tableBody = '<tr><td colspan="4">No results found.</td></tr>';
            }
            $('#customerTable tbody').html(tableBody);
        },
        error: function (xhr, status, error) {
            console.error('Search failed:', error);
        }
    });
});



});
$(document).ready(function () {
    const recordsPerPage = 5;
    let currentPage = 1;

   function renderPagination(totalPages) {
    let paginationHTML = "";

    if (currentPage > 1) {
        paginationHTML += `<a href="#" class="page-link pagi-pn" data-page="${currentPage - 1}">Prev</a>`;
    }

    for (let i = 1; i <= totalPages; i++) {
        let activeClass = (i === currentPage) ? "active-page" : "";
        paginationHTML += `<a href="#" class="page-link ${activeClass}" data-page="${i}">${i}</a>`;
    }

    if (currentPage < totalPages) {
        paginationHTML += `<a href="#" class="page-link pagi-pn" data-page="${currentPage + 1}">Next</a>`;
    }

    $(".pagination").html(paginationHTML);
}


    function renderTable(page) {
        const start = (page - 1) * recordsPerPage;
        const end = start + recordsPerPage;
        const pageData = customerData.slice(start, end);

        let html = `<table><tr>
            <th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Actions</th>
        </tr>`;

        if (pageData.length === 0) {
            html += `<tr><td colspan="5">No customers found</td></tr>`;
        } else {
            pageData.forEach(customer => {
                html += `
                <tr>
                    <td>${customer.id}</td>
                    <td>${customer.name}</td>
                    <td>${customer.email}</td>
                    <td>${customer.phone}</td>
                    <td class="action-buttons">
                        <button type="button" action="index.cfm?crm=deletecus" class="edit-btn" data-id="${customer.id}">Edit</button>
                        <form method="post" style="display:inline;" onsubmit="return confirm('Are you sure?');">
                            <input type="hidden" name="delete_id" value="${customer.id}">
                            <button type="submit" class="delete-btn">Delete</button>
                        </form>
                    </td>
                </tr>
                <tr id="editForm${customer.id}" class="editmodel" style="display:none;">
                    <td colspan="5">
                        <form method="post" action="index.cfm?crm=editcus">
                            <input type="hidden" name="edit_id" value="${customer.id}">
                            <input type="text" name="name" value="${customer.name}" required>
                            <input type="email" name="email" value="${customer.email}" required>
                            <input type="text" name="phone" value="${customer.phone}">
                            <button type="submit">Save</button>
                            <button type="button" class="cancel-btn">Cancel</button>
                        </form>
                    </td>
                </tr>`;
            });
        }

        html += `</table>`;
        $("#customerResults").html(html);

        const totalPages = Math.ceil(customerData.length / recordsPerPage);
        renderPagination(totalPages);
    }

    // Initial render
    renderTable(currentPage);

    // Pagination click
    $(document).on("click", ".page-link", function (e) {
        e.preventDefault();
        currentPage = parseInt($(this).data("page"));
        renderTable(currentPage);
    });
});
