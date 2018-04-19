package es.ucm.fdi.iw.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

@Entity
public class Team {
	

	private long id;
	private String name;
	private String school;
	private String sport;
	private String deputy;
	private String trainingSchedule;
	private String nextMatchSchedule;
	private String nextMatchFacilities;
	private League league;
	private List<User> players; 
	
//	private byte enabled; // esto que es? 
	
	public Team() {
		// TODO Auto-generated constructor stub
	}
	
	public Team(String name, String sport, String school, String deputy) {
		this.name = name;
		this.sport = sport;
		this.school = school;
		this.deputy = deputy;
	}
	
	public Team(String name, String sport, String school, String deputy, String trainingSchedule,String nextMatchSchedule, String nextMatchFacilities) {
		this.name = name;
		this.sport = sport;
		this.school = school;
		this.deputy = deputy;
		this.trainingSchedule = trainingSchedule;
		this.nextMatchSchedule = nextMatchSchedule;
		this.nextMatchFacilities = nextMatchFacilities;
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
	
	@Column(unique = true)
	public String getDeputy() {
		return deputy;
	}
	
	@Column
	public String getNextMatchFacilities() {
		return nextMatchFacilities;
	}
	
	@Column
	public String getNextMatchSchedule() {
		return nextMatchSchedule;
	}
	
	@Column
	public String getTrainingSchedule() {
		return trainingSchedule;
	}
	
	@ManyToMany(targetEntity = User.class)
	public List<User> getPlayers() {
		return players;
	}
	
	@ManyToOne(fetch=FetchType.EAGER)
	public League getLeague() {
		return league;
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
	
	public void setDeputy(String deputy) {
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
	
	public void setPlayers(List<User> players) {
		this.players = players;
	}
	
}
