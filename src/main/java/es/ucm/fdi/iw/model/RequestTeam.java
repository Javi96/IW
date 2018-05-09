package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class RequestTeam {

	private long id;
	private Team team; // El equipo al que se quiere ingresar
	private User user; // El usuario que quiere ingresar
	private String id_card_nr;
	private String name;
	
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
	
	@Column
	public String getId_card_nr() {
		return id_card_nr;
	}
	
	@Column
	public String getName() {
		return name;
	}
	
	public void setId_card_nr(String id_card_nr) {
		this.id_card_nr = id_card_nr;
	}
	
	public void setName(String name) {
		this.name = name;
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
