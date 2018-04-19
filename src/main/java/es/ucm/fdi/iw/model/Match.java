package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Match {
	
	private long id;
	private int homeTeamId;
	private int awayTeamId;
	private int homeTeamPoints;
	private int awayTeamPoints;
	
	public Match(int homeTeamId, int awayTeamId, int homeTeamPoints, int awayTeamPoints) {
		this.homeTeamId = homeTeamId;
		this.awayTeamId = awayTeamId;
		this.homeTeamPoints = homeTeamPoints;
		this.awayTeamPoints = awayTeamPoints;
	}
	
	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}

	@Column
	public int getAwayTeamId() {
		return awayTeamId;
	}
	
	@Column
	public int getAwayTeamPoints() {
		return awayTeamPoints;
	}
	
	@Column
	public int getHomeTeamPoints() {
		return homeTeamPoints;
	}
	
	@Column
	public int getHomeTeamId() {
		return homeTeamId;
	}
	
	public void setId(long id) {
		this.id = id;
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
