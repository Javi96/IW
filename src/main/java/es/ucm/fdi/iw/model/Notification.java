package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Notification {
	
	private long id;
	private User deputy;
	private String name;
	private String message;
	
	public Notification() {
		// TODO Auto-generated constructor stub
	}
	
	public Notification(User deputy, String name, String message) {
		this.deputy= deputy;
		this.name = name;
		this.message = message;
	}
	
	@Id
	@GeneratedValue
	public long getId(){
		return this.id;
	}
	
	@ManyToOne(targetEntity = User.class)
	public User getDeputy() {
		return deputy;
	}

	@Column
	public String getMessage() {
		return message;
	}
	@Column
	public String getName() {
		return name;
	}
	
	public void setDeputy(User deputy) {
		this.deputy = deputy;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	public void setName(String name) {
		this.name = name;
	}
}