package com.tutorial.model;

public class User {

	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private String user_level;
	private String username;
	private String password;
	private String name;
	private String email;
	private String address;
	private int phoneNum;
	private String household;
	private int peopleNo;
	private byte[] profile_image;
    private String profileImageBase64; // New field for the Base64 image

    // New properties for consumption and footprint
    private float waterConsumption;
    private String waterStatus;
    private float electricityConsumption;
    private String electricityStatus;
    private float recycleConsumption;
    private String recycleStatus;
    private float totalMonthlyConsumption;
    private float monthlyFootprint;
    
	public String getUser_level() {
		return user_level;
	}

	public void setUser_level(String user_level) {
		this.user_level = user_level;
	}

	public byte[] getProfile_image() {
		return profile_image;
	}

	public void setProfile_image(byte[] profile_image) {
		this.profile_image = profile_image;
	}

	public String getUserLevel() {
		return user_level;
	}

	public void setUserLevel(String user_level) {
		this.user_level = user_level;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(int phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getHousehold() {
		return household;
	}

	public void setHousehold(String household) {
		this.household = household;
	}

	public int getPeopleNo() {
		return peopleNo;
	}

	public void setPeopleNo(int peopleNo) {
		this.peopleNo = peopleNo;
	}

	public String getProfileImageBase64() {
        return profileImageBase64;
    }

    public void setProfileImageBase64(String profileImageBase64) {
        this.profileImageBase64 = profileImageBase64;
    }

    public float getWaterConsumption() {
        return waterConsumption;
    }

    public void setWaterConsumption(float waterConsumption) {
        this.waterConsumption = waterConsumption;
    }

    public String getWaterStatus() {
        return waterStatus;
    }

    public void setWaterStatus(String waterStatus) {
        this.waterStatus = waterStatus;
    }

    public float getElectricityConsumption() {
        return electricityConsumption;
    }

    public void setElectricityConsumption(float electricityConsumption) {
        this.electricityConsumption = electricityConsumption;
    }

    public String getElectricityStatus() {
        return electricityStatus;
    }

    public void setElectricityStatus(String electricityStatus) {
        this.electricityStatus = electricityStatus;
    }

    public float getRecycleConsumption() {
        return recycleConsumption;
    }

    public void setRecycleConsumption(float recycleConsumption) {
        this.recycleConsumption = recycleConsumption;
    }

    public String getRecycleStatus() {
        return recycleStatus;
    }

    public void setRecycleStatus(String recycleStatus) {
        this.recycleStatus = recycleStatus;
    }

    public float getTotalMonthlyConsumption() {
        return totalMonthlyConsumption;
    }

    public void setTotalMonthlyConsumption(float totalMonthlyConsumption) {
        this.totalMonthlyConsumption = totalMonthlyConsumption;
    }

    public float getMonthlyFootprint() {
        return monthlyFootprint;
    }

    public void setMonthlyFootprint(float monthlyFootprint) {
        this.monthlyFootprint = monthlyFootprint;
    }
}