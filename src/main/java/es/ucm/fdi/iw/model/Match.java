package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Match {
	
	@Id
	@GeneratedValue
	private long id;
	
	@Column
	private int homeTeamId;
	
	@Column
	private int awayTeamId;
	
	@Column
	private int homeTeamPoints;
	
	@Column
	private int awayTeamPoints;
	
	//Se podria suprimir el id y poner homeTeamId y awayteamId de clave primaria
	
	public Match(int homeTeamId, int awayTeamId, int homeTeamPoints, int awayTeamPoints) {
		this.homeTeamId = homeTeamId;
		this.awayTeamId = awayTeamId;
		this.homeTeamPoints = homeTeamPoints;
		this.awayTeamPoints = awayTeamPoints;
	}
	

	public long getId() {
		return id;
	}
	
	public void setId(long id) {
		this.id = id;
	}	

	public int getAwayTeamId() {
		return awayTeamId;
	}
	
	public int getAwayTeamPoints() {
		return awayTeamPoints;
	}
	
	public int getHomeTeamPoints() {
		return homeTeamPoints;
	}
	
	public int getHomeTeamId() {
		return homeTeamId;
	}
	
	public void setAwayTeamId(int awayTeamId) {
		this.awayTeamId = awayTeamId;
	}
	
	public void setAwayTeamPoints(int awayTeamPoints) {
		this.awayTeamPoints = awayTeamPoints;
	}
	
	public void setHomeTeamId(int homeTeamId) {
		this.homeTeamId = homeTeamId;
	}
	
	public void setHomeTeamPoints(int homeTeamPoints) {
		this.homeTeamPoints = homeTeamPoints;
	}
	
}
