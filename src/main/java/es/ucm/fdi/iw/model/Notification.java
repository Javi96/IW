package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.springframework.ui.Model;

@Entity
public class Notification {
	
	private long id;
	private long idTeam;
	private String deputy;
	private String name;
	private String message;
	
	
	public Notification(long idTeam, String deputy, String name, String message) {
		
		this.idTeam = idTeam;
		this.deputy= deputy;
		this.name = name;
		this.message = message;
	}
	
	//SET
	public void setId(long id) {
		this.id = id;
	}
	
	
	public void setIdTeam(long idTeam) {
		this.idTeam = idTeam;
	}
	
	
	public void setDebuty(String d) {
		this.deputy=d;	
	}
	
	public void setName(String n) {
		this.name=n;	
	}
	
	public void setMessage(String m) {
		this.message = m;
	}

	//GET
	@Id
	@GeneratedValue
	public long getId(){
		return this.id;
	}
	
	@Column
	public long getIdTeam() {
		return this.idTeam;
	}
	
	@Column
	public String getDebuty() {
		return this.deputy;	
	}
	
	@Column
	public String getName() {
		return this.name;
	}
	
	@Column
	public String getMessage() {
		return this.message;
	}
	
}
