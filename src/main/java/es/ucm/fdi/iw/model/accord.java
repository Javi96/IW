package es.ucm.fdi.iw.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;

@Entity
public class accord {
	
	@OneToOne //match
	@ManyToMany(mappedBy = "team")
	
	private List<Team> teams;
	
	
	@Id
	@GeneratedValue
	private long id;
	
	@Column
	private Match match; //objeto partido
	
	@Column
	private int homeTeamId;
	
	@Column
	private int awayTeamId;
	
	private int matchId; 
	private int homeTeamPoints;
	private int awayTeamPoints;
	private String homeTeam;
	private String awayTeam;
	
	/*
	 * guardamos:
	 *  el partido join con los id de los equipos
	 *  equipoLocal equipoVisitante para obtener el id (que sera guardado en la tabla)
	 */
	
	public accord(String homeTeam, String awayTeam, int homeTeamPoints, int awayTeamPoints) {
		
		//por parametro
		this.homeTeam = homeTeam; 
		this.awayTeam = awayTeam;
		this.homeTeamPoints = homeTeamPoints;
		this.awayTeamPoints = awayTeamPoints;
		
		//consultas BBDD
		//this.homeTeamId = ;
		//this.awayTeamId = ;
		//this.match = //consulta con los id de equipos para obtener idPartido
		//this.matchId =  //consulta sobre el partido devuelto
		
	}
	

	public long getId() {
		return this.id;
	}
	
	public void setId(long id) {
		this.id = id;
	}	
	
	public void setAwayTeamName(String awayName) {
		this.awayTeam = awayName;
	}
	
	public void setHomeTemaName(String HomeName) {
		this.homeTeam = HomeName;
	}
	
	public String getAwayTeamName() {
		return this.awayTeam;
	}
	
	public String getHomeTemaName() {
		return this.homeTeam;
	}
	
	public int getAwayTeamPoints() {
		return this.awayTeamPoints;
	}
	
	public int getHomeTeamPoints() {
		return this.homeTeamPoints;
	}
	
	public void setHomeTeamPoints(int homeTeamPoints) {
		this.homeTeamPoints = homeTeamPoints;
	}
	
	public void setAwayTeamPoints(int awayTeamPoints) {
		this.awayTeamPoints = awayTeamPoints;
	}
	
	public int getAwayTeamId() {
		return this.awayTeamId;
	}
	
	public int getHomeTeamId() {
		return this.homeTeamId;
	}
	
	public void setAwayTeamId(int awayTeamId) {
		this.awayTeamId = awayTeamId;
	}
	
	public void setHomeTeamId(int homeTeamId) {
		this.homeTeamId = homeTeamId;
	}
	
	public Match getMatch() {
		return this.match;
	}
	
	public void setMatch(Match match) {
		this.match = match;
	}
	
	public int getMathId() {
		return this.matchId;
	}
	
	public void setMathId(int mathId) {
		this.matchId = mathId;
	}
	
}
