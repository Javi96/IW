package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class RequestTeam {

	private long id;
	@ManyToOne
	private long team_id;
	private long user_id; //El usuario que envio la peticion de entrar al equipo

	
	
	public RequestTeam() {
		// TODO Auto-generated constructor stub
	}

	public RequestTeam(long idTeam, long user) {
		this.team_id = idTeam;
		this.user_id = user;
	}

	@Id
	@GeneratedValue
	public long getId(){
		return this.id;
	}
	@Column
	public long getTeam_id() {
		return team_id;
	}
	@Column
	public long getUser_id() {
		return user_id;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	
	public void setTeam_id(long team_id) {
		this.team_id = team_id;
	}
	
	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}

}
