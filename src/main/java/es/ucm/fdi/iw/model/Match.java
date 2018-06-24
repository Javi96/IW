package es.ucm.fdi.iw.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Match {
	
	private long id;
	private Team homeTeam;
	private Team awayTeam;
	private int homeTeamPoints;
	private int awayTeamPoints;
	private Date matchDate;

	private boolean recordChecked; // true si se ha confirmado el acta del partido
	
	private Alert alert;
	
	public Match() {
		// TODO Auto-generated constructor stub
	}
	
	public Match(Team homeTeam, Team awayTeam, int homeTeamPoints, int awayTeamPoints, Date matchDate) {
		this.homeTeam = homeTeam;
		this.awayTeam = awayTeam;
		this.homeTeamPoints = homeTeamPoints;
		this.awayTeamPoints = awayTeamPoints;
		this.matchDate = matchDate;
	}
	
	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}

	@ManyToOne
	public Team getAwayTeam() {
		return awayTeam;
	}
	
	@ManyToOne
	public Team getHomeTeam() {
		return homeTeam;
	}
	
	@Column
	public int getAwayTeamPoints() {
		return awayTeamPoints;
	}
	
	@Column
	public int getHomeTeamPoints() {
		return homeTeamPoints;
	}
	
	@Temporal(TemporalType.DATE)
	@Column
	public Date getMatchDate() {
		return matchDate;
	}
	
	@Column
	public boolean isRecordChecked() {
		return recordChecked;
	}
	
	@OneToOne
	public Alert getAlert() {
		return alert;
	}
	
	public void setAlert(Alert alert) {
		this.alert = alert;
	}
	
	public void setRecordChecked(boolean recordChecked) {
		this.recordChecked = recordChecked;
	}
	
	public void setMatchDate(Date matchDate) {
		this.matchDate = matchDate;
	}
	
	public void setId(long id) {
		this.id = id;
	}	
	
	public void setAwayTeam(Team awayTeam) {
		this.awayTeam = awayTeam;
	}
	
	public void setAwayTeamPoints(int awayTeamPoints) {
		this.awayTeamPoints = awayTeamPoints;
	}
	
	public void setHomeTeam(Team homeTeam) {
		this.homeTeam = homeTeam;
	}
	
	public void setHomeTeamPoints(int homeTeamPoints) {
		this.homeTeamPoints = homeTeamPoints;
	}
	
}
