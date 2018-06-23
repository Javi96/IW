package es.ucm.fdi.iw.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Alert {

	
	private long id;
	
	private String msg;
	
	public Alert() {
		// TODO Auto-generated constructor stub
	}
	
	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}
	
	@Column
	public String getMsg() {
		return msg;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
}
