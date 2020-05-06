package com.srccodes.beans;

public class Booking {
	private java.sql.Date checkin;
	private java.sql.Date checkout;
	public float price;
	private int clientId;
	private int propertyId;
	
	public java.sql.Date getCheckin() {
		return checkin;
	}
	
	public void setCheckin(java.sql.Date checkin) {
		this.checkin = checkin;
	}
	
	public java.sql.Date getCheckout() {
		return checkout;
	}
	
	public void setCheckout(java.sql.Date checkout) {
		this.checkout = checkout;
	}
	
	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}
	
	public int getClientId() {
		return clientId;
	}
	
	public void setClientId(int clientId) {
		this.clientId = clientId;
	}
	
	public int getPropertyId() {
		return propertyId;
	}
	
	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}

}
