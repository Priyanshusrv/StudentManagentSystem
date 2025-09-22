<!DOCTYPE html>
<html>
<head>
    <title>Add Student</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f4f7fc;
            font-family: Arial, sans-serif;
        }
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 25px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
        }
        .form-title {
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
            color: #333;
        }
        .btn-custom {
            width: 100%;
            background: #4e73df;
            color: white;
            font-weight: bold;
            border-radius: 8px;
        }
        .btn-custom:hover {
            background: #2e59d9;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h3 class="form-title">Add Student</h3>
    <form action="addStudents" method="POST">

        <!-- First Name -->
        <div class="mb-3">
            <label class="form-label">First Name</label>
            <input type="text" class="form-control" name="first_name" required>
        </div>

        <!-- Last Name -->
        <div class="mb-3">
            <label class="form-label">Last Name</label>
            <input type="text" class="form-control" name="last_name" required>
        </div>

        <!-- Class -->
        <div class="mb-3">
            <label class="form-label">Class</label>
            <input type="text" class="form-control" name="student_class" required>
        </div>

        <!-- Status Dropdown -->
        <div class="mb-3">
            <label class="form-label">Status</label>
            <select class="form-select" name="status">
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
            </select>
        </div>

        <!-- Result Radio -->
        <div class="mb-3">
            <label class="form-label">Result</label><br>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="result" value="PASS" required>
                <label class="form-check-label">Pass</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="result" value="FAIL">
                <label class="form-check-label">Fail</label>
            </div>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn btn-custom">Add Student</button>
    </form>
</div>

</body>
</html>
