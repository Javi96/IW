package es.ucm.fdi.iw.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

@Entity
public class User {
	private long id;
	private String login;
	private String password;
	private String roles; // split by , to separate roles
	private String name;
	private String idCard;
	private byte enabled;

	private List<Team> teams;

	private List<Notification> notifications;


	@Id
	@GeneratedValue
	public long getId() {
	return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(unique=true)
	public String getLogin() {
		return login;
	}

	@ManyToMany(mappedBy = "players")
	public List<Team> getTeams() {
		return teams;
	}

	@Column
	public String getName() {
		return name;
	}

	@OneToMany(targetEntity = Notification.class , mappedBy = "deputy", fetch=FetchType.EAGER)
	public List<Notification> getNotifications() {
		return notifications;
	}

	@Column(unique=true)
	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public void setNotifications(List<Notification> notifications) {
		this.notifications = notifications;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRoles() {
		return roles;
	}

	public void setRoles(String roles) {
		this.roles = roles;
	}

	@Transient
	public boolean isAdmin() {
		return roles.contains("ADMIN");
	}

	public byte getEnabled() {
		return enabled;
	}

	public void setEnabled(byte enabled) {
		this.enabled = enabled;
	}

	public void setTeams(List<Team> teams) {
		this.teams = teams;
	}
}
