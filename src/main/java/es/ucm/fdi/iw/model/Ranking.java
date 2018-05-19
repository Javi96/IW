package es.ucm.fdi.iw.model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Ranking {
	private List<RankingInfoByTeam> ranking;
	private League league;
	
	public Ranking(League league) {
		this.ranking = new ArrayList<RankingInfoByTeam>();
		this.league = league;
		createRanking();
	}
	
	public List<RankingInfoByTeam> getRanking() {
		return ranking;
	}
	
	public void setRanking(List<RankingInfoByTeam> ranking) {
		this.ranking = ranking;
	}
	/*
	 * Este metodo recibe la informacion acerca de un equipo y lo añade al ranking con dicha informacion,
	 * en la posicion del ranking que le corresponde, lista para enviarla a la vista
	 * */
	private boolean addTeamInfo(RankingInfoByTeam newInfo) {
		boolean result = false;
		
		if(!exist(newInfo)) {//si el equipo no esta en el ranking, se añade en su posicion correspondiente
			Iterator<RankingInfoByTeam> it = this.ranking.iterator();
	
			while(it.hasNext() && !result) {
				RankingInfoByTeam teamInfo = it.next();
				int index = this.ranking.indexOf(teamInfo);
				//si he llegado a la pos en la que el equipo que existe tiene menos victorias que le nuevo
				if(teamInfo.getWins() < newInfo.getWins() ) {
					this.ranking.add(index,newInfo);
					result = true;
				}
				else if (teamInfo.getWins() == newInfo.getWins()) {//si tienen las mismas victorias
					if(teamInfo.getDraws() < newInfo.getDraws()) {
						this.ranking.add(index,newInfo);
						result = true;
					}
				}
			}
			if(!result)
				this.ranking.add(newInfo);
		}
		return result;
	}

	/*
	 * Devuelve true en caso de existir la informacion asociada a un equipo en la lista
	 * Devuelve false si el equipo no esta en el ranking
	 * */
	private boolean exist(RankingInfoByTeam info) {
		boolean found = false;
		Iterator<RankingInfoByTeam> it = this.ranking.iterator();
		while(it.hasNext() && !found) {
			RankingInfoByTeam inf = it.next();
			if(inf.getTeamId() == info.getTeamId()) {
				found = true;
			}
		}
		return found;
	}
	
	private void createRanking() {
		RankingInfoByTeam info;
			
		for(Team t : league.getTeams()) {
			List<Match> listOfGames = new ArrayList<Match>();
			listOfGames.addAll(t.getAwayMatches());
			listOfGames.addAll(t.getHomeMatches());
			int wins = 0;
			int draws = 0;
			int defeats = 0;
			long teamId = t.getId();
			for(Match m : listOfGames) {
				if(m.isRecordChecked()) {//solo muestra el ranking de los partidos cuyas actas han sido confirmadas 
					int homeTeamPoints = m.getHomeTeamPoints();
					int awayTeamPoints = m.getAwayTeamPoints();
					if(teamId == m.getHomeTeam().getId()) {
						if(homeTeamPoints > awayTeamPoints)//si somos el local y ganamos
							wins++;
						else if (homeTeamPoints == awayTeamPoints)
							draws++;
						else
							defeats++;
					}
					else if (teamId == m.getAwayTeam().getId()) {
						if(awayTeamPoints > homeTeamPoints)//si somos el visitante y ganamos
							wins++;
						else if (homeTeamPoints == awayTeamPoints)
							draws++;
						else
							defeats++;
					}
				}
			}
			info = new RankingInfoByTeam(teamId,t.getName(),wins,draws,defeats);
			addTeamInfo(info);
		}
	}
	
}
