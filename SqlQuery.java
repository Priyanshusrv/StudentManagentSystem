package com.example.helloworld.Query;

import java.sql.*;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.helloworld.config.JdbcConnectionManager;
import com.example.helloworld.model.Student;

@Service
public class SqlQuery {

	@Autowired
	private JdbcConnectionManager jdbccon;

	// Select All Students
	public List<Map<String, String>> getAllStudent() throws SQLException {
	    Connection conn = jdbccon.getConnection();
	    List<Map<String, String>> stu = new ArrayList<>();
	    if (conn != null) {
	        PreparedStatement ps = conn.prepareStatement("SELECT * FROM students");
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            Map<String, String> map = new HashMap<>();
	            map.put("id", rs.getString("id"));
	            map.put("first_name", rs.getString("first_name"));
	            map.put("last_name", rs.getString("last_name"));
	            map.put("student_class", rs.getString("student_class"));
	            map.put("status", rs.getString("status"));
	            map.put("result", rs.getString("result")); // NEW
	            stu.add(map);
	        }
	    }
	    conn.close();
	    return stu;
	}
	
	// Get Student by ID
	public Student getStudentById(int id) throws SQLException {
	    Connection conn = jdbccon.getConnection();
	    PreparedStatement ps = conn.prepareStatement("SELECT * FROM students WHERE id=?");
	    ps.setInt(1, id);
	    ResultSet rs = ps.executeQuery();
	    Student stu = new Student();
	    if (rs.next()) {
	        stu.setId(rs.getInt("id"));
	        stu.setFirst_name(rs.getString("first_name"));
	        stu.setLast_name(rs.getString("last_name"));
	        stu.setStudent_class(rs.getString("student_class"));
	        stu.setStatus(rs.getString("status"));
	        stu.setResult(Student.Result.valueOf(rs.getString("result")));

	    }
	    conn.close();
	    return stu;
	}

	// Insert Student
	public void insertStudent(Student student) {
	    try {
	        Connection conn = jdbccon.getConnection();
	        if (conn != null) {
	            PreparedStatement ps = conn.prepareStatement(
	                "INSERT INTO students(first_name, last_name, student_class, status, result) VALUES (?, ?, ?, ?, ?)"
	            );
	            ps.setString(1, student.getFirst_name());
	            ps.setString(2, student.getLast_name());
	            ps.setString(3, student.getStudent_class());
	            ps.setString(4, student.getStatus());
	            ps.setString(5, student.getResult().name());
	            ps.executeUpdate();
	            conn.close();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	// Update Student
	public void updateStudent(Student student, int id) {
	    try {
	        Connection conn = jdbccon.getConnection();
	        if (conn != null) {
	            PreparedStatement ps = conn.prepareStatement(
	                "UPDATE students SET first_name=?, last_name=?, student_class=?, status=?, result=? WHERE id=?"
	            );
	            ps.setString(1, student.getFirst_name());
	            ps.setString(2, student.getLast_name());
	            ps.setString(3, student.getStudent_class());
	            ps.setString(4, student.getStatus());
	            ps.setString(5, student.getResult().name());
	            ps.setInt(6, id);
	            ps.executeUpdate();
	            conn.close();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	// Delete Student
	public void deleteStudent(int id) {
	    try {
	        Connection conn = jdbccon.getConnection();
	        if (conn != null) {
	            PreparedStatement ps = conn.prepareStatement("DELETE FROM students WHERE id=?");
	            ps.setInt(1, id);
	            ps.executeUpdate();
	            conn.close();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
}
