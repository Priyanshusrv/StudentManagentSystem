<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Students List</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- DataTables CSS + JS -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css">
<script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Bundle JS (with Popper.js) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	

<style>
table {
	border-collapse: collapse;
	width: 80%;
	margin: 20px auto;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}

th {
	background-color: #4CAF50;
	color: white;
}

.btn {
	padding: 6px 12px;
	border-radius: 6px;
	border: none;
	cursor: pointer;
	font-size: 13px;
}

.update-btn {
	background: #2196F3;
	color: white;
}

.update-btn:hover {
	background: #1976D2;
}

.delete-btn {
	background: #f44336;
	color: white;
}

.delete-btn:hover {
	background: #d32f2f;
}

#insertBtn {
  color: black;
  border: none;
  cursor: pointer;
  font-size: 14px;
  margin-left: 5px;
  position:relative;
  left:1100px;
}

#insertBtn:hover {
  background: white;
}
</style>
</head>
<body>
	<h2 style="text-align: center;">All Students</h2>

<!-- Insert Button -->
<button type="button" id="insertBtn" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#insertModal">
  Insert Student
</button>

<!-- Insert Modal -->
<div class="modal fade" id="insertModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Add Student</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <form id="studentForm">
          <input type="text" id="firstName" class="form-control mb-2" placeholder="First Name">
          <input type="text" id="lastName" class="form-control mb-2" placeholder="Last Name">
          <input type="text" id="studentClass" class="form-control mb-2" placeholder="Class">

          <!-- 🔽 Status Dropdown -->
          <label for="status">Status:</label>
          <select id="status" class="form-control mb-2">
            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>
          </select>

          <!-- 🔽 Result Radio Buttons -->
          <label>Result:</label><br>
          <input type="radio" name="result" value="PASS" checked> Pass
          <input type="radio" name="result" value="FAIL"> Fail
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" id="saveBtn" class="btn btn-primary">Save</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

<!-- Update Modal -->
<div class="modal fade" id="updateModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">Update Student</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <form id="updateForm">
          <input type="hidden" id="updateId">
          <input type="text" id="updateFirstName" class="form-control mb-2" placeholder="First Name">
          <input type="text" id="updateLastName" class="form-control mb-2" placeholder="Last Name">
          <input type="text" id="updateClass" class="form-control mb-2" placeholder="Class">

          <!-- 🔽 Status Dropdown -->
          <label for="updateStatus">Status:</label>
          <select id="updateStatus" class="form-control mb-2">
            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>
          </select>

          <!-- 🔽 Result Radio Buttons -->
          <label>Result:</label><br>
          <input type="radio" name="updateResult" value="PASS"> Pass
          <input type="radio" name="updateResult" value="FAIL"> Fail
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" id="updateBtn" class="btn btn-primary">Update</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

<!-- Student Table -->
<table id="studentsTable" class="display">
	<thead>
		<tr>
			<th>ID</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Class</th>
			<th>Status</th>
			<th>Result</th>
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="stu" items="${data}">
			<tr id="row-${stu.id}">
				<td>${stu.id}</td>
				<td>${stu.first_name}</td>
				<td>${stu.last_name}</td>
				<td>${stu.student_class}</td>
				<td>${stu.status}</td>
				<td>${stu.result}</td>
				<td>
					<button class="btn update-btn" onclick="openUpdateModal(${stu.id})">Update</button>
					<button class="btn delete-btn" onclick="deleteStudent(${stu.id})">Delete</button>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</body>

<script>
    // --------- Initialize DataTable ---------
    $(document).ready(function() {
        $('#studentsTable').DataTable({
            "paging": true,
            "searching": true,
            "ordering": true,
            "order": [[0, "asc"]],
            "columnDefs": [
                { "orderable": false, "targets": 6 }
            ]
        });
    });
    
    // --------- Save Student via AJAX ---------
    $(document).ready(function () {
        $("#saveBtn").click(function () {
            const student = {
                first_name: $("#firstName").val(),
                last_name: $("#lastName").val(),
                student_class: $("#studentClass").val(),
                status: $("#status").val(),
                result: $("input[name='result']:checked").val()
            };

            $.ajax({
                url: "/students",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(student),
                success: function (response) {
                    alert("Student added successfully!");
                    $("#insertModal").modal('hide');  
                    location.reload();
                }
            });
        });
    });

    // --------- Open Update Modal ---------
    function openUpdateModal(id) {
        var row = $("#row-" + id + " td");

        $("#updateId").val(id);
        $("#updateFirstName").val($(row[1]).text());
        $("#updateLastName").val($(row[2]).text());
        $("#updateClass").val($(row[3]).text());
        $("#updateStatus").val($(row[4]).text());

        var resultValue = $(row[5]).text().trim();
        $("input[name='updateResult'][value='" + resultValue + "']").prop("checked", true);

        var modal = new bootstrap.Modal(document.getElementById("updateModal"));
        modal.show();
    }

    // --------- Update Student via AJAX ---------
    $("#updateBtn").click(function () {
        const student = {
            first_name: $("#updateFirstName").val(),
            last_name: $("#updateLastName").val(),
            student_class: $("#updateClass").val(),
            status: $("#updateStatus").val(),
            result: $("input[name='updateResult']:checked").val()
        };
        const id = $("#updateId").val();

        $.ajax({
            url: "/updateStudentAjax/" + id,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(student),
            success: function (response) {
                alert("Student updated successfully!");

                var modalEl = document.getElementById("updateModal");
                var modal = bootstrap.Modal.getInstance(modalEl);
                modal.hide();

                var row = $("#row-" + id + " td");
                $(row[1]).text(student.first_name);
                $(row[2]).text(student.last_name);
                $(row[3]).text(student.student_class);
                $(row[4]).text(student.status);
                $(row[5]).text(student.result);
            },
            error: function () {
                alert("Error updating student");
            }
        });
    });

    // --------- Delete Student via AJAX ---------
    function deleteStudent(id) {
        if(confirm("Are you sure you want to delete this student?")) {
            $.ajax({
                url: "/ajax/deleteStudent/" + id,
                type: "POST",
                success: function(response) {
                    alert(response);
                    $("#row-" + id).remove();
                },
                error: function(err) {
                    alert("Error deleting student");
                    console.log(err);
                }
            });
        }
    }
</script>
</html>
