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
	private String trainingSchedule;
	private String nextMatchSchedule;
	private String nextMatchFacilities;
	private String category;
	private User deputy;
	private String teamPhoto;
	private League league;
	private String description;
	
	private List<RequestTeam> requests;
	
	//lista cambio platilla
	private List<User> activePlayers;
	
	//lista de fichas activas
	private List<User> nonActivePlayers;
	
	private List<Match> awayMatches;
	
	private List<Match> homeMatches;
	
//	private byte enabled; 

	public Team() {
		// TODO Auto-generated constructor stub
	}

	public Team(String name, String sport, String school, User deputy, String category, String desc) {
		this.name = name;
		this.sport = sport;
		this.school = school;
		this.deputy = deputy;
		this.category = category;
		this.description = (desc == null) ? "" : desc;
	}
	public Team(String name, String sport, String school, User deputy, String category) {
		this.name = name;
		this.sport = sport;
		this.school = school;
		this.deputy = deputy;
		this.category = category;
		this.description =  "";
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
	public String getDescription() {
		return description;
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
	public String getNextMatchSchedule() {
		return nextMatchSchedule;
	}
	

	@ManyToMany(targetEntity = User.class,fetch = FetchType.EAGER)

	public List<User> getActivePlayers() {
		return activePlayers;
	}
	
	@ManyToMany(targetEntity = User.class,fetch = FetchType.EAGER)
	public List<User> getNonActivePlayers() {
		return nonActivePlayers;
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
	
	@Column
	public String getNextMatchFacilities() {
		return nextMatchFacilities;
	}
	
	@Column
	public String getTrainingSchedule() {
		return trainingSchedule;
	}
	
	@Column
	public String getTeamPhoto() {
		return teamPhoto;
	}
	
	public void setTeamPhoto(String teamPhoto) {
		this.teamPhoto = teamPhoto;
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

	public void setDescription(String desc) {
		this.description = desc;
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

	public void setNextMatchFacilities(String nextMatchFacilities) {
		this.nextMatchFacilities = nextMatchFacilities;
	}
	
	public void setNextMatchSchedule(String nextMatchSchedule) {
		this.nextMatchSchedule = nextMatchSchedule;
	}
	
	public void setTrainingSchedule(String trainingSchedule) {
		this.trainingSchedule = trainingSchedule;
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

	public void setNonActivePlayers(List<User> players) {
		this.nonActivePlayers = players;
	}
	
}
