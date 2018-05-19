package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class MatchRecord {
	
	private long id;
	private long matchId; // no he puesto el tipo Match porque me viene mejor el match id par enviar los datos en el post
	private long teamId; // el equipo que ha creado el acta
	private int homeTeamPoints;
	private int awayTeamPoints;
	
	public MatchRecord() {
		// TODO Auto-generated constructor stub
	}
	
	public MatchRecord(long id, long match, int homeTeamPoints, int awayTeamPoints) {
		this.id = id;
		this.matchId = match;
		this.homeTeamPoints = homeTeamPoints;
		this.awayTeamPoints = awayTeamPoints;
	}
	
	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}
	
	@Column
	public long getMatchId() {
		return matchId;
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
	public long getTeamId() {
		return teamId;
	}
	
	public void setTeamId(long teamId) {
		this.teamId = teamId;
	}
	
	public void setAwayTeamPoints(int awayTeamPoints) {
		this.awayTeamPoints = awayTeamPoints;
	}
	
	public void setHomeTeamPoints(int homeTeamPoints) {
		this.homeTeamPoints = homeTeamPoints;
	}
	
	public void setMatchId(long matchId) {
		this.matchId = matchId;
	}
	
	public void setId(long id) {
		this.id = id;
	}
}
