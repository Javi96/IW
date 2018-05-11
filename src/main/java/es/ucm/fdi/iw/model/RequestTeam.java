package es.ucm.fdi.iw.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class RequestTeam {

	private long id;
	private Team team; // El equipo al que se quiere ingresar
	private User user; // El usuario que quiere ingresar
	
	public RequestTeam() {
		// TODO Auto-generated constructor stub
	}

	public RequestTeam(Team team, User user) {
		this.team = team;
		this.user = user;
	}
	
	@Id
	@GeneratedValue
	public long getId(){
		return this.id;
	}
	
	@ManyToOne
	public Team getTeam() {
		return team;
	}
	
	@ManyToOne
	public User getUser() {
		return user;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	
	public void setTeam(Team team) {
		this.team = team;
	}
	
	public void setUser(User user) {
		this.user = user;
	}

}
