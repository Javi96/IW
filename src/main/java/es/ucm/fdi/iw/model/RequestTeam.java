package es.ucm.fdi.iw.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class RequestTeam {
	
	private long id;
	private long idTeam;
	private String login;
	private List<Team> teams;

	public RequestTeam(long idTeam, String login) {
		
		this.idTeam = idTeam;
		this.login = login;
		this.teams = new ArrayList<Team>();
	}

	
	//SET
	public void setId(long id) {
		this.id = id;
	}
	
	
	public void setIdTeam(long idTeam) {
		this.idTeam = idTeam;
	}
	
	public void setLogin(String l) {
		this.login = l;
	}
	
	public void setTeams(List<Team> teams) {
		this.teams = teams;
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
	public String getLogin() {
		return this.login;
	}
	
	/*
	@OneToMany(mappedBy = "Team" )
	public List<Team> getTeams() {
		return teams;
	}
	*/
}
