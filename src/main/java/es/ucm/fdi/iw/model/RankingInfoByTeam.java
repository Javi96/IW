package es.ucm.fdi.iw.model;

public class RankingInfoByTeam {
	
	private String name;
	private long teamId;
	private int wins;
	private int draws;
	private int defeats;
	
	public RankingInfoByTeam(long teamId, String teamName, int wins, int draws, int defeats) {
		this.teamId = teamId;
		this.name = teamName;
		this.wins = wins;
		this.draws = draws;
		this.defeats = defeats;
	}
	
	public int getDefeats() {
		return defeats;
	}
	
	public int getDraws() {
		return draws;
	}
	
	public String getName() {
		return name;
	}
	
	public int getWins() {
		return wins;
	}
	
	public void setDefeats(int defeats) {
		this.defeats = defeats;
	}
	
	public void setDraws(int draws) {
		this.draws = draws;
	}
	
	public void setName(String teamName) {
		this.name = teamName;
	}
	
	public void setWins(int wins) {
		this.wins = wins;
	}
	
	public long getTeamId() {
		return teamId;
	}
	
	public void setTeamId(long teamId) {
		this.teamId = teamId;
	}
	
}
