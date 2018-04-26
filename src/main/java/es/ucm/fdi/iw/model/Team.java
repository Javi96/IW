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
	private String training_schedule;
	private String next_match_schedule;
	private String next_match_facilities;
	private String category;

	private League league;
	private RequestTeam request;
	private List<User> players;

//	private byte enabled; // esto que es?

	public Team() {
		// TODO Auto-generated constructor stub
	}

	public Team(String name, String sport, String school, String deputy, String category) {
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

	@Column(unique = true)
	public String getDeputy() {
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

	@ManyToMany(targetEntity = User.class)
	public List<User> getPlayers() {
		return players;
	}

	/*
	@ManyToOne(fetch=FetchType.EAGER)
	public RequestTeam getRequest() {
		return request;
	}
	*/

	@ManyToOne(fetch=FetchType.EAGER)
	public League getLeague() {
		return league;
	}

	@Column
	public String getCategory() {
		return category;
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

	public void setPlayers(List<User> players) {
		this.players = players;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}
}
