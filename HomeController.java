package com.example.helloworld.Controllers;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.helloworld.Query.SqlQuery;
import com.example.helloworld.model.Student;

@Controller
public class HomeController {

    @Autowired
    private SqlQuery sq;

    // =================== JSP-based CRUD ===================

    @GetMapping("/getStudents")
    public String getStudents(Model model) throws SQLException {
        List<Map<String, String>> map = sq.getAllStudent();
        model.addAttribute("data", map);
        return "studentform"; 
    }

    @PostMapping("/addStudents")
    public String addStudents(@ModelAttribute Student stu, Model model) throws SQLException {
        sq.insertStudent(stu);
        List<Map<String, String>> map = sq.getAllStudent();
        model.addAttribute("data", map);
        return "showStudents";
    }

    @GetMapping("/editstudent/{id}")
    public String editstudent(@PathVariable int id, Model model) throws SQLException {
        Student stu = sq.getStudentById(id);
        model.addAttribute("student", stu);
        return "editStudent";
    }

    @PostMapping("/updateStudent/{id}")
    public String updateStudent(@ModelAttribute Student stu, @PathVariable int id, Model model) throws SQLException {
        Student newStu = new Student();
        newStu.setId(id);
        newStu.setFirst_name(stu.getFirst_name());
        newStu.setLast_name(stu.getLast_name());
        newStu.setStudent_class(stu.getStudent_class());
        newStu.setStatus(stu.getStatus());

        sq.updateStudent(newStu, id);

        List<Map<String, String>> map = sq.getAllStudent();
        model.addAttribute("data", map);
        return "showStudents";
    }

    @PostMapping("/deletestudent/{id}")
    public String deletestudent(@PathVariable int id, Model model) throws SQLException {
        sq.deleteStudent(id);
        List<Map<String, String>> updatedStudents = sq.getAllStudent();
        model.addAttribute("data", updatedStudents);
        return "showStudents";
    }

    // =================== AJAX-based CRUD ===================
    
    @GetMapping("/showStudents")
    public String showStudents(Model model) throws SQLException {
        List<Map<String, String>> map = sq.getAllStudent();
        model.addAttribute("data", map);
        return "showStudents"; 
    }

    @PostMapping("/updateStudentAjax/{id}")
    @ResponseBody
    public String updateStudentAjax(@PathVariable int id, @RequestBody Student stu) throws SQLException {
        stu.setId(id);
        sq.updateStudent(stu, id);
        return "Student updated successfully";
    }

    @PostMapping("/ajax/deleteStudent/{id}")
    @ResponseBody
    public String deleteStudentAjax(@PathVariable int id) throws SQLException {
        sq.deleteStudent(id);
        return "Student deleted successfully";
    }

    @PostMapping("/ajax/getAllStudents")
    @ResponseBody
    public List<Map<String, String>> getAllStudentsAjax() throws SQLException {
        return sq.getAllStudent();
    }

    // Optional: Return single student by ID via AJAX
    @GetMapping("/ajax/student/{id}")
    @ResponseBody
    public Student getStudentByIdAjax(@PathVariable int id) throws SQLException {
        return sq.getStudentById(id);
    }
    
    // -------- Show Insert Form --------
    @GetMapping("/insertForm")
    public String showInsertForm(Model model) {
        model.addAttribute("student", new Student());
        return "insertForm"; // insertForm.jsp
    }

    // -------- Save New Student --------
    @PostMapping("/saveStudent")
    public String saveStudent(@ModelAttribute Student student) {
        sq.insertStudent(student);
        return "redirect:/showStudents"; // save hone ke baad list page pe redirect
    }
    
    @PostMapping("/students")
    @ResponseBody
    public Student addStudentAjax(@RequestBody Student stu) throws SQLException {
        sq.insertStudent(stu);
        return stu;
    }


}