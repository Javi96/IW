package es.ucm.fdi.iw.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import es.ucm.fdi.iw.LocalData;
import es.ucm.fdi.iw.model.Gallery;
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
				List<Team> myTeams = u.getActiveTeams();
				myTeams.addAll(u.getNonActiveTeams());
 				session.setAttribute("myTeams", u.getActiveTeams());
				
				session.setAttribute("l", myTeams.size());
				System.out.println(myTeams.size());
			}
			else {
				page = "adminHome";
			}
		}
		return page;
	}
	
	@GetMapping("/adminHome")
	public String adminHome(Model model,HttpSession session ) {
		User user = (User) session.getAttribute("user");
		boolean isAdmin =  false;
		if(user != null)
			isAdmin = user.isAdmin();
		if(isAdmin) {
			model.addAttribute("isAdmin",isAdmin);
			return "adminHome";
		}
		return "login";
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
	
	@RequestMapping(value = "/teamListView",method = RequestMethod.GET)
	public String teamListView(Model model) {
		model.addAttribute("option", "adminTeamList");
		return "adminHome";
	}
	
	@RequestMapping(value = "/teamListBySportAndCategory",method = RequestMethod.GET)
	public String teamListViewBySport(@RequestParam String sport, @RequestParam String category, Model model) {
		List<Team> teamList = entityManager.createQuery("select t from Team t where sport =:sport and category =:category", Team.class)
				.setParameter("sport", sport).setParameter("category", category).getResultList();
		model.addAttribute("teamList", teamList);

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
	public String adminCreateTeam(@ModelAttribute Team team, @RequestParam String email, Model model) {
		League league = null;
		User deputy = null;
		try {
			if(team.getName().equals("") || team.getCategory().equals("") || team.getSport().equals("") || team.getSchool().equals("")) {
				model.addAttribute("info", "Todos los campos son obligatorios");
			}
			else {
				league = entityManager.createQuery("select l from League l where sport = :sportName and category =:category",League.class)
					.setParameter("sportName", team.getSport()).setParameter("category", team.getCategory()).getSingleResult();
				deputy = entityManager.createQuery("select u from User u where email =:email ", User.class).setParameter("email", email).getSingleResult();
				team.setDeputy(deputy);
				boolean ok = league.addTeam(team);
				if(ok) {
					entityManager.persist(team);
					entityManager.persist(league);
					model.addAttribute("correct", "Equipo creado correctamente");
				}
				else {
					model.addAttribute("info", "Error, el equipo " + team.getName() + " ya pertenece a esta liga");
				}
			}
		}
		catch(Exception e ) {
			if(league == null) {
				model.addAttribute("info", "Error, no hay una liga disponible para este tipo de equipo");
			}
			else if (deputy == null) {
				model.addAttribute("info", "Error, delegado no encontrado");
			}
			else {
				System.out.println(e);
			}
		}
		model.addAttribute("option","adminAddTeam");
		return "adminHome";
	}

	@RequestMapping(path = "/addLeague",method = RequestMethod.POST)
	@Transactional
	public String adminCreateLeague(@ModelAttribute League league, Model model) {
		int l = 0;
		entityManager.clear();
		try {
			if(league.getCategory().equals("") || league.getName().equals("") || league.getSport().equals(""))
				model.addAttribute("info", "Todos los campos son obligatorios");
			else {
				l = entityManager.createQuery("select l from League l where name =:name and sport =:sport", League.class)
						.setParameter("name",league.getName()).setParameter("sport", league.getSport()).getResultList().size();
				if(l == 0) {
					entityManager.persist(league);
					model.addAttribute("correct", "Liga creada correctamente");
				}
				else
					model.addAttribute("info", "Error, ya hay una liga con ese nombre, para " + league.getSport());
			}
		}
		catch(Exception e) {
				System.out.print(e);
		}
		model.addAttribute("option","adminAddLeague");
		return "adminHome";
	}

	@RequestMapping(path = "/changeTeamInfo",method = RequestMethod.POST)
	@ResponseBody
	@Transactional
	public String changeTeamInfo(@SessionAttribute("user") User u, @RequestParam long teamId, @RequestParam String trainingSchedule,
			@RequestParam String nextMatchFacilities, @RequestParam String nextMatchSchedule) {

		Team t = entityManager.find(Team.class, teamId);

		if(trainingSchedule != null)
			t.setTrainingSchedule(trainingSchedule);
		if(nextMatchSchedule != null)
			t.setNextMatchSchedule(nextMatchSchedule);
		if(nextMatchFacilities != null)
			t.setNextMatchFacilities(nextMatchFacilities);

		entityManager.persist(t);

		return "correcto";
	}

	@GetMapping("/home")
	public String home() {
		return "home";
	}

	@RequestMapping(value = "/showTeamsBySportsAndGender",method = RequestMethod.GET)
	@ResponseBody
	public String showTeamsBySportsAndGender(Model model, @RequestParam String category,  @RequestParam String sport ) {
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
	public String showSportsByGender(Model model, @RequestParam String category ) {
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
	public String classification(Model model, @RequestParam String sport) {
	   League league = entityManager.createQuery("select l from League l where sport = :sport",League.class)
				.setParameter("sport", sport).getSingleResult();

	   Ranking ranking = new Ranking(league);
	   model.addAttribute("ranking",ranking.getRanking());
	   model.addAttribute("leagueName", league.getName());

		return "ranking";
	}

	@RequestMapping("/team")
	public String team(@RequestParam long id, Model model, HttpSession session, HttpServletResponse response) {
		
		boolean logged = false;
		User currentUser = (User) session.getAttribute("user");
		if(currentUser != null) {
			logged = true;
		}
		Team t = entityManager.find(Team.class, id);
		model.addAttribute("team", t);
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
	public boolean acceptNewPlayer(@RequestParam long id) {
		boolean accepted = false;

		try {
			//entityManager.getTransaction().begin();
			RequestTeam rq = entityManager.find(RequestTeam.class,id);

			rq.getTeam().getNonActivePlayers().add(rq.getUser()); // añadimos al nuevo jugador al equipo

			entityManager.remove(rq); // borramos la peticion
			//entityManager.getTransaction().commit();
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
		String dataLastAwayMatch = "";
		String dataLastHomeMatch = "";
		Match lastAwayMatch = null;
		Match lastHomeMatch = null;
		Team t = entityManager.find(Team.class, teamId);
		List<Match> awayMatches = t.getAwayMatches();
		List<Match> homeMatches = t.getHomeMatches();

		if(awayMatches.size() > 0) {
			lastAwayMatch = awayMatches.get(awayMatches.size()-1);
			dataLastAwayMatch = "{" + "\"homeTeamName\":" + "\"" + lastAwayMatch.getHomeTeam().getName()  + "\"" + "," +
					"\"homeTeamPoints\":" + "\"" + lastAwayMatch.getHomeTeamPoints()  + "\""+  "," +
					"\"awayTeamName\":" + "\"" + lastAwayMatch.getAwayTeam().getName()  + "\"" + "," +
					"\"awayTeamPoints\":" + "\"" + lastAwayMatch.getAwayTeamPoints()  + "\"" + "," +
					"\"date\":" + "\"" + lastAwayMatch.getMatchDate()  + "\"" + "," +
					"\"matchId\":" + "\"" + lastAwayMatch.getId()  + "\"" +"}";
		}
		if(homeMatches.size() > 0) {
			lastHomeMatch = homeMatches.get(homeMatches.size()-1);
			dataLastHomeMatch = "{" + "\"homeTeamName\":" + "\"" + lastHomeMatch.getHomeTeam().getName()  + "\"" + "," +
					"\"homeTeamPoints\":" + "\"" + lastHomeMatch.getHomeTeamPoints()  + "\""+ "," +
					"\"awayTeamName\":" + "\"" + lastHomeMatch.getAwayTeam().getName()  + "\"" + "," +
					"\"awayTeamPoints\":" + "\"" + lastHomeMatch.getAwayTeamPoints()  + "\"" + "," +
					"\"date\":" + "\"" + lastHomeMatch.getMatchDate()  + "\"" + "," +
					"\"matchId\":" + "\"" + lastHomeMatch.getId()  + "\"" +"}";
		}

		if(lastAwayMatch == null && lastHomeMatch == null) {
			data = "";
		}
		else if(lastAwayMatch == null && lastHomeMatch != null ) {
			data = dataLastHomeMatch;
		}
		else if (lastAwayMatch != null && lastHomeMatch == null ) {
			data = dataLastAwayMatch;
		}
		else {
			if(lastAwayMatch.getMatchDate().compareTo(lastHomeMatch.getMatchDate()) > 0) {
				data = dataLastHomeMatch;
			}
			else {
				data = dataLastAwayMatch;
			}
		}
		return data;
	}

	@RequestMapping(value ="/playerTab",method = RequestMethod.GET)
	public String playerTab(Model model,@RequestParam("id")long id) {
		Team t = entityManager.find(Team.class, id);
		
		model.addAttribute("team", t);
		model.addAttribute("activo", t.getActivePlayers().size());
		model.addAttribute("noActivo", t.getNonActivePlayers().size());
		return "playerTab";
	}
	
	@RequestMapping(value ="/getTeam",method = RequestMethod.GET)
	@ResponseBody
	public String getTeam(Model model,@RequestParam long id) {
		Team t = entityManager.find(Team.class, id);
		String team = "{" + "\"name\":" + "\"" + t.getName()  + "\"" + "," +
				"\"sport\":" + "\"" + t.getSport()  + "\"" + "," +
				"\"school\":" + "\"" + t.getSchool()  + "\"" + "," +
				"\"deputyEmail\":" + "\"" + t.getDeputy().getEmail()  + "\"" + "," +
				"\"nextMatchSchedule\":" + "\"" + t.getNextMatchSchedule() + "\"" + "," +
				"\"nextMatchFacilities\":" + "\"" + t.getNextMatchFacilities() + "\"" + "," +
				"\"trainingSchedule\":" + "\"" + t.getTrainingSchedule() + "\"" + "," +
				"\"category\":" + "\"" + t.getCategory() + "\""
				+ "}";
		return team;
	}
	
	@RequestMapping(value = "/updateTeam", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	@Transactional
	public String updateTeam(Team team, @RequestParam String email, Model model,RedirectAttributes redir) {
		boolean ok = true;
		Team t = entityManager.find(Team.class, team.getId());
		String name,tSchedule,nMs,nMf;
		
		try {
			User deputy =  entityManager.createQuery("select u from User u where email =:email",User.class)
					.setParameter("email", email).getSingleResult();
			List<Team> te = entityManager.createQuery("select t from Team t where deputy_id =:deputyId",Team.class)
					.setParameter("deputyId", deputy.getId()).getResultList();
			
			if(te.size() == 1 && email.equals(t.getDeputy().getEmail())) {
				t.setDeputy(deputy);
				name = team.getName();
				tSchedule = team.getTrainingSchedule();
				nMf = team.getNextMatchFacilities();
				nMs = team.getNextMatchSchedule();
				
				List<Team> teamN =  entityManager.createQuery("select t from Team t where name =:name",Team.class)
						.setParameter("name", name).getResultList();
				
				if(name.equals("") || tSchedule.equals("") || nMf.equals("") || nMs.equals("") || teamN.size() > 1 || (teamN.size() == 1 && !teamN.get(0).equals(name)) ) {
					ok = false;
				}
				else {
					t.setName(name);
					t.setTrainingSchedule(tSchedule);
					t.setNextMatchFacilities(nMf);
					t.setNextMatchSchedule(nMs);
				}
				entityManager.persist(t);
			}
			else
				ok = false;
		}
		catch(NoResultException exc) {
			ok = false;
		}
		catch(Exception e) {
			ok = false;
		}
		if(ok)
			redir.addFlashAttribute("correct", ok);
		else
			redir.addFlashAttribute("incorrect", ok);
		redir.addFlashAttribute("teamId", t.getId());
		return "redirect:/teamListBySportAndCategory?sport=" + t.getSport() + "&category=" + t.getCategory();
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
		for (User u : team.getNonActivePlayers()) {
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
			List<User> listaUserNoActive = t.getNonActivePlayers();
			//el usuario no estaba en la lista de activos
			if(!listaUserActive.contains(u)) {
				listaUserActive.add(u);
				listaUserNoActive.remove(u);
			}
			
			/*
			 * USER
			 */
			List<Team> listaTeamActive = u.getActiveTeams();
			List<Team> listaTeamNoActive = u.getNonActiveTeams();
			
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
			List<User> listaUserNoActive = t.getNonActivePlayers();
			//el usuario no estaba en la lista de activos
			if(listaUserActive.contains(u)) {
				listaUserNoActive.add(u);
				listaUserActive.remove(u);
			}
			
			/*
			 * USER
			 */
			List<Team> listaTeamActive = u.getActiveTeams();
			List<Team> listaTeamNoActive = u.getNonActiveTeams();
			
			//si no tiene como team activo lo ponemos
			if(listaTeamActive.contains(t)){
				listaTeamNoActive.add(t);
				listaTeamActive.remove(t);
			}
		}//for
		
		return "team";
	}

	@RequestMapping("/contact")
	public String contact(@RequestParam("id") long id, Model m) {
		m.addAttribute("team", entityManager.find(Team.class, id));
		return "contact";
	}

	@RequestMapping(value = "/contactDeputy",method = RequestMethod.POST)
	@Transactional
	public String contactDeputy(@ModelAttribute Notification notification, @RequestParam long deputyId, Model model) {
		// se envia bien siempre
		notification.setDeputy(entityManager.find(User.class, deputyId));
		entityManager.persist(notification);
		model.addAttribute("correct", true);
		Team t = entityManager.createQuery("select t from Team t where deputy_id =:deputyId", Team.class).setParameter("deputyId", deputyId).getSingleResult();
		model.addAttribute("team",t);
		entityManager.flush();
		return "contact";
	}

	@RequestMapping("/joinTeam")
	public String joinTeam(@RequestParam long id, @SessionAttribute User user , Model m) {
		m.addAttribute("team", entityManager.find(Team.class, id));
		return "joinTeam";
	}

	@RequestMapping(path = "/sentRequestTeam",method = RequestMethod.POST)
	@Transactional
	public String sentRequestTeam(@RequestParam long teamId,@ModelAttribute RequestTeam requestTeam, @SessionAttribute("user") User u, Model model,
			@RequestParam String name, @RequestParam String idCard){
		if(!idCard.equals(u.getIdCard())) {
			model.addAttribute("error", "Tu dni no coincide con el de ningún usuario de la UCM");
		}
		else if (!name.equals(u.getName())) {
			model.addAttribute("error", "Tu nombre no coincide con el de ningún usuario de la UCM");
		}
		else {
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
				model.addAttribute("error", "Error, ya has enviado una solicitud a este equipo");
			model.addAttribute("team", t);//por si hace dos peticiones seguidas
		}
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

	@GetMapping("/images")
	public String images() {
		return "images";
	}

	@GetMapping("/mainPage")
	public String mainPage() {
		return "mainPage";
	}
	
	@GetMapping("/gallery_images")
	public String gallery_images(@RequestParam("team") String team,@RequestParam("gallery") String gallery, Model model) {
		model.addAttribute("team",team);
		model.addAttribute("gallery",gallery);
		System.out.println(team + " " + gallery + " " + localData.getFile(team+"/"+gallery, "").listFiles().length);
		System.out.println(localData.getFile(team, "").listFiles().length);
		System.out.println(localData.getFile(team, "").getAbsolutePath());
		//model.addAttribute("files", localData.getFile("team", id).listFiles().length);		
		ArrayList<String> images = new ArrayList<>();
		//ArrayList<String> galleries = new ArrayList<>();
		
		for (File file : localData.getFile(team+"/"+gallery, "").listFiles()) {
			//galleries.add(folder.getName());
			//for (File file : folder.listFiles()) {
				System.out.println("photo/" + team + "/" + gallery + "/" + file.getName());
				images.add("photo/" + team + "/" + gallery + "/" + file.getName());
			//}
		}
		
		/*for (File f : localData.getFile(id, "").listFiles()) {
			images.add("photo/team/" + id + "/" + f.getName());
		}*/
	    model.addAttribute("images", images);
	    //model.addAttribute("galleries", galleries);
		return "gallery_images";
	}

	@RequestMapping(value="/photo/{team}/{gallery}/{name}", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
	public void userPhoto(@PathVariable("team") String team,@PathVariable("gallery") String gallery,
			@PathVariable("name") String name,
			HttpServletResponse response,Model model) {
		model.addAttribute("team",team);
		model.addAttribute("gallery",gallery);

		File f = localData.getFile(team+"/"+gallery, name);
		InputStream in = null;
	    try {
		    if (f.exists()) {
		    	in = new BufferedInputStream(new FileInputStream(f));
		    } else {
		    	in = new BufferedInputStream(
		    			this.getClass().getClassLoader().getResourceAsStream("unknown-user.jpg"));
		    }
	    	FileCopyUtils.copy(in, response.getOutputStream());
	    } catch (IOException ioe) {
	    	log.info("Error retrieving file: " + f + " -- " + ioe.getMessage());
	    }
	}

/*	
	@RequestMapping(value="/teamPhoto", method=RequestMethod.POST)
	@ResponseBody
    public String teamPhoto(@RequestParam MultipartFile photo, @RequestParam long id, Model model){
		String ok = "";
		Team team = entityManager.find(Team.class, id);
		String name = photo.getName();
		team.setTeamPhoto(name);
		if (!photo.isEmpty()) {
            try {
            	
            	
            	File f = new File("src/main/resources/static/img/shields"+photo.getOriginalFilename());
            	
            	if(!f.exists() || (f.exists() && !f.isDirectory())) {
            		new File("src/main/resources/static/img/shields").mkdirs();
            	}
            	
            	int files = new File("/tmp/iw/"+team).listFiles().length;
                byte[] bytes = photo.getBytes();
                BufferedOutputStream stream =
                        new BufferedOutputStream(
                        		new FileOutputStream(localData.getFile(team.toString(), Integer.toString(files+1))));
                stream.write(bytes);
                stream.close();
            
            } catch (Exception e) {
                ok = "You failed to upload " + team + " => " + e.getMessage();
            }
        } 
		else {
            ok = "You failed to upload a photo for " + team + " because the file was empty.";
        }
		model.addAttribute("team", team);
		return ok;
	}
	*/
	
	@RequestMapping(value="/photo/{team}/{gallery}", method=RequestMethod.POST)
    public @ResponseBody String handleFileUpload(@RequestParam("photo") MultipartFile photo,
    		@PathVariable("team") String team,@PathVariable("gallery") String gallery){
        if (!photo.isEmpty()) {
            try {
            	File f = new File("/tmp/iw/"+team+"/"+gallery);
            	System.out.println("/tmp/iw/"+team+"/"+gallery);
            	if(!f.exists() || (f.exists() && !f.isDirectory())) {
            		new File("/tmp/iw/"+team+"/"+gallery).mkdirs();
            	}
            	
            	int files = new File("/tmp/iw/"+team+"/"+gallery).listFiles().length;
                byte[] bytes = photo.getBytes();
                BufferedOutputStream stream =
                        new BufferedOutputStream(
                        		new FileOutputStream(localData.getFile(team+"/"+gallery, Integer.toString(files+1))));
                stream.write(bytes);
                stream.close();

                return "ok";
            } catch (Exception e) {
                return "You failed to upload " + team + " => " + e.getMessage();
            }
        } else {
            return "You failed to upload a photo for " + team + " because the file was empty.";
        }
	}
	
	
	@GetMapping("/gallery")
	public String gallery(@RequestParam("team") String team, Model model) {
		model.addAttribute("team",team);
		ArrayList<Gallery> gallery = new ArrayList<>();		
		for (File folder : localData.getFile(team, "").listFiles()) {
			gallery.add(new Gallery(folder.getName(), localData.getFile(team + "/" + folder.getName(), "").listFiles().length));
		}
	    model.addAttribute("gallery", gallery);
		return "gallery";
	}
	
	@RequestMapping(value="/fillGallery",method = RequestMethod.GET)
	@ResponseBody
	public String fillGallery(@RequestParam("team") String team, Model model) {
	    List<String> data = new ArrayList<>();
		for (File folder : localData.getFile(team, "").listFiles()) {
			data.add("{" + "\"gallery\":{" + 
					"\"name\":" + "\"" + folder.getName() + "\"" +
					",\"files\":" + "\"" + localData.getFile(team + "/" + folder.getName(), "").listFiles().length + 
			 "\"}" + "}");
		}
		return String.join("'", data);
	}
	
	@RequestMapping(path = "/createGallery/{team}", method = RequestMethod.POST)
	public String createGallery(@PathVariable("team") String team, HttpServletRequest request, Model model) {
		try{
			new File("/tmp/iw/"+team+"/"+request.getParameter("data")).mkdirs();
			
		}catch(Exception e) {
			
		}
		return "redirect:/gallery?team=/"+team;
	}
	
	@RequestMapping(value = "/removeGallery/{team}", method = RequestMethod.POST)
	public String removeGallery(@PathVariable String team, HttpServletRequest request) {
		try {
			FileUtils.deleteDirectory(localData.getFile(team +"/"+request.getParameter("selectionbox"), ""));
		}catch(Exception e) {
			
		}
		return "redirect:/gallery?team=/"+team;

	}
	
	@GetMapping("/diary")
	public String diary(Model model, @SessionAttribute("user") User u) {

		
		List<Team> teamMatch = u.getActiveTeams();
		teamMatch.addAll(u.getNonActiveTeams());
		model.addAttribute("teams", teamMatch);

		return "diary";
	}

}
