package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class MatchRecord {
	
	private long id;
	private int homeTeamPoints;
	private int awayTeamPoints;
	
	//Se podria suprimir el id y poner homeTeamId y awayteamId de clave primaria
	
	public MatchRecord(long id, int homeTeamPoints, int awayTeamPoints) {
		this.id = id;
		this.homeTeamPoints = homeTeamPoints;
		this.awayTeamPoints = awayTeamPoints;
	}
	
	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}
	
	@Column
	public int getAwayTeamPoints() {
		return awayTeamPoints;
	}
	
	@Column
	public int getHomeTeamPoints() {
		return homeTeamPoints;
	}
	
	public void setAwayTeamPoints(int awayTeamPoints) {
		this.awayTeamPoints = awayTeamPoints;
	}
	
	public void setHomeTeamPoints(int homeTeamPoints) {
		this.homeTeamPoints = homeTeamPoints;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	
}
