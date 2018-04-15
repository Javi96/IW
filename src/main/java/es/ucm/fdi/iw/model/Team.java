package es.ucm.fdi.iw.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

@Entity
public class Team {
	
	@Id
	@GeneratedValue
	private long id;
	
	@Column(unique = true)
	private String name;
	
	@Column
	private String school;
	
	@Column
	private String sport;
	
	@Column(unique = true)
	private String deputy;
	
	@Column
	private String trainingSchedule;
	
	@Column
	private String nextMatchSchedule;
	
	@Column
	private String nextMatchFacilities;
	
	//OR LAZY
	@ManyToOne(fetch=FetchType.EAGER) 
	@JoinColumn(name="league_id")
	private League league;
	
	@ManyToMany
	@JoinTable(name = "team_players", joinColumns = @JoinColumn(name = "team_id"), inverseJoinColumns = @JoinColumn(name = "player_id"))
	private List<User> players; 
	
	@ManyToMany
	@JoinTable(name = "team-accords", joinColumns = @JoinColumn(name = "team_id"), inverseJoinColumns = @JoinColumn(name = "accord_id"))
	private List<Accord> accords;
	
	
//	private byte enabled; // esto que es? 
	
	public Team(String name, String sport, String school, String deputy, String trainingSchedule,String nextMatchSchedule, String nextMatchFacilities) {
		this.name = name;
		this.sport = sport;
		this.school = school;
		this.deputy = deputy;
		this.trainingSchedule = trainingSchedule;
		this.nextMatchSchedule = nextMatchSchedule;
		this.nextMatchFacilities = nextMatchFacilities;
	}

	public long getId() {
		return id;
	}
	
	public void setId(long id) {
		this.id = id;
	}	
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getSchool() {
		return school;
	}
	
	public void setSchool(String school) {
		this.school = school;
	}
	
	public String getSport() {
		return sport;
	}
	
	public void setSport(String sport) {
		this.sport = sport;
	}
	
	public String getDeputy() {
		return deputy;
	}
	
	public void setDeputy(String deputy) {
		this.deputy = deputy;
	}
	
	public String getNextMatchFacilities() {
		return nextMatchFacilities;
	}
	
	public String getNextMatchSchedule() {
		return nextMatchSchedule;
	}
	
	public String getTrainingSchedule() {
		return trainingSchedule;
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
	
	
}
