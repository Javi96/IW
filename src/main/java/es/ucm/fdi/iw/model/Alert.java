package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;

@Entity
public class Alert {

	
	private long id;
	
	private Match match;
	
	private String msgHome;
	
	private String msgAway;
	
	public Alert() {
		// TODO Auto-generated constructor stub
	}
	
	public Alert(Match m, String msgHome, String msgAway) {
		this.msgHome=msgHome;
		this.msgAway=msgAway;
		this.match = m;
	}
	
	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}
	
	@Column
	public String getMsgAway() {
		return msgAway;
	}
	
	@Column
	public String getMsgHome() {
		return msgHome;
	}
	
	public void setMsgAway(String msgAway) {
		this.msgAway = msgAway;
	}
	
	public void setMsgHome(String msgHome) {
		this.msgHome = msgHome;
	}
	
	@OneToOne
	public Match getMatch() {
		return match;
	}
	
	public void setMatch(Match match) {
		this.match = match;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	

	
}
