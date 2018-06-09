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
	private Team team;
	private String name;
	private String message;
	private String email;
	
	public Notification() {
		// TODO Auto-generated constructor stub
	}
	
	public Notification(User deputy, String name, String message, String email,Team team) {
		this.deputy= deputy;
		this.name = name;
		this.message = message;
		this.email = email;
		this.team = team;
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
	
	@Column//(unique = true)
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
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
	
	@ManyToOne(targetEntity = Team.class)
	public Team getTeam() {
		return team;
	}
	
	public void setTeam(Team team) {
		this.team = team;
	}
}