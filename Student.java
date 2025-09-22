package com.example.helloworld.model;

public class Student {

	private int id;
	private String first_name;
	private String last_name;
	private String student_class;
	private String status;
	private Result result; // NEW FIELD (Enum)

	// --- Enum for Result ---
	public enum Result {
		PASS, FAIL
	}

	// --- Getters and Setters ---
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getStudent_class() {
		return student_class;
	}

	public void setStudent_class(String student_class) {
		this.student_class = student_class;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	// --- Constructors ---
	public Student(int id, String first_name, String last_name, String student_class, String status, Result result) {
		this.id = id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.student_class = student_class;
		this.status = status;
		this.result = result;
	}

	public Student() {
	}
}
