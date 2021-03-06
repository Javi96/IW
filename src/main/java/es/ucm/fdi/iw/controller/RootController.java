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
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.HtmlUtils;

import es.ucm.fdi.iw.LocalData;
import es.ucm.fdi.iw.model.Alert;
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
				//System.out.println(myTeams.size());

				//ver los equipos de los que es delegado el usuario
				List<Team> teamList = entityManager.createQuery("select t from Team t where deputy_id =:id_user", Team.class)
						.setParameter("id_user", u.getId()).getResultList();
				
				List<Notification> li = entityManager.createQuery("select n from Notification n where receiver_id =:receiver_id",
						Notification.class).setParameter("receiver_id",u.getId()).getResultList();
				if(li.size() > 0) {
					model.addAttribute("notificationCount", li.size());
					model.addAttribute("notificationsList", li);
				}	
					
				session.setAttribute("teamsDebuty", teamList);
				session.setAttribute("equipos", teamList.size());

			}
			else {
				List<String> sportList = entityManager.createQuery("select distinct sport from Team", String.class)
						.getResultList();
				model.addAttribute("sportList", sportList);
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
			List<String> sportList = entityManager.createQuery("select distinct sport from Team", String.class)
					.getResultList();
			model.addAttribute("sportList", sportList);
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
		List<String> sportList = entityManager.createQuery("select distinct sport from Team", String.class)
				.getResultList();
		model.addAttribute("sportList", sportList);
		return "adminHome";
	}
	
	@RequestMapping(value = "/alertsView",method = RequestMethod.GET)
	public String adminAlertsView(Model model) {
		model.addAttribute("option", "adminAlert");
		List<Alert> al = entityManager.createQuery("select a from Alert a", Alert.class)
				.getResultList();
		
		model.addAttribute("alerts", al);
		List<String> sportList = entityManager.createQuery("select distinct sport from Team", String.class)
				.getResultList();
		model.addAttribute("sportList", sportList);
		return "adminHome";
	}

	@RequestMapping(value = "/teamListView",method = RequestMethod.GET)
	public String teamListView(Model model) {
		model.addAttribute("option", "adminTeamList");
		List<String> sportList = entityManager.createQuery("select distinct sport from Team", String.class)
				.getResultList();
		model.addAttribute("sportList", sportList);
		return "adminHome";
	}

	@RequestMapping(value = "/teamListBySportAndCategory",method = RequestMethod.GET)
	public String teamListViewBySport(@RequestParam String sport, @RequestParam String category, Model model) {
		List<Team> teamList = entityManager.createQuery("select t from Team t where sport =:sport and category =:category", Team.class)
				.setParameter("sport", sport).setParameter("category", category).getResultList();
		model.addAttribute("teamList", teamList);
		List<String> sportList = entityManager.createQuery("select distinct sport from Team", String.class)
				.getResultList();
		model.addAttribute("sportList", sportList);
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

	@RequestMapping(value = "/addMatchView",method = RequestMethod.GET)
	public String adminAddMatch(Model model) {
		model.addAttribute("option", "adminAddMatch");

		List<Team> tl = entityManager.createQuery("select r from Team r",Team.class).getResultList();
		List<String> sports = new ArrayList<String>();
		for(Team t : tl) {
			if(!sports.contains(t.getSport())) {
				sports.add(t.getSport());
			}
		}
		model.addAttribute("sports", sports);
		return "adminHome";
	}

	@RequestMapping(value = "/getTeamsBySport",method = RequestMethod.GET)
	public String adminGetTeamsBySport(Model model, @RequestParam String sport) {
		model.addAttribute("option", "adminAddMatch");

		List<Team> tl = entityManager.createQuery("select r from Team r",Team.class).getResultList();
		List<String> sports = new ArrayList<String>();
		for(Team t : tl) {
			if(!sports.contains(t.getSport())) {
				sports.add(t.getSport());
			}
		}
		tl = entityManager.createQuery("select r from Team r where sport =:sport",Team.class)
				.setParameter("sport", sport).getResultList();
		
		model.addAttribute("teamsBySport", tl);
		model.addAttribute("matchOf", sport);
		model.addAttribute("sports", sports);
		return "adminHome";
	}
	
	@RequestMapping(path = "/addTeam",method = RequestMethod.POST)
	@Transactional
	public String adminCreateTeam(@ModelAttribute Team team, @RequestParam String email, Model model,
			@RequestParam("photo") MultipartFile photo) {
		
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
				
				Team t = entityManager.find(Team.class, team.getId());
				
				String name = photo.getOriginalFilename();
				t.setTeamPhoto(name);
				
				//foto
				if (!photo.isEmpty()) {
		           
					
					try {
						String id = String.valueOf(team.getId());
						
						File f = new File("src/main/resources/static/img/"+id);
		            	System.out.println("/src/main/resources/static/img/"+id);
		            	
		            	if(!f.exists() || (f.exists() && !f.isDirectory())) {
		            		new File("src/main/resources/static/img/"+id).mkdirs();
		            	}

		                byte[] bytes = photo.getBytes();
		                
		                BufferedOutputStream stream =
		                        new BufferedOutputStream(
		                        		new FileOutputStream(localData.getFile(id,name)));
		                
		                
		                stream.write(bytes);
		                stream.close();
		            
		            } catch (Exception e) {
		                return "You failed to upload " + team + " => " + e.getMessage();
		            }
		        } else {
		            return "You failed to upload a photo for " + team + " because the file was empty.";
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
	
	@RequestMapping(path = "/addMatch",method = RequestMethod.POST)
	@Transactional
	public String adminAddMatch(@ModelAttribute Match match, @RequestParam long homeTeamId, @RequestParam long awayTeamId, Model model) {
	
		Team home = entityManager.find(Team.class, homeTeamId);
		Team away = entityManager.find(Team.class, awayTeamId);
		match.setAwayTeam(away);
		match.setHomeTeam(home);
		entityManager.persist(match);
		
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
			@RequestParam String nextMatchFacilities, @RequestParam String nextMatchSchedule, @RequestParam String description) {

		Team t = entityManager.find(Team.class, teamId);

		if(trainingSchedule != null)
			t.setTrainingSchedule(trainingSchedule);
		if(nextMatchSchedule != null)
			t.setNextMatchSchedule(nextMatchSchedule);
		if(nextMatchFacilities != null)
			t.setDescription(description);

		entityManager.persist(t);

		return "correcto";
	}

	@GetMapping("/home")
	public String home(Model model, HttpSession session) {
		User u = (User) session.getAttribute("user");
		List<Notification> notificationList = entityManager.createQuery("select n from Notification n where receiver_id =:receiver_id",
				Notification.class).setParameter("receiver_id",u.getId()).getResultList();
		
		for (Notification n : notificationList) {
				String ms = HtmlUtils.htmlEscape (n.getMessage());
				n.setMessage(ms);;
			}
		
		if(notificationList.size() > 0) {
			model.addAttribute("notificationCount", notificationList.size());
			model.addAttribute("notificationsList", notificationList);
		}	
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
		
		List<Notification> notificationList = entityManager.createQuery("select n from Notification n where receiver_id =:receiver_id",
				Notification.class).setParameter("receiver_id",currentUser.getId()).getResultList();
		
		for (Notification n : notificationList) {
				String ms = HtmlUtils.htmlEscape (n.getMessage());
				n.setMessage(ms);;
			}
		
		if(notificationList.size() > 0) {
			model.addAttribute("notificationCount", notificationList.size());
			model.addAttribute("notificationsList", notificationList);
		}	
		
		/*
		 //fotos
		if(t != null) {
			String idTeam = String.valueOf(t.getId());
			File f = new File("src/main/resources/static/img/"+idTeam);
			File[] ficheros = f.listFiles();
			
			if(ficheros.length > 1)
				model.addAttribute("foto", ficheros[1].getName());
		}
		 */
		if(t == null)
			return "error404";
		return "team";
	}

	@RequestMapping(value = "/deleteNotification", method = RequestMethod.POST)
	@Transactional
	public String deleteNotification(@RequestParam long id, Model model, HttpSession session) {
	
		try {
			Notification n = entityManager.find(Notification.class, id);
		
			entityManager.remove(n);
			entityManager.flush();
			User u = (User) session.getAttribute("user");
			
			List<Notification> li = entityManager.createQuery("select n from Notification n where receiver_id =:receiver_id",
					Notification.class).setParameter("receiver_id",u.getId()).getResultList();
			if(li.size() > 0) {
				model.addAttribute("notificationCount", li.size());
				model.addAttribute("notificationsList", li);
			}	
		}
		catch(Exception e) {

		}
		return "notification";
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
	public boolean deleteRequest(@RequestParam long id) {
		boolean deleted = false;

		try {
			RequestTeam rq = entityManager.find(RequestTeam.class, id);
			entityManager.remove(rq); // borramos la peticion
			deleted = true;
		}
		catch(Exception e) {

		}
		return deleted;
	}

	
	@RequestMapping(value = "/invalidateRecord", method = RequestMethod.POST)
	@Transactional
	public String invalidateMatchRecord(Model model, @RequestParam long matchId, @RequestParam long alertId) {
		
		try {
			List<MatchRecord> list = entityManager.createQuery("select m from MatchRecord m where matchId = :matchId",MatchRecord.class)
					.setParameter("matchId", matchId).getResultList();
	
			for(MatchRecord mr : list) {
				entityManager.remove(mr);
			}
			entityManager.flush();
			Alert a = entityManager.find(Alert.class, alertId);
			entityManager.remove(a);
			entityManager.flush();
		}
		catch (Exception e) {
			
		}
		List<Alert> al = entityManager.createQuery("select a from Alert a", Alert.class)
				.getResultList();
		
		model.addAttribute("alerts", al);
		model.addAttribute("option", "adminAlert");
		return "adminHome";
	}
	
	@RequestMapping(value = "/invalidatePetition", method = RequestMethod.POST)
	@Transactional
	@ResponseBody
	public boolean invalidatePetition(@RequestParam long matchId) {
		boolean ok = false;
		boolean sended = false;
		try {
			Alert a = entityManager.createQuery("select a from Alert a where match_id =:matchId",Alert.class)
					.setParameter("matchId",matchId).getSingleResult();
			if(a != null)
				sended = true;
		}
		catch(NoResultException ex) {
			sended = false;
		}
		if(!sended) {
			try {
				long team1Id = -1;
				List<MatchRecord> list = entityManager.createQuery("select m from MatchRecord m where matchId = :matchId",MatchRecord.class)
						.setParameter("matchId", matchId).getResultList();
				team1Id = list.get(0).getTeamId();
				
				MatchRecord m1 = list.get(0);
				MatchRecord m2 = list.get(1);
	
				Team t1 = entityManager.find(Team.class, team1Id);
	
				Match m =entityManager.find(Match.class, matchId);
				if(m1.getTeamId() != t1.getId()) {
					MatchRecord aux = m1;
					m1 = m2;
					m2 = aux;
				}
				//No hace falta comprobar si ya estan porque al solicitar 2 veces la invalidacion no encontrara los MatchRecord y saldran del try
				Alert a = new Alert(m ,"El resultado es "+ m1.getHomeTeamPoints() + " - " + m1.getAwayTeamPoints(),
									"El resultado es " + m2.getAwayTeamPoints() + " - " + m2.getAwayTeamPoints());
				
				entityManager.persist(a);
				entityManager.flush();
				
				ok = true;
			}
			catch(Exception e) {
	
			}
		}
		return ok;
	}
	
	@RequestMapping(value = "/matchRecord", method = RequestMethod.POST,consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	@Transactional
	@ResponseBody
	public String matchRecord(MatchRecord bodyMatch, Model model, HttpSession session) {
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
						match.setAwayTeamPoints(one.getAwayTeamPoints());
						match.setHomeTeamPoints(one.getHomeTeamPoints());
						match.setRecordChecked(true);
						entityManager.flush();
						result = "Desactiva";
					}
					else {
						entityManager.persist(two);
						entityManager.flush();
						result = "Acta enviada correctamente, actualiza la pagina para ver el resultado final.";
						list.clear();
					}
				}
				else
					result = "Ya has enviado el acta para el partido";
			}
			
		}
		catch(NoResultException e) {

		}
		return result;
	}

	@RequestMapping("/getMatchRecord")
	@ResponseBody
	public List<String> getMatchRecord(@RequestParam long matchId, @RequestParam long teamId) {
		List<String> info = new ArrayList<String>();
		try {
			List<MatchRecord> aux = new ArrayList<MatchRecord>();
			String data ="";
			List<MatchRecord> mrl = entityManager.createQuery("select r from MatchRecord r ", MatchRecord.class)
					.getResultList();
			for(MatchRecord mr : mrl) {
				if(mr.getMatchId() == matchId)
					aux.add(mr);
			}
			
			Match m = entityManager.find(Match.class,matchId);
			
			
			if(aux.size() > 0) {
				Team t = null;
				if(m.getHomeTeam().getId() == mrl.get(0).getTeamId())
					t = m.getHomeTeam();
				else
					t = m.getAwayTeam();
				data = "{" + "\"teamId\":" + "\"" + aux.get(0).getTeamId()  + "\"" + "," +
						"\"homeTeamPoints\":" + "\"" + aux.get(0).getHomeTeamPoints()  + "\""+  "," +
						"\"teamName\":" + "\"" + t.getName()  + "\""+  "," +
						"\"teamIdForHome\":" + "\"" +  m.getHomeTeam().getId()  + "\""+  "," +
						"\"teamIdForAway\":" + "\"" +  m.getAwayTeam().getId()  + "\""+  "," +
						"\"awayTeamPoints\":" + "\"" + aux.get(0).getAwayTeamPoints()  + "\"" + "," +
						"\"matchId\":" + "\"" + aux.get(0).getId()  + "\"" +
						"}";
				info.add(data);
			}
			if(aux.size() > 1) {
				MatchRecord mr1 = aux.get(0);
				MatchRecord mr2 = aux.get(1);
				boolean checked = false;
				
				if(mr1.getAwayTeamPoints() == mr2.getAwayTeamPoints() && mr1.getHomeTeamPoints() == mr2.getAwayTeamPoints() )
					checked = true;
				
				Team t = null;
				if(m.getHomeTeam().getId() == mrl.get(1).getTeamId())
					t = m.getHomeTeam();
				else
					t = m.getAwayTeam();
				data = "{" + "\"teamId\":" + "\"" + aux.get(1).getTeamId()  + "\"" + "," +
						"\"homeTeamPoints\":" + "\"" + aux.get(1).getHomeTeamPoints()  + "\""+  "," +
						"\"teamName\":" + "\"" + t.getName()  + "\""+  "," +
						"\"checked\":" + "\"" + checked  + "\""+  "," +
						"\"teamIdForHome\":" + "\"" +  m.getHomeTeam().getId()  + "\""+  "," +
						"\"teamIdForAway\":" + "\"" +  m.getAwayTeam().getId()  + "\""+  "," +
						"\"awayTeamPoints\":" + "\"" + aux.get(1).getAwayTeamPoints()  + "\"" + "," +
						"\"matchId\":" + "\"" + aux.get(1).getId()  + "\"" +
						"}";
				info.add(data);
			}
		}
		catch(NoResultException e) {

		}
		return info;
	}

	@RequestMapping("/getMatch")
	@ResponseBody
	public String getMatch(@RequestParam long teamId, @RequestParam long matchId) {
		String data="";
		Match awayMatch = null;
		Match homeMatch = null;

		Team t = entityManager.find(Team.class, teamId);
		List<Match> awayMatches = t.getAwayMatches();
		List<Match> homeMatches = t.getHomeMatches();

		int i = 0;
		int j = 0;
		boolean found = false;
		while(i < awayMatches.size() && !found) {
			if(awayMatches.get(i).getId() == matchId) {
				found = true;
			}
			i++;
		}
		if(!found) {
			while(j < homeMatches.size() && !found) {
				if(homeMatches.get(j).getId() == matchId) {
					found = true;
				}
				j++;
			}
			if(found) {
				homeMatch = homeMatches.get(j-1);
				data = "{" + "\"homeTeamName\":" + "\"" + homeMatch.getHomeTeam().getName()  + "\"" + "," +
						"\"homeTeamPoints\":" + "\"" + homeMatch.getHomeTeamPoints()  + "\""+ "," +
						"\"awayTeamName\":" + "\"" + homeMatch.getAwayTeam().getName()  + "\"" + "," +
						"\"awayTeamPoints\":" + "\"" + homeMatch.getAwayTeamPoints()  + "\"" + "," +
						"\"date\":" + "\"" + homeMatch.getMatchDate()  + "\"" + "," +
						"\"matchId\":" + "\"" + homeMatch.getId()  + "\"" + "," +
						"\"recordChecked\":" + "\"" + homeMatch.isRecordChecked() + "\""  +"}";
			}
		}
		else {
			awayMatch = awayMatches.get(i-1);
			data = "{" + "\"homeTeamName\":" + "\"" + awayMatch.getHomeTeam().getName()  + "\"" + "," +
					"\"homeTeamPoints\":" + "\"" + awayMatch.getHomeTeamPoints()  + "\""+  "," +
					"\"awayTeamName\":" + "\"" + awayMatch.getAwayTeam().getName()  + "\"" + "," +
					"\"awayTeamPoints\":" + "\"" + awayMatch.getAwayTeamPoints()  + "\"" + "," +
					"\"date\":" + "\"" + awayMatch.getMatchDate()  + "\"" + "," +
					"\"matchId\":" + "\"" + awayMatch.getId()  + "\"" + "," +
					"\"recordChecked\":" + "\"" + awayMatch.isRecordChecked() + "\"" +"}";
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
				"\"description\":" + "\"" + t.getDescription() + "\"" + "," +
				"\"category\":" + "\"" + t.getCategory() + "\""
				+ "}";
		return team;
	}

	@RequestMapping(value = "/updateTeam", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	@Transactional
	public String updateTeam(Team team, @RequestParam String email, Model model,RedirectAttributes redir) {
		boolean ok = true;
		Team t = entityManager.find(Team.class, team.getId());
		String name,tSchedule,nMs,nMf,desc;
		System.out.println(team.getDescription());
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
				desc = team.getDescription();
				List<Team> teamN =  entityManager.createQuery("select t from Team t where name =:name",Team.class)
						.setParameter("name", name).getResultList();

				if(name.equals("") || tSchedule.equals("") || nMf.equals("") || nMs.equals("") || teamN.size() != 1 ) {
					ok = false;					
				}
				else {
					t.setName(name);
					t.setTrainingSchedule(tSchedule);
					t.setNextMatchFacilities(nMf);
					t.setNextMatchSchedule(nMs);
					t.setDescription(desc);
					System.out.println("2");
				}
				entityManager.persist(t);
			}
			else {
				ok = false;
				System.out.println("3");
			}
		}
		catch(NoResultException exc) {
			ok = false;
			System.out.println("4");
		}
		catch(Exception e) {
			System.out.println("5");
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

		User u = null;

		/*
		 * ACTUALIZAMOS LOS DATOS DEL EQUIPO Y DE USER LISTA ACTIVA
		 */
		String[] datos = new String[0];
		if(cadenaActivos.length() != 0)
			datos = cadenaActivos.split(",");

		for(int i = 0; i < datos.length; i++) {

			char[] idUsu = datos[i].toCharArray();

			long id = Character.getNumericValue(idUsu[1]);
			u = entityManager.find(User.class, id);
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

		datos = new String[0];
		if(cadenaNoActivos.length() != 0)
			datos = cadenaNoActivos.split(",");

		for(int i = 0; i < datos.length; i++) {

			char[] idUsu = datos[i].toCharArray();

			long id = Character.getNumericValue(idUsu[1]);
			u = entityManager.find(User.class, id);
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

		entityManager.persist(u);
		entityManager.persist(t);

		return "team";
	}

	@RequestMapping("/contact")
	public String contact(@RequestParam("id") long id, Model m) {
		m.addAttribute("team", entityManager.find(Team.class, id));
		return "contact";
	}
	
	@RequestMapping("/getNotifications")
	public String getNotifications(Model m, HttpSession session, HttpServletRequest request) {
		User u = (User) session.getAttribute("user");
		
		List<Notification> li = entityManager.createQuery("select n from Notification n where receiver_id =:receiver_id",
				Notification.class).setParameter("receiver_id",u.getId()).getResultList();
		
		m.addAttribute("notificationsList", li );
		m.addAttribute("notificationCount", li.size());
		
		return "notification";
	}
	
	@RequestMapping(value = "/contactUser",method = RequestMethod.POST)
	@Transactional
	public String contactDeputy(@RequestParam String message, @RequestParam long transmitter_id, 
			@RequestParam long receiver_id, @RequestParam(required=false) Long teamId,Model model, HttpSession session) {
		Notification notification = new Notification();
		User transm = entityManager.find(User.class, transmitter_id);
		User receiver = entityManager.find(User.class, receiver_id);
		
		notification.setTransmitter(transm);
		notification.setReceiver(receiver);
		
		String msg = HtmlUtils.htmlEscape (message);
		notification.setMessage(msg);
		
		model.addAttribute("correct", true);
		
		Calendar c = Calendar.getInstance();
		
		String day = Integer.toString(c.get(Calendar.DATE));
		String month = Integer.toString(c.get(Calendar.MONTH));
		String year = Integer.toString(c.get(Calendar.YEAR));
		
		String hour = Integer.toString(c.get(Calendar.HOUR_OF_DAY));
		String min = Integer.toString(c.get(Calendar.MINUTE));
		String sec = Integer.toString(c.get(Calendar.SECOND));
		
		notification.setDate(day + "-" + month + "-" + year + " || " + hour + ":" + min + ":" + sec);
		
		entityManager.persist(notification);
		if(teamId != null) {
			model.addAttribute("team",entityManager.find(Team.class, teamId));
			return "contact";
		}
		entityManager.flush();

		User u = (User) session.getAttribute("user");
		
		if(!u.getRoles().contains("ADMIN")) {
			List<Notification> li = entityManager.createQuery("select n from Notification n where receiver_id =:receiver_id",
					Notification.class).setParameter("receiver_id",u.getId()).getResultList();
			if(li.size() > 0) {
				model.addAttribute("notificationCount", li.size());
				model.addAttribute("notificationsList", li);
			}	
		}
		else {
			model.addAttribute("option", "adminAlert");
			List<Alert> al = entityManager.createQuery("select a from Alert a", Alert.class)
					.getResultList();
			
			model.addAttribute("alerts", al);
			return "adminHome";
		}
		return "notification";
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



	@GetMapping("/upload")
	public String upload() {
		return "upload";
	}

	@GetMapping("/images")
	public String images() {
		return "images";
	}

	@GetMapping("/mainPage")
	public String mainPage(Model model, HttpSession session) {
		User u = (User) session.getAttribute("user");
		
		List<Notification> li = entityManager.createQuery("select n from Notification n where receiver_id =:receiver_id",
				Notification.class).setParameter("receiver_id",u.getId()).getResultList();
		if(li.size() > 0) {
			model.addAttribute("notificationCount", li.size());
			model.addAttribute("notificationsList", li);
		}	
		
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

                return "redirect:/gallery?team=/"+team;
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
		return "redirect:/gallery?team="+team;
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
