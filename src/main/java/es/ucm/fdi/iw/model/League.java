package es.ucm.fdi.iw.model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class League {
	
	@Id
	@GeneratedValue
	private long id;

	@Column(unique=true)
	private String name;
	
	@OneToMany(mappedBy = "league" )
	private List<Team> teams;
	
	//private String photo;
	
	public League(String name) {
		this.name = name;
		this.teams = new ArrayList<Team>();
	}

	public long getId() {
		return id;
	}
	
	public void setId(long id) {
		this.id = id;
	}	

	public String getName() {
		return name;
	}
	
	public List<Team> getTeams() {
		return teams;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setTeams(List<Team> teams) {
		this.teams = teams;
	}
	
	/*
	 * Añade un equipo a la liga si dicho equipo no equiste
	 * */
	public boolean addTeam(Team t) {
		long teamId = t.getId();
		Iterator<Team> it = teams.iterator();
		boolean found = false;
		boolean result = false;
		while(it.hasNext() && !found) {
			Team aux = it.next();
			if(aux.getId() == teamId) {
				found = true;
			}
		}
		if(!found) {
			this.teams.add(t);
			result = true;
		}
		return result;
	}
	
	public boolean deleteTeam(int teamId) {
		boolean found = false;
		Iterator<Team> it = teams.iterator();
		while(it.hasNext() && !found) {
			Team aux = it.next();
			if(aux.getId() == teamId) {
				found = true;
				it.remove();
			}
		}
		return found;
	}
}
