package es.ucm.fdi.iw.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import es.ucm.fdi.iw.LocalData;
import es.ucm.fdi.iw.model.League;
import es.ucm.fdi.iw.model.MatchRecord;
import es.ucm.fdi.iw.model.Notification;
import es.ucm.fdi.iw.model.RequestTeam;
import es.ucm.fdi.iw.model.Team;
import es.ucm.fdi.iw.model.User;

@Controller
public class RootController {

	private static Logger log = Logger.getLogger(RootController.class);

	@Autowired
	private LocalData localData;
	
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
		if (principal != null) {
			User u = entityManager.createQuery("from User where login = :login", User.class)
                .setParameter("login", principal.getName())
                .getSingleResult();
			session.setAttribute("user", u);
		}
		return "mainPage";
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
	public String adminFormDelegateSets(Model m, @SessionAttribute("user") User u) {
		Team t = entityManager.createQuery("select t from Team t where deputy = :deputyName", Team.class)
				.setParameter("deputyName", u.getName()).getSingleResult();
		m.addAttribute("team",t);
		return "adminDelegateSets";
	}

	@GetMapping("/showFormAddLeague")
	public String adminFormLeague() {
		return "adminFormLeague";
	}

	@RequestMapping(path = "/addTeam",method = RequestMethod.POST)
	@Transactional
	public String adminCreateTeam(@ModelAttribute("team") Team t) {

		League league = entityManager.createQuery("select l from League l where sport = :sportName",League.class)
				.setParameter("sportName", t.getSport()).getSingleResult();
		league.addTeam(t);
		entityManager.persist(t);
		entityManager.persist(league);
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
	public String adminTeamInfo(@ModelAttribute("teamInfo") Team team, @SessionAttribute("user") User u) {

		//Coge el equipo de la bd, donde el usuario logueado es el encargado.
		Team t = entityManager.find(Team.class, team.getId());

		String training = team.getTraining_schedule();
		String nextMatch = team.getNext_match_schedule();
		String facilities = team.getNext_match_facilities();
		if(training != null)
			t.setTraining_schedule(training);
		if(nextMatch != null)
			t.setNext_match_schedule(nextMatch);
		if(facilities != null)
			t.setNext_match_facilities(facilities);
		
		entityManager.persist(t);
		return "prueba";
	}


	@RequestMapping(path = "/addRecord",method = RequestMethod.POST)
	@Transactional
	public String delegateCreateRecord(@ModelAttribute("matchrecord") MatchRecord matchRecord) {
		entityManager.persist(matchRecord);
		entityManager.flush();
		return "addRecord test";
	}
	
	@RequestMapping(path = "/home",method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	@RequestMapping(value = "/showTeamsBySportsAndGender",method = RequestMethod.GET)
	@ResponseBody
	public String showTeamsBySportsAndGender(Model model, @RequestParam("category") String category,  @RequestParam("sport") String sport ) {
		List<Team> teams = entityManager.createQuery("select ts from Team ts where category = :category and sport = :sport",Team.class)
				.setParameter("category", category).setParameter("sport", sport).getResultList();
		List<String> data = new ArrayList<>();
		for (Team t : teams) {
			data.add("{ \"id\":"+ "\"" + t.getId() + "\"" +"," + "\"name\":" + "\"" + t.getName()  + "\"" + "}");
		}
		return String.join("'", data);
	}

	@RequestMapping(value = "/showSportsByGender",method = RequestMethod.GET)
	@ResponseBody
	public String showSportsByGender(Model model, @RequestParam("category") String category ) {
		List<Team> teams = entityManager.createQuery("select ts from Team ts where category = :category",Team.class)
				.setParameter("category", category).getResultList();
		List<String> data = new ArrayList<>();
		for (Team t : teams) {
			data.add("{" + "\"sport\":" + "\"" + t.getSport()  + "\"" + "}");
		}
		return String.join("'", data);
	}
	
	@RequestMapping(value = "/showImages",method = RequestMethod.GET)
	@ResponseBody
	public String showImages(Model model, @RequestParam("team") String team, @RequestParam("files") int files ) {
		List<String> data = new ArrayList<>();
		for(int i=0; i<files; i++) {
			data.add("{" + "\"src\":" + "\"" + "/"  + "\"" + "}");
		}
		return String.join("'", data);
	}
	
	
   @RequestMapping(value = "/ranking",method = RequestMethod.GET)
	public String classification(Model model, @RequestParam("sport") String sport) {
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
	
	@RequestMapping("/team")
	public String team(@RequestParam("id") long id, Model model, HttpSession session) {
		boolean logged = false;
		Team team = entityManager.find(Team.class, id);
		List<User> players = new ArrayList<User>();
		players.add(entityManager.find(User.class, Long.parseLong("5")));
		team.setPlayers(players);
		User currentUser = (User) session.getAttribute("user");
		if(currentUser != null) {
			logged = true;
		}
		model.addAttribute("team", team);
		model.addAttribute("logged", logged);
		return "team";
	}

	@GetMapping("/gallery_good")
	public String gallery_good(@RequestParam("id") String id, Model model) {
		model.addAttribute("team",id);
		model.addAttribute("files", localData.getFile(id, "").listFiles().length);
		return "gallery_good";
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

	@RequestMapping("/contact")
	public String contact(@RequestParam("id") long id, Model m) {
		m.addAttribute("team", entityManager.find(Team.class, id));
		return "contact";
	}
	
	@RequestMapping(value = "/contactDeputy",method = RequestMethod.POST)
	@Transactional
	public String contactDeputy(@ModelAttribute("notification") Notification notification, @RequestParam("deputyId") long deputyId, Model model) {
		// se envia bien siempre
		notification.setDeputy(entityManager.find(User.class, deputyId));
		entityManager.persist(notification);
		model.addAttribute("correct", true);
		return "contact";
	}

	@RequestMapping("/joinTeam")
	public String joinTeam(@RequestParam("id") long id, @SessionAttribute("user") User user , Model m) {
		m.addAttribute("team", entityManager.find(Team.class, id));
		return "joinTeam";
	}
	
	@RequestMapping(path = "/sentRequestTeam",method = RequestMethod.POST)
	@Transactional
	public String sentRequestTeam(@RequestParam("teamId") long teamId,@ModelAttribute("requestTeam") RequestTeam requestTeam, @SessionAttribute("user") User u, Model model){
		RequestTeam rq = null;
		Team t = entityManager.find(Team.class, teamId);
		try {
			rq = entityManager.createQuery("select rq from RequestTeam rq where user_id = :userId",RequestTeam.class)
					.setParameter("userId", u.getId()).getSingleResult();
		}
		catch(NoResultException ex) {
			
		}
		if(rq == null) {
			requestTeam.setUser(u);
			requestTeam.setTeam(t);
			entityManager.persist(requestTeam);
			model.addAttribute("correct", true);
		}
		else
			model.addAttribute("error", true);
		model.addAttribute("team", t);//por si hace dos peticiones seguidas
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

	@GetMapping("/allTeams")
	public String allTeams() {
		return "allTeams";
	}

	@GetMapping("/rugbyTeams")
	public String rugbyTeams() {
		return "rugbyTeams";
	}
	
	@GetMapping("/teamHome")
	public String teamHome() {
		return "teamHome";
	}
	
	@GetMapping("/mainPage")
	public String mainPage() {
		return "mainPage";
	}
	
	
}
