package es.ucm.fdi.iw.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import es.ucm.fdi.iw.LocalData;
import es.ucm.fdi.iw.model.League;
import es.ucm.fdi.iw.model.Match;
import es.ucm.fdi.iw.model.MatchRecord;
import es.ucm.fdi.iw.model.Notification;
import es.ucm.fdi.iw.model.Ranking;
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
		String page = "mainPage";
		boolean isAdmin = false;
		log.info(principal.getName() + " de tipo " + principal.getClass());
		// org.springframework.security.core.userdetails.User
		if (principal != null) {
			User u = entityManager.createQuery("from User where login = :login", User.class)
                .setParameter("login", principal.getName())
                .getSingleResult();
			session.setAttribute("user", u);
			isAdmin =  u.isAdmin();
			model.addAttribute("isAdmin",isAdmin);
			if(!isAdmin) {
				ArrayList<Team> myTeams = new ArrayList<Team>();
				for(int i = 0; i < u.getActiveTeams().size(); i++) {
					myTeams.add(entityManager.createQuery("from Team where id = :teamId", Team.class)
			                .setParameter("teamId", u.getActiveTeams().get(i))
			                .getSingleResult());
				}
				session.setAttribute("myTeams", myTeams);
			}
			else {
				page = "adminHome";
			}
		}
		return page;
	}

	@GetMapping("/login")
	public String login(Model m) {
		m.addAttribute("isLogin", true);
		return "login";
	}
	
	@RequestMapping(value = "/addTeamView",method = RequestMethod.GET)
	public String adminAddTeam(Model model) {
		model.addAttribute("option", "adminAddTeam");
		return "adminHome";
	}

	@GetMapping("/showFormDelegateSets")
	public String adminFormDelegateSets(Model m, @SessionAttribute("user") User u) {
		Team t = entityManager.createQuery("select t from Team t where deputy = :deputyName", Team.class)
				.setParameter("deputyName", u.getName()).getSingleResult();
		m.addAttribute("team",t);
		return "adminDelegateSets";
	}

	@RequestMapping(value = "/addLeagueView",method = RequestMethod.GET)
	public String adminAddLeague(Model model) {
		model.addAttribute("option", "adminAddLeague");
		return "adminHome";
	}

	@RequestMapping(path = "/addTeam",method = RequestMethod.POST)
	@Transactional
	public String adminCreateTeam(@ModelAttribute("team") Team t) {

		League league = entityManager.createQuery("select l from League l where sport = :sportName and category =:category",League.class)
				.setParameter("sportName", t.getSport()).setParameter("category", t.getCategory()).getSingleResult();
		if(league.addTeam(t)) {
			entityManager.persist(t);
			entityManager.persist(league);
			entityManager.flush();
		}
		else {
			
		}
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

	@GetMapping("/home")
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
		List<String> sports = entityManager.createQuery("select distinct ts.sport from Team ts where category = :category",String.class)
				.setParameter("category", category).getResultList();
		List<String> data = new ArrayList<>();
		for (String s : sports) {
			data.add("{" + "\"sport\":" + "\"" + s  + "\"" + "}");
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
	   League league = entityManager.createQuery("select l from League l where sport = :sport",League.class)
				.setParameter("sport", sport).getSingleResult();

	   Ranking ranking = new Ranking(league);
	   model.addAttribute("ranking",ranking.getRanking());
	   model.addAttribute("leagueName", league.getName());

		return "ranking";
	}

	@RequestMapping("/team")
	public String team(@RequestParam("id") long id, Model model, HttpSession session) {
		boolean logged = false;
		User currentUser = (User) session.getAttribute("user");
		if(currentUser != null) {
			logged = true;
		}
		model.addAttribute("team", entityManager.find(Team.class, id));
		model.addAttribute("logged", logged);
		return "team";
	}

	@RequestMapping(value = "/deleteNotification", method = RequestMethod.POST)
	@Transactional
	@ResponseBody
	public boolean deleteNotification(Notification notification) {
		boolean deleted = false;
		try {
			Notification n = entityManager.find(Notification.class, notification.getId());
			entityManager.remove(n);
			entityManager.flush();
			deleted = true;
		}
		catch(Exception e) {

		}
		return deleted;
	}
	
	@RequestMapping(value = "/acceptNewPlayer", method = RequestMethod.POST)
	@Transactional
	@ResponseBody
	public boolean acceptNewPlayer(@RequestBody String body) {
		boolean accepted = false;

		try {
			entityManager.getTransaction().begin();
			RequestTeam rq = entityManager.find(RequestTeam.class, Long.parseLong(body.replace("id=", "")));
			rq.getTeam().getNoActivePlayers().add(rq.getUser()); // añadimos al nuevo jugador al equipo
			entityManager.remove(rq); // borramos la peticion
			entityManager.getTransaction().commit();
			accepted = true;
		}
		catch(Exception e) {

		}
		return accepted;
	}
	
	@RequestMapping(value = "/deleteRequest", method = RequestMethod.POST)
	@Transactional
	@ResponseBody
	public boolean deleteRequest(@RequestBody String body) {
		boolean deleted = false;

		try {
			entityManager.getTransaction().begin();
			RequestTeam rq = entityManager.find(RequestTeam.class, Long.parseLong(body.replace("id=", "")));
			entityManager.remove(rq); // borramos la peticion
			entityManager.getTransaction().commit();
			deleted = true;
		}
		catch(Exception e) {

		}
		return deleted;
	}

	@RequestMapping(value = "/matchRecord", method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	@Transactional
	@ResponseBody
	public String matchRecord(MatchRecord bodyMatch) {
		String result = "Correct";

		try {
			List<MatchRecord> list = entityManager.createQuery("select m from MatchRecord m where matchId = :matchId",MatchRecord.class)
					.setParameter("matchId", bodyMatch.getMatchId()).getResultList();
			if (list.size() == 0) {
				entityManager.persist(bodyMatch);
			}
			else if(list.size() == 1) {
				MatchRecord one = list.get(0);
				if(one.getTeamId() != bodyMatch.getTeamId()) {// si el equipo ya ha enviado un acta
					entityManager.persist(bodyMatch);

					MatchRecord two = bodyMatch;
					if(one.getAwayTeamPoints() == two.getAwayTeamPoints() && one.getHomeTeamPoints() == two.getHomeTeamPoints()) {
						Match match = entityManager.find(Match.class,bodyMatch.getMatchId());
						match.setRecordChecked(true);
						entityManager.flush();
					}
					else {
						result = "El resultado de las actas no coincide, reintroduce el resultado del partido";
						list.clear();
					}
				}
				else
					result = "Ya has enviado el acta para el pardio";
			}
		}
		catch(NoResultException e) {

		}
		return result;
	}

	@RequestMapping("/getLastMatch")
	@ResponseBody
	public String getLastMatch(@RequestParam("teamId") long teamId) {
		String data;
		Match lastAwayMatch = null;
		Match lastHomeMatch = null;
		Team t = entityManager.find(Team.class, teamId);
		List<Match> awayMatches = t.getAwayMatches();
		List<Match> homeMatches = t.getHomeMatches();

		if(awayMatches.size() > 0)
			lastAwayMatch = awayMatches.get(awayMatches.size()-1);
		if(homeMatches.size() > 0)
			lastHomeMatch = homeMatches.get(homeMatches.size()-1);

		if(lastAwayMatch == null && lastHomeMatch == null) {
			data = "";
		}
		else if(lastAwayMatch == null && lastHomeMatch != null ) {
			data = "{" + "\"homeTeamName\":" + "\"" + lastHomeMatch.getHomeTeam().getName()  + "\"" + "," +
					"\"homeTeamPoints\":" + "\"" + lastHomeMatch.getHomeTeamPoints()  + "\""+ "," +
					"\"awayTeamName\":" + "\"" + lastHomeMatch.getAwayTeam().getName()  + "\"" + "," +
					"\"awayTeamPoints\":" + "\"" + lastHomeMatch.getAwayTeamPoints()  + "\"" + "," +
					"\"date\":" + "\"" + lastHomeMatch.getMatchDate()  + "\"" + "," +
					"\"matchId\":" + "\"" + lastHomeMatch.getId()  + "\"" +"}";
		}
		else if (lastAwayMatch != null && lastHomeMatch == null ) {
			data = "{" + "\"homeTeamName\":" + "\"" + lastAwayMatch.getHomeTeam().getName()  + "\"" + "," +
					"\"homeTeamPoints\":" + "\"" + lastAwayMatch.getHomeTeamPoints()  + "\""+  "," +
					"\"awayTeamName\":" + "\"" + lastAwayMatch.getAwayTeam().getName()  + "\"" + "," +
					"\"awayTeamPoints\":" + "\"" + lastAwayMatch.getAwayTeamPoints()  + "\"" + "," +
					"\"date\":" + "\"" + lastAwayMatch.getMatchDate()  + "\"" + "," +
					"\"matchId\":" + "\"" + lastAwayMatch.getId()  + "\"" +"}";
		}
		else {
			if(lastAwayMatch.getMatchDate().compareTo(lastHomeMatch.getMatchDate()) > 0) {
				data = "{" + "\"homeTeamName\":" + "\"" + lastHomeMatch.getHomeTeam().getName()  + "\"" + "," +
						"\"homeTeamPoints\":" + "\"" + lastHomeMatch.getHomeTeamPoints()  + "\""+ "," +
						"\"awayTeamName\":" + "\"" + lastHomeMatch.getAwayTeam().getName()  + "\"" + "," +
						"\"awayTeamPoints\":" + "\"" + lastHomeMatch.getAwayTeamPoints()  + "\"" + ","+
						"\"date\":" + "\"" + lastHomeMatch.getMatchDate()  + "\"" + "," +
						"\"matchId\":" + "\"" + lastHomeMatch.getId()  + "\"" + "}";
			}
			else {
				data = "{" + "\"homeTeamName\":" + "\"" + lastAwayMatch.getHomeTeam().getName()  + "\"" + "," +
						"\"homeTeamPoints\":" + "\"" + lastAwayMatch.getHomeTeamPoints()  + "\""+ "," +
						"\"awayTeamName\":" + "\"" + lastAwayMatch.getAwayTeam().getName()  + "\"" + "," +
						"\"awayTeamPoints\":" + "\"" + lastAwayMatch.getAwayTeamPoints()  + "\"" + "," +
						"\"date\":" + "\"" + lastAwayMatch.getMatchDate()  + "\"" + "," +
						"\"matchId\":" + "\"" + lastAwayMatch.getId()  + "\"" +"}";
			}
		}
		return data;
	}

	@RequestMapping(value ="/playerTab",method = RequestMethod.GET)
	public String playerTab(Model model,@RequestParam("id")long id) {
		Team t = entityManager.find(Team.class, id);
		
		model.addAttribute("team", t);
		model.addAttribute("activo", t.getActivePlayers().size());
		model.addAttribute("noActivo", t.getNoActivePlayers().size());
		return "playerTab";
	}
	
	@RequestMapping(value = "/savePlayerActive",method = RequestMethod.GET)
	@ResponseBody
	public String savePlayerActive(@RequestParam("idTeam") long id) {


		Team team = entityManager.find(Team.class, id);

		List<String> data = new ArrayList<>();
		for (User u : team.getActivePlayers()) {
			String datoUser = u.getId()+","+u.getName();
			data.add("{" + "\"players\":" + "\"" + datoUser  + "\"" + "}");
		}


		return String.join("'", data);
	}
	
	@RequestMapping(value = "/savePlayerNoActive",method = RequestMethod.GET)
	@ResponseBody
	public String savePlayerNoActive(@RequestParam("idTeam") long id) {

		Team team = entityManager.find(Team.class, id);

		List<String> data = new ArrayList<>();
		for (User u : team.getNoActivePlayers()) {
			String datoUser = u.getId()+","+u.getName();
			data.add("{" + "\"players\":" + "\"" + datoUser  + "\"" + "}");
		}

		return String.join("'", data);
	}
	
	@RequestMapping(value = "/savePlayerTab",method = RequestMethod.POST)
	@Transactional
	public String savePlayerTab(HttpServletRequest request){
		
		//obtenemos datos
		long idTeam = Long.parseLong(request.getParameter("idTeam"));
		Team t = entityManager.find(Team.class, idTeam);
		String cadenaActivos = request.getParameter("activePlayer");
		String cadenaNoActivos = request.getParameter("noActivePlayer");
					
		System.out.println("ACTIVOS: "+cadenaActivos);
		System.out.println("NO ACTIVOS: "+cadenaNoActivos);
		
		//quitamos los []
		cadenaActivos = cadenaActivos.substring(1, cadenaActivos.length()-1);
		cadenaNoActivos = cadenaNoActivos.substring(1, cadenaNoActivos.length()-1);
		
		/*
		 * ACTUALIZAMOS LOS DATOS DEL EQUIPO Y DE USER LISTA ACTIVA
		 */	
		String[] datos = cadenaActivos.split(",");
		
		for(int i = 0; i < datos.length; i++) {
			
			char[] idUsu = datos[i].toCharArray();
			
			long id = Character.getNumericValue(idUsu[1]);
			
			User u = entityManager.find(User.class, id);
			
			/*
			 * TEAM
			 */
			List<User> listaUserActive = t.getActivePlayers();
			List<User> listaUserNoActive = t.getNoActivePlayers();
			//el usuario no estaba en la lista de activos
			if(!listaUserActive.contains(u)) {
				listaUserActive.add(u);
				listaUserNoActive.remove(u);
			}
			
			/*
			 * USER
			 */
			List<Team> listaTeamActive = u.getActiveTeams();
			List<Team> listaTeamNoActive = u.getNoActiveTeams();
			
			//si no tiene como team activo lo ponemos
			if(!listaTeamActive.contains(t)){
				listaTeamActive.add(t);
				listaTeamNoActive.remove(t);
			}
			
		}//for
		
		
		/*
		 * ACTUALIZAMOS LOS DATOS DE LA LISTA DE ACTIVOS
		 */
		datos = cadenaNoActivos.split(",");
		
		for(int i = 0; i < datos.length; i++) {
			
			char[] idUsu = datos[i].toCharArray();
			
			long id = Character.getNumericValue(idUsu[1]);
			User u = entityManager.find(User.class, id);
			
			/*
			 * TEAM
			 */
			List<User> listaUserActive = t.getActivePlayers();
			List<User> listaUserNoActive = t.getNoActivePlayers();
			//el usuario no estaba en la lista de activos
			if(listaUserActive.contains(u)) {
				listaUserNoActive.add(u);
				listaUserActive.remove(u);
			}
			
			/*
			 * USER
			 */
			List<Team> listaTeamActive = u.getActiveTeams();
			List<Team> listaTeamNoActive = u.getNoActiveTeams();
			
			//si no tiene como team activo lo ponemos
			if(listaTeamActive.contains(t)){
				listaTeamNoActive.add(t);
				listaTeamActive.remove(t);
			}
		}//for
		
		return "team";
	}

	@GetMapping("/gallery_good")
	public String gallery_good(@RequestParam("id") String id, Model model) {
		model.addAttribute("team",id);
		model.addAttribute("files", localData.getFile(id, "").listFiles().length);
		return "gallery_good";
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
		entityManager.flush();
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

	@GetMapping("/mainPage")
	public String mainPage() {
		return "mainPage";
	}

}
