package es.ucm.fdi.iw.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import es.ucm.fdi.iw.model.League;
import es.ucm.fdi.iw.model.Match;
import es.ucm.fdi.iw.model.Ranking;
import es.ucm.fdi.iw.model.RankingInfoByTeam;
import es.ucm.fdi.iw.model.Team;

@Controller	
public class RootController {

	private static Logger log = Logger.getLogger(RootController.class);
	
    @ModelAttribute
    public void addAttributes(Model model) {
        model.addAttribute("s", "/static");
    }

	@GetMapping({"/", "/index"})
	public String root(Model model, Principal principal) {
		log.info(principal.getName() + " de tipo " + principal.getClass());		
		// org.springframework.security.core.userdetails.User
		Team fisicasTeam = new Team("Rugby Fisicas","Rugby", "Facultad de Fisicas", "Juan Antonio","Lunes y Miercoles / 14:00 - 15:30 h","Viernes / 13:30 - 15:30","Paraninfo Norte");
		model.addAttribute("team", fisicasTeam);
		return "home";
	}
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	/*@GetMapping("/home")
	public String home() {
		return "home";
	}*/
	
	@RequestMapping(path = "/home",method = RequestMethod.GET)
	public String home(Model model) {
		/*Team fisicasTeam = new Team("Rugby Fisicas","Rugby", "Facultad de Fisicas", "Juan Antonio","Lunes y Miercoles / 14:00 - 15:30 h","Viernes / 13:30 - 15:30","Paraninfo Norte");
		model.addAttribute("team", fisicasTeam);*/
		return "home";
	}
	
	@RequestMapping(path = "/ranking",method = RequestMethod.GET)
	public String classification(Model model) {
		//esta en la tabla ligas, pero es necesario ahora para la prueba
		Team team1 = new Team("Rugby Fisicas","Rugby", "Facultad de Fisicas", "Juan Antonio","Lunes y Miercoles / 14:00 - 15:30 h","Viernes / 13:30 - 15:30","Paraninfo Norte");
		Team team2 = new Team("Rugby Geologicas","Rugby", "Facultad de Geologia", "Ricardo Caballero","Lunes y Jueves / 17:00 - 18:30 h","Viernes / 13:30 - 15:30","Cantarranas");
		Team team3 = new Team("Rugby Filosofia","Rugby", "Facultad de Filosofia", "Mariano Sanchez ","Miercoles y Jueves / 14:00 - 16:30 h","Lunes / 13:30 - 15:30","Cantarranas");
		team3.setId(2);
		team2.setId(1);
		
		//Esta info viene de la tabla partidos con ese formato
		Match m1 = new Match(0,1,2,3);//Fisicas vs Geo 2-3 gana Geo
		Match m2 = new Match(1, 2, 3, 1); //Geo vs Filo gana Geo
		Match m3 = new Match(0,2,3,2); // Fisicas vs Filo gana fisicas
	
		
		List<Match> listOfGames = new ArrayList<Match>();
		listOfGames.add(m1);
		listOfGames.add(m2);
		listOfGames.add(m3);
		//fin tabla partidos
		
		//La tabla liga
		League l = new League("Rugby");
		l.addTeam(team1);
		l.addTeam(team2);
		l.addTeam(team3);
		//fin tabla liga
		
		Ranking ranking = new Ranking();
		RankingInfoByTeam info;
		
		/*
		 * Hago esto para evitar el problema de las n+1 consultas
		 * */
		for(Team t : l.getTeams()) {
			int wins = 0;
			int draws = 0;
			int defeats = 0;
			long teamId = t.getId();
			for(Match m : listOfGames) {
				int homeTeamPoints = m.getHomeTeamPoints();
				int awayTeamPoints = m.getAwayTeamPoints();
				if(teamId == m.getHomeTeamId()) {
					if(homeTeamPoints > awayTeamPoints)//si somos el local y ganamos
						wins++;
					else if (homeTeamPoints == awayTeamPoints) 
						draws++;
					else
						defeats++;
				}
				else if (teamId == m.getAwayTeamId()) {
					if(awayTeamPoints > homeTeamPoints)//si somos el visitante y ganamos
						wins++;
					else if (homeTeamPoints == awayTeamPoints) 
						draws++;
					else
						defeats++;
				}
			}
			info = new RankingInfoByTeam(teamId,t.getName(),wins,draws,defeats);
			ranking.addTeamInfo(info);
		}							
		model.addAttribute("ranking",ranking.getRanking());
		return "ranking";
	}
	
	@RequestMapping(path = "/team",method = RequestMethod.GET)
	public String team(Model model) {
		Team fisicasTeam = new Team("Rugby Fisicas","Rugby", "Facultad de Fisicas", "Juan Antonio","Lunes y Miercoles / 14:00 - 15:30 h","Viernes / 13:30 - 15:30","Paraninfo Norte");
		model.addAttribute("team", fisicasTeam);
		return "team";
	}
	/*@GetMapping("/team")
	public String team() {
		return "team";
	}
	*/
	@GetMapping("/playerTab")
	public String playerTab() {
		return "playerTab";
	}

	@GetMapping("/delegatedTeam")
	public String delegatedTeam() {
		return "delegatedTeam";
	}
	
	@GetMapping("/actas")
	public String actas() {
		return "actas";
	}
	
	@GetMapping("/contact")
	public String contact() {
		return "contact";
	}
	
	@GetMapping("/joinTeam")
	public String joinTeam() {
		return "joinTeam";
	}
	
	@GetMapping("/logout")
	public String logout() {
		return "logout";
	}
	
	@GetMapping("/upload")
	public String upload() {
		return "upload";
	}
	
	@GetMapping("/gallery")
	public String gallery() {
		return "gallery";
	}
	
	@GetMapping("/images")
	public String images() {
		return "images";
	}
	
	@GetMapping("/calendar")
	public String calendar() {
		return "calendar";
	}
	
	@GetMapping("/calendarSport")
	public String calendarSport() {
		return "calendarSport";
	}
	
	@GetMapping("/calendarPrueba")
	public String calendarPrueba() {
		return "calendarPrueba";
	}
}
