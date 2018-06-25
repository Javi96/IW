package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Notification {
	
	private long id;
	private User transmitter;
	private User receiver;
	private String date;
	private String message;
	
	public Notification() {
		// TODO Auto-generated constructor stub
	}
	
	public Notification(User transmitter, User receiver, String message) {
		this.message = message;
		this.transmitter = transmitter;
		this.receiver = receiver;
	}
	
	@Id
	@GeneratedValue
	public long getId(){
		return this.id;
	}
	
	@ManyToOne(targetEntity = User.class, fetch=FetchType.EAGER)
	public User getTransmitter() {
		return transmitter;
	}
	
	@ManyToOne(targetEntity = User.class, fetch=FetchType.EAGER)
	public User getReceiver() {
		return receiver;
	}
	
	@Column
	public String getMessage() {
		return message;
	}
	
	public String getDate() {
		return date;
	}
	
	public void setDate(String date) {
		this.date = date;
	}
	
	public void setReceiver(User receiver) {
		this.receiver = receiver;
	}
	
	public void setTransmitter(User transmitter) {
		this.transmitter = transmitter;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
}