package com.tutorial.model;

public class MonthData {
    private String month;
    private float amount;
    private String base64Image;
    private String status;

    // Constructor
    public MonthData(String month, float amount, String base64Image, String status) {
        this.month = month;
        this.amount = amount;
        this.base64Image = base64Image;
        this.status = status;
    }

    // Getters and setters
    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public String getBase64Image() {
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
