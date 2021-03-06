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
	
	private long id;
	private String name;
	private String sport;
	private String category;
	private List<Team> teams;
	
	public League() {
		// TODO Auto-generated constructor stub
	}
	
	public League(String name, String sport, String category) {
		this.name = name;
		this.sport = sport;
		this.category = category;
		this.teams = new ArrayList<Team>();
	}

	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}	

	@Column(unique=true)
	public String getName() {
		return name;
	}
	
	@OneToMany(mappedBy = "league" )
	public List<Team> getTeams() {
		return teams;
	}
	
	@Column
	public String getSport() {
		return sport;
	}
	
	@Column
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
	public void setSport(String sport) {
		this.sport = sport;
	}
	
	public void setId(long id) {
		this.id = id;
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
			if(aux.getId() == teamId || aux.getName().equals(t.getName())) {
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
