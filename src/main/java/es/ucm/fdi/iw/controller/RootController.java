package es.ucm.fdi.iw.controller;

import java.security.Principal;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.http.HttpSession;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import es.ucm.fdi.iw.model.League;

import es.ucm.fdi.iw.model.Match;
import es.ucm.fdi.iw.model.MatchRecord;
import es.ucm.fdi.iw.model.Ranking;
import es.ucm.fdi.iw.model.RankingInfoByTeam;

import es.ucm.fdi.iw.model.Team;
import es.ucm.fdi.iw.model.User;

@Controller	
public class RootController {

	private static Logger log = Logger.getLogger(RootController.class);
	
	@Autowired
	private EntityManager entityManager;
	
    @ModelAttribute
    public void addAttributes(Model model) {
        model.addAttribute("s", "/static");
    }

	@GetMapping({"/", "/index"})
	public String root(Model model, HttpSession session, Principal principal) {
		log.info(principal.getName() + " de tipo " + principal.getClass());		
		// org.springframework.security.core.userdetails.User
		Team fisicasTeam = new Team("Rugby Fisicas","Rugby", "Facultad de Fisicas", 1,"Lunes y Miercoles / 14:00 - 15:30 h","Viernes / 13:30 - 15:30","Paraninfo Norte");	
		model.addAttribute("team", fisicasTeam);

		if (session.getAttribute("user") == null && principal != null) {
			User u = entityManager.createQuery("from User where login = :login", User.class)
                .setParameter("login", principal.getName())
                .getSingleResult();
			session.setAttribute("user", u);
		}
		return "home";
	}
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/showFormAddTeam")
	public String adminFormTeam() {
		return "adminFormTeam";
	}
	

	@GetMapping("/showFormDelegateSets")
	public String adminFormDelegateSets() {
		return "adminDelegateSets";r
	}
	
	@GetMapping("/showFormAddLeague")
	public String adminFormLeague() {
		return "adminFormLeague";
	}
	
	@RequestMapping(path = "/addTeam",method = RequestMethod.POST)
	@Transactional
	public String adminCreateTeam(@ModelAttribute("team") Team t) {
		entityManager.persist(t);
		entityManager.flush();
		return "prueba";
	}
	
	@RequestMapping(path = "/addLeague",method = RequestMethod.POST)
	@Transactional
	public String adminCreateLeague(@ModelAttribute("league") League league) {
		entityManager.persist(league);
		entityManager.flush();
		return "prueba";
	}
	
	@RequestMapping(path = "/changeTeamInfo",method = RequestMethod.POST)
	@Transactional
	public String adminTeamInfo(@ModelAttribute("teamInfo") Team team) {
		//hay que guardar el id del usuario en la sesion, etc. pendiente
		//List<User> u = entityManager.createQuery("select u from User u", User.class).getResultList();
		//u.clear();
		entityManager.persist(team);
		entityManager.flush();
		return "prueba";
	}
	
	@RequestMapping(path = "/addRecord",method = RequestMethod.POST)
	@Transactional
	public String delegateCreateRecord(@ModelAttribute("matchrecord") MatchRecord matchRecord) {
		entityManager.persist(matchRecord);
		entityManager.flush();
		return "addRecord test";
	}
	
	@RequestMapping(path = "/t",method = RequestMethod.GET)
	@Transactional
	@ResponseBody
	public String t(Model model) {
		Team t = new Team("Rugby Fisicas","Rugby", "Facultad de Fisicas", 1,"Lunes y Miercoles / 14:00 - 15:30 h","Viernes / 13:30 - 15:30","Paraninfo Norte");		entityManager.persist(t);

		entityManager.flush();
		return "" + t.getId();
	}
	
	@RequestMapping(path = "/eq",method = RequestMethod.GET)
	public String eq(@RequestParam long id,Model model) {
		model.addAttribute("team", entityManager.find(Team.class, id));
		return "home";
	}
    
    //preguntar como hacer esto para que se pueda configurar el html con esta informacion
	@RequestMapping(path = "/home",method = RequestMethod.GET)
	public String home(Model model/*, @PathVariable String sport , @PathVariable String genre*/) {
		Team t = new Team("Rugby Fisicas","Rugby", 
				"Facultad de Fisicas", 1,
				"Lunes y Miercoles / 14:00 - 15:30 h",
				"Viernes / 13:30 - 15:30","Paraninfo Norte");
		model.addAttribute("team", t);
		return "home";
	}
    
    
   @RequestMapping(path = "/ranking",method = RequestMethod.GET)
	public String classification(Model model) {
		//esta en la tabla ligas, pero es necesario ahora para la prueba, se cambia cuando tengamos bd
		/*Team team1 = new Team("Rugby Fisicas","Rugby", "Facultad de Fisicas", 1,"Lunes y Miercoles / 14:00 - 15:30 h","Viernes / 13:30 - 15:30","Paraninfo Norte");
		Team team2 = new Team("Rugby Geologicas","Rugby", "Facultad de Geologia", 2,"Lunes y Jueves / 17:00 - 18:30 h","Viernes / 13:30 - 15:30","Cantarranas");
		Team team3 = new Team("Rugby Filosofia","Rugby", "Facultad de Filosofia", 3,"Miercoles y Jueves / 14:00 - 16:30 h","Lunes / 13:30 - 15:30","Cantarranas");
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
		model.addAttribute("league", l);*/
		return "ranking";
	}

	@RequestMapping(path = "/team/{idTeam}/{idSport}/{idGenre}",method = RequestMethod.GET)
	public String team(Model model, @PathVariable String idTeam, @PathVariable String idSport, @PathVariable String idGenre) {
		
		//create querry to get data from parametres
		Team fisicasTeam = new Team("Rugby Fisicas","Rugby", "Facultad de Fisicas", 1,"Lunes y Miercoles / 14:00 - 15:30 h","Viernes / 13:30 - 15:30","Paraninfo Norte");	
		model.addAttribute("team", fisicasTeam);
		return "team";
	}

	@GetMapping("/playerTab")
	public String playerTab() {
		return "playerTab";
	}

	@GetMapping("/delegatedTeam")
	public String delegatedTeam() {
		return "delegatedTeam";
	}
	
	@GetMapping("/matchRecord")
	public String matchRecord() {
		return "matchRecord";
	}
	
	@GetMapping("/contact")
	public String contact() {
		return "contact";
	}
	
	@GetMapping("/joinTeam")
	public String joinTeam() {
		return "joinTeam";

	}
	
	@GetMapping("/teamHome")
	public String teamHome() {
		return "teamHome";

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
	
	@GetMapping("/allTeams")
	public String allTeams() {
		return "allTeams";
	}
	
	@GetMapping("/rugbyTeams")
	public String rugbyTeams() {
		return "rugbyTeams";
	}
}
