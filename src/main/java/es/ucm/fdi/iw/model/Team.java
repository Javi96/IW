package es.ucm.fdi.iw.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Team {

	private long id;
	private String name;
	private String school;
	private String sport;
	private String training_schedule;
	private String next_match_schedule;
	private String next_match_facilities;
	private String category;
	private User deputy;
	private League league;
	
	private List<RequestTeam> requests;
	
	//lista cambio platilla
	private List<User> activePlayers;
	
	//lista de fichas activas
	private List<User> noActivePlayers;
	
	private List<Match> awayMatches;
	
	private List<Match> homeMatches;
	
//	private byte enabled; // esto que es?

	public Team() {
		// TODO Auto-generated constructor stub
	}

	public Team(String name, String sport, String school, User deputy, String category) {
		this.name = name;
		this.sport = sport;
		this.school = school;
		this.deputy = deputy;
		this.category = category;
	}

	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}

	@Column(unique = true)
	public String getName() {
		return name;
	}

	@Column
	public String getSchool() {
		return school;
	}

	@Column
	public String getSport() {
		return sport;
	}

	@OneToOne(targetEntity = User.class)
	public User getDeputy() {
		return deputy;
	}

	@Column
	public String getNext_match_facilities() {
		return next_match_facilities;
	}

	@Column
	public String getNext_match_schedule() {
		return next_match_schedule;
	}

	@Column
	public String getTraining_schedule() {
		return training_schedule;
	}
	
	/*
	@Column
	public List<Long> getPlayerActive() {
		return playerActive;
	}
	*/
	@ManyToMany(targetEntity = User.class)
	public List<User> getActivePlayers() {
		return activePlayers;
	}
	
	@ManyToMany(targetEntity = User.class)
	public List<User> getNoActivePlayers() {
		return this.noActivePlayers;
	}
	
	
	@OneToMany(mappedBy = "team")
	public List<RequestTeam> getRequests() {
		return requests;
	}
	
	public void setRequests(List<RequestTeam> requests) {
		this.requests = requests;
	}

	@ManyToOne(fetch=FetchType.EAGER)
	public League getLeague() {
		return league;
	}

	@Column
	public String getCategory() {
		return category;
	}

	@OneToMany(mappedBy = "awayTeam")
	public List<Match> getAwayMatches() {
		return awayMatches;
	}
	
	@OneToMany(mappedBy = "homeTeam")
	public List<Match> getHomeMatches() {
		return homeMatches;
	}
	
	public void setAwayMatches(List<Match> awayMatches) {
		this.awayMatches = awayMatches;
	}
	
	public void setHomeMatches(List<Match> homeMatches) {
		this.homeMatches = homeMatches;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public void setSport(String sport) {
		this.sport = sport;
	}

	public void setDeputy(User deputy) {
		this.deputy = deputy;
	}

	public void setNext_match_facilities(String next_match_facilities) {
		this.next_match_facilities = next_match_facilities;
	}

	public void setNext_match_schedule(String next_match_schedule) {
		this.next_match_schedule = next_match_schedule;
	}

	public void setTraining_schedule(String training_schedule) {
		this.training_schedule = training_schedule;
	}

	public void setLeague(League league) {
		this.league = league;
	}

	public void setActivePlayers(List<User> players) {
		this.activePlayers = players;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setNoActivePlayers(List<User> players) {
		this.noActivePlayers = players;
	}
}
