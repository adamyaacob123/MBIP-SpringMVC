package com.tutorial.model;

import java.sql.Blob;

public class Form {

	private String email;
	
	private double waterAmount;
	private String waterPeriod;
	private String waterYear;
	private Blob waterFile;
	private String waterStatus;
	
	private double electricAmount;
	private String electricPeriod;
	private String electricYear;
	private Blob electricFile;
	private String electricStatus;
	
	private double wasteAmount;
	private String wastePeriod;
	private String wasteYear;
	private Blob wasteFile;
	private String wasteStatus;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public double getWaterAmount() {
		return waterAmount;
	}
	public void setWaterAmount(double d) {
		this.waterAmount = d;
	}
	public String getWaterPeriod() {
		return waterPeriod;
	}
	public void setWaterPeriod(String waterPeriod) {
		this.waterPeriod = waterPeriod;
	}
	public String getWaterYear() {
		return waterYear;
	}
	public void setWaterYear(String waterYear) {
		this.waterYear = waterYear;
	}
	public Blob getWaterFile() {
		return waterFile;
	}
	public void setWaterFile(Blob waterFile) {
		this.waterFile = waterFile;
	}
	public double getElectricAmount() {
		return electricAmount;
	}
	public void setElectricAmount(double d) {
		this.electricAmount = d;
	}
	public String getElectricPeriod() {
		return electricPeriod;
	}
	public void setElectricPeriod(String electricPeriod) {
		this.electricPeriod = electricPeriod;
	}
	public String getElectricYear() {
		return electricYear;
	}
	public void setElectricYear(String electricYear) {
		this.electricYear = electricYear;
	}
	public Blob getElectricFile() {
		return electricFile;
	}
	public void setElectricFile(Blob electricFile) {
		this.electricFile = electricFile;
	}
	public double getWasteAmount() {
		return wasteAmount;
	}
	public void setWasteAmount(double d) {
		this.wasteAmount = d;
	}
	public String getWastePeriod() {
		return wastePeriod;
	}
	public void setWastePeriod(String wastePeriod) {
		this.wastePeriod = wastePeriod;
	}
	public String getWasteYear() {
		return wasteYear;
	}
	public void setWasteYear(String wasteYear) {
		this.wasteYear = wasteYear;
	}
	public Blob getWasteFile() {
		return wasteFile;
	}
	public void setWasteFile(Blob wasteFile) {
		this.wasteFile = wasteFile;
	}
	public String getWaterStatus() {
		return waterStatus;
	}
	public void setWaterStatus(String waterStatus) {
		this.waterStatus = waterStatus;
	}
	public String getElectricStatus() {
		return electricStatus;
	}
	public void setElectricStatus(String electricStatus) {
		this.electricStatus = electricStatus;
	}
	public String getWasteStatus() {
		return wasteStatus;
	}
	public void setWasteStatus(String wasteStatus) {
		this.wasteStatus = wasteStatus;
	}
	

}