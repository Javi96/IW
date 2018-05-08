package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Notification {
	
	private long id;
	private long team_id;
	private long deputy;
	private String name;
	private String message;
	
	public Notification() {
		// TODO Auto-generated constructor stub
	}
	
	public Notification(long idTeam, long deputy, String name, String message) {
		this.team_id = idTeam;
		this.deputy= deputy;
		this.name = name;
		this.message = message;
	}
	
	@Id
	@GeneratedValue
	public long getId(){
		return this.id;
	}
	
	@Column
	public long getDeputy() {
		return deputy;
	}
	@Column
	public long getTeam_id() {
		return team_id;
	}
	@Column
	public String getMessage() {
		return message;
	}
	@Column
	public String getName() {
		return name;
	}
	
	public void setDeputy(long deputy) {
		this.deputy = deputy;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	
	public void setTeam_id(long team_id) {
		this.team_id = team_id;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	public void setName(String name) {
		this.name = name;
	}
}