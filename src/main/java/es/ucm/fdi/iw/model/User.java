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
	private String email;
	private byte enabled;

	//equipos en los que el jugador esta convocado
	private List<Team> activeTeams;

	//equipos en los que el jugador  NO esta convocado
	private List<Team> nonActiveTeams;
		
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

	@ManyToMany(mappedBy = "activePlayers",fetch = FetchType.EAGER)
	public List<Team> getActiveTeams() {
		return activeTeams;
	}
	
	@ManyToMany(mappedBy = "nonActivePlayers",fetch = FetchType.EAGER)
	public List<Team> getNonActiveTeams() {
		return nonActiveTeams;
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
	
	@Column(unique=true)
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
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

	public void setActiveTeams(List<Team> teams) {
		this.activeTeams = teams;
	}
	public void setNonActiveTeams(List<Team> teams) {
		this.nonActiveTeams = teams;
	}
}
