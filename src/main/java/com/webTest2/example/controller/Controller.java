package com.webTest2.example.controller;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.webTest2.example.domain.Board;
import com.webTest2.example.domain.Pagination;
import com.webTest2.example.domain.Player;
import com.webTest2.example.domain.Reply;
import com.webTest2.example.domain.Search;
import com.webTest2.example.domain.Skin;
import com.webTest2.example.domain.User;
import com.webTest2.example.service.BoardService;
import com.webTest2.example.service.PlayerService;
import com.webTest2.example.service.ReplyService;
import com.webTest2.example.service.SkinService;
import com.webTest2.example.service.UserService;

@org.springframework.stereotype.Controller
public class Controller {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired BoardService boardservice;
	@Autowired UserService userservice;
	@Autowired ReplyService replyservice;
	@Autowired PlayerService playerservice;
	@Autowired SkinService skinservice;
	
	@RequestMapping("/")
	public String home(Model model) {
		logger.debug("debug");
		logger.info("info");
		logger.error("error");
		return "/index";
	}
	
	@RequestMapping("/beforeSignup")
	public String beforeSignUp() {
		return "/signup";
	}
	
	@RequestMapping("/signup")
	public String signup(User user) {
		String encodedPassword = new BCryptPasswordEncoder().encode(user.getPassword());
		
		user.setPassword(encodedPassword);
		user.setAccountNonExpired(true);
		user.setEnabled(true);
		user.setAccountNonLocked(true);
		user.setCredentialsNonExpired(true);
		user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER,ROLE_TEST"));
		
		userservice.createUser(user);
		userservice.createAuthorities(user);
		return "/login";
	}
	
	@RequestMapping(value="/login")
	public String beforeLogin(Model model) {
		return "/login";
	}
	
	@Secured({"ROLE_ADMIN"})
	@RequestMapping(value="/admin")
	public String admin(Model model) {
		return "/admin";
	}
	
	@Secured({"ROLE_USER"})
	@RequestMapping(value="/user/info")
	public String userInfo(Model model) {
		return "/user_info";
	}

	@RequestMapping(value="/denied")
	public String denied(Model model) {
		return "/denied";
	}
	
	@RequestMapping("/board_list")
	public String boardList(Model model, @RequestParam(value="page", required=false, defaultValue="1") String page, Search search) {
		System.out.println(search.toString());
		search.setPage((Integer.parseInt(page)-1)*10);
		if(search.getContent() == null)
			search.setContent("");
				
		List<Board> list = boardservice.selectBoardList(search);
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(Integer.parseInt(page), boardservice.getBoardCount(search));
		model.addAttribute("pagination", pg);
		
		model.addAttribute("search", search);
		return "/board_list";		 
	}
	
	@Secured({"ROLE_USER"})
	@RequestMapping("/board_write")
	public String boardWrite(Model model) {
		return "/board_write";
	}
	
	@RequestMapping("/board_write_result")
	public String boardWriteResult(Model model, Board board) {
		board.setbOrder(0);
		board.setbGroup(0);
		boardservice.writeBoard(board);
		boardservice.updateBase();
		
		return "redirect:/board_detail?bId=" + boardservice.lastBoard();
	}
	
	@RequestMapping("/board_detail")
	public String boardDetail(Model model, @RequestParam("bId") int id) {
		Board board = boardservice.findBoard(id);
		model.addAttribute("board", board);
		
		Search search = new Search();
		search.setPage(0);
		search.setbId(id);
		
		List<Reply> list = replyservice.getReply(search);
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(1, replyservice.getReplyCount(search));
		model.addAttribute("pagination", pg);
		return "/board_detail";
	}
	
	@RequestMapping("/board_add")
	public String boardAdd(Model model, @RequestParam("bId") int id) {
		Board board = boardservice.findBoard(id);
		model.addAttribute("board", board);
		return "/board_add";
	}
	
	@RequestMapping("/board_add_result")
	public String boardAddResult(Model model, Board board, @RequestParam("bId") int id) {
		Board board2 = boardservice.findBoard(id);
		if(board2.getbOrder() == 0) {
			board.setbOrder(boardservice.getMaxOrder(board2.getbBase())+1);
		} else {
			board.setbOrder(board2.getbOrder());	
		}
		board.setbBase(board2.getbBase());
		board.setbGroup(board2.getbGroup()+1);
		
		boardservice.addBoard(board);
		
		return "redirect:/board_detail?bId=" + boardservice.lastBoard();
	}
	
	@RequestMapping("/board_delete")
	public String boardDelete(Model model, @RequestParam("bId") int id, @AuthenticationPrincipal User user) {
		Board board = boardservice.findBoard(id);
		String uId = user.getUsername();
		SimpleGrantedAuthority admin = new SimpleGrantedAuthority("ROLE_ADMIN");
		
		// admin 권한?
		System.out.println(admin.getAuthority());		
		System.out.println(user.getAuthorities());
				
		for(GrantedAuthority object : user.getAuthorities()) {
		    System.out.println(object.getAuthority());
		    System.out.println(object);
		}
		
		if(!uId.equals(board.getuId()))
			return "/denied";

		replyservice.deleteAllReply(id);
		boardservice.deleteBoard(id);
		
		return "redirect:/board_list?page=1";
	}
	
	@RequestMapping("/board_edit")
	public String boardEdit(Model model, @RequestParam("bId") int id, @AuthenticationPrincipal User user) {
		Board board = boardservice.findBoard(id);
		String uId = user.getUsername();
		
		if(!uId.equals(board.getuId()))
			return "/denied";
		
		model.addAttribute("board", board);
		
		return "/board_edit";
	}
	
	@RequestMapping("/board_edit_result")
	public String boardEditResult(Model model, Board board) {
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		board.setbDateTime(format.format(today));
		
		boardservice.editBoard(board);
				
		return "redirect:/board_detail?bId=" + board.getbId();
	}
	
	@RequestMapping("reply_list")
	public String replyList(Model model, HttpServletRequest request) {
		Search search = new Search();
		int page = Integer.parseInt(request.getParameter("page"));
		int bId = 0;
		if(request.getParameter("bId") != null)
			bId = Integer.parseInt(request.getParameter("bId"));
		int p_num = 0;
		if(request.getParameter("p_num") != null)
			p_num = Integer.parseInt(request.getParameter("p_num"));
		int s_num = 0;
		if(request.getParameter("s_num") != null)
			s_num = Integer.parseInt(request.getParameter("s_num"));
		search.setPage((page-1)*10);
		search.setbId(bId);
		search.setP_num(p_num);
		search.setS_num(s_num);
				
		List<Reply> list = replyservice.getReply(search);		
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(page, replyservice.getReplyCount(search));
		model.addAttribute("pagination", pg);
		
		return "/reply_list";
	}
	
	@RequestMapping("/write_reply")
	public String writeReply(Model model, Reply reply) {
		replyservice.writeReply(reply);
		
		Search search = new Search();
		search.setPage(0);
		search.setP_num(reply.getP_num());
		search.setbId(reply.getbId());
		search.setS_num(reply.getS_num());
		
		List<Reply> list = replyservice.getReply(search);
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(1, replyservice.getReplyCount(search));
		model.addAttribute("pagination", pg);
				
		return "/reply_list";
	}
	
	@RequestMapping("/delete_reply")
	public String DeleteReply(Model model, Reply reply, @AuthenticationPrincipal User user) {
		reply = replyservice.findReply(reply.getrId());
		
		if(!user.getUsername().equals(reply.getuId()))
			return "/reply_denied";
		
		replyservice.deleteReply(reply.getrId());
		
		Search search = new Search();
		search.setPage(0);
		search.setP_num(reply.getP_num());
		search.setbId(reply.getbId());
		search.setS_num(reply.getS_num());
		
		List<Reply> list = replyservice.getReply(search);
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(1, replyservice.getReplyCount(search));
		model.addAttribute("pagination", pg);
		
		return "/reply_list";
	}
	
	@RequestMapping(value="/edit_reply", method=RequestMethod.POST)
	public String boardReplyEdit(Model model, HttpServletRequest request, @AuthenticationPrincipal User user) {
		int rId = Integer.parseInt(request.getParameter("r_id"));
		
		Reply reply = replyservice.findReply(rId);
		String uId = user.getUsername();

		if(!uId.equals(reply.getuId()))
			return "/reply_denied";
		
		model.addAttribute("reply", reply);
		
		return "/reply_edit";
	}
	
	@RequestMapping(value="/edit_reply_result", method=RequestMethod.POST)
	public String boardReplyEditResult(Model model, HttpServletRequest request) {
		int rId = Integer.parseInt(request.getParameter("r_id"));
		String content = request.getParameter("edit_content");
		
		Reply reply = replyservice.findReply(rId);
		
		reply.setrContent(content);
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		reply.setrDateTime(format.format(today));
		
		replyservice.editReply(reply);
		
		Search search = new Search();
		search.setPage(0);
		search.setP_num(reply.getP_num());
		search.setbId(reply.getbId());
		search.setS_num(reply.getS_num());
		
		List<Reply> list = replyservice.getReply(search);
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(1, replyservice.getReplyCount(search));
		model.addAttribute("pagination", pg);
		
		return "/reply_list";
	}
	
	@RequestMapping("/user_list")
	public String userList(Model model, @RequestParam(value="page", required=false, defaultValue="1") String page) {				
		List<User> list = userservice.selectUserList(Integer.parseInt(page));
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(Integer.parseInt(page), userservice.getUserCount());
		model.addAttribute("pagination", pg);
		return "/user_list";
	}
	
	@RequestMapping("/user_detail")
	public String userDetail(Model model, @RequestParam("username") String username) {
		User user = userservice.findUser(username);
		
		model.addAttribute("user", user);
		return "/user_detail";
	}
	
	@RequestMapping("/user_edit")
	public String userEdit(Model model, @RequestParam("username") String username) {
		User user = userservice.findUser(username);
		
		model.addAttribute("user", user);
		return "/user_edit";
	}
	
	@RequestMapping("/user_edit_result")
	public String userEditResult(Model model, User user) {
		if(user.getANE().equals("true"))
			user.setAccountNonExpired(true);
		if(user.getANL().equals("true"))
			user.setAccountNonLocked(true);
		if(user.getCNE().equals("true"))
			user.setCredentialsNonExpired(true);
		if(user.getE().equals("true"))
			user.setEnabled(true);
				
		userservice.editUser(user);
		
		return "/user_edit_result";
	}
	
	@RequestMapping("/user_del")
	public String userDel(Model model, @RequestParam("username") String username) {
		userservice.delUser(username);
		
		return "redirect:/user_list";
	}
	
	@RequestMapping("/player_list")
	public String playerList(Model model, @RequestParam(value="page", required=false, defaultValue="1") String page, Search search) {
		if(search.getContent() == null)
			search.setContent("");
		
		search.setCheckAttributes(true);
		search.setCheckPositions(true);
		search.setCheckTiers(true);
		if(search.getAttributes() == null) {
			search.setCheckAttributes(false);
		}
		if(search.getPositions() == null) { 
			search.setCheckPositions(false);
		}
		if(search.getTiers() == null) {
			search.setCheckTiers(false);
		}
		System.out.println(search.toString());
		
		search.setPage((Integer.parseInt(page)-1)*10);
		List<Player> list = playerservice.searchPlayer(search);
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(Integer.parseInt(page), playerservice.getPlayerCount(search));
		model.addAttribute("pagination", pg);
						
		model.addAttribute("search", search);
		return "/player_list";
	}
	
	@RequestMapping(value="/player_detail", params = {"p_num"})
	public String playerDetail(Model model, @RequestParam("p_num") int p_num) {
		Player player = playerservice.findPlayer(p_num);
		model.addAttribute("player", player);
		
		List<Skin> slist = skinservice.getSkinList(player.getP_name());
		model.addAttribute("slist", slist);
		
		Search search = new Search();
		search.setPage(0);
		search.setP_num(p_num);
				
		List<Reply> list = replyservice.getReply(search);		
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(1, replyservice.getReplyCount(search));
		model.addAttribute("pagination", pg);
		return "/player_detail";
	}
	
	@RequestMapping(value="/player_detail", params= {"p_name"})
	public String playerDetail(Model model, @RequestParam("p_name") String p_name) {
		Player player = playerservice.findPlayer(p_name);
		model.addAttribute("player", player);
		
		List<Skin> slist = skinservice.getSkinList(player.getP_name());
		model.addAttribute("slist", slist);
		
		Search search = new Search();
		search.setPage(0);
		search.setP_num(player.getP_num());
				
		List<Reply> list = replyservice.getReply(search);		
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(1, replyservice.getReplyCount(search));
		model.addAttribute("pagination", pg);
		return "/player_detail";
	}
	
	@Secured({"ROLE_ADMIN"})
	@RequestMapping("/player_write")
	public String playerWrite(Model model) {
		return "/player_write";
	}
	
	@RequestMapping("/player_write_result")
	public String playerWriteResult(Player player, HttpServletRequest request) {
		System.out.println(player.toString());
		
		if(!player.getP_image().getOriginalFilename().equals("")) {
			String path = request.getSession().getServletContext().getRealPath("/") + "resources\\img\\";
			
			MultipartFile file = player.getP_image();
			String uuidName = UUID.randomUUID().toString() + file.getOriginalFilename();
			String oPath = path + uuidName; // 원본 경로
						
			try {
				file.transferTo(new File(oPath));
			} catch(IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			File oFile = new File(oPath);

			int index = oPath.lastIndexOf(".");
			String ext = oPath.substring(index + 1); // 파일 확장자

			String tPath = oFile.getParent() + File.separator + "t-" + oFile.getName(); // 썸네일저장 경로
			File tFile = new File(tPath);
			
			double ratio = 2; // 이미지 축소 비율

			try {
				BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
				int tWidth = (int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
				int tHeight = (int) (oImage.getHeight() / ratio); // 생성할 썸네일이미지의 높이
				
				BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
				Graphics2D graphic = tImage.createGraphics();
				Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
				graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
				graphic.dispose(); // 리소스를 모두 해제

				ImageIO.write(tImage, ext, tFile);
			} catch (IOException e) {
				e.printStackTrace();
			}		
			
			player.setP_full("resources\\img\\" + uuidName);
			player.setP_thumb("resources\\img\\t-" + uuidName);
		}		
		
		playerservice.writePlayer(player);
		
		return "redirect:/player_list";
	}
	
	@RequestMapping("/player_edit")
	public String PlayerEdit(Model model, @RequestParam("p_num") int p_num) {
		Player player = playerservice.findPlayer(p_num);
		
		model.addAttribute(player);
		return "/player_edit";
	}
	
	@RequestMapping("/player_edit_result")
	public String PlayerEditResult(Player player, HttpServletRequest request) {
		System.out.println(player.toString());
		
		Player temp = playerservice.findPlayer(player.getP_num());
		player.setP_full(temp.getP_full());
		player.setP_thumb(temp.getP_thumb());
		
		if(player.getP_image() != null) {
			if(!player.getP_image().getOriginalFilename().equals("")) {
				String path = request.getSession().getServletContext().getRealPath("/") + "resources\\img\\";
				
				MultipartFile file = player.getP_image();
				String uuidName = UUID.randomUUID().toString() + file.getOriginalFilename();
				String oPath = path + uuidName; // 원본 경로
							
				try {
					file.transferTo(new File(oPath));
				} catch(IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				File oFile = new File(oPath);
	
				int index = oPath.lastIndexOf(".");
				String ext = oPath.substring(index + 1); // 파일 확장자
	
				String tPath = oFile.getParent() + File.separator + "t-" + oFile.getName(); // 썸네일저장 경로
				File tFile = new File(tPath);
				
				double ratio = 2; // 이미지 축소 비율
	
				try {
					BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
					int tWidth = (int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
					int tHeight = (int) (oImage.getHeight() / ratio); // 생성할 썸네일이미지의 높이
					
					BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
					Graphics2D graphic = tImage.createGraphics();
					Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
					graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
					graphic.dispose(); // 리소스를 모두 해제
	
					ImageIO.write(tImage, ext, tFile);
				} catch (IOException e) {
					e.printStackTrace();
				}		
				
				player.setP_full("resources\\img\\" + uuidName);
				player.setP_thumb("resources\\img\\t-" + uuidName);
			}
		}
		
		playerservice.editPlayer(player);
		
		return "redirect:/player_list";
	}
	
	@RequestMapping("/skin_list")
	public String skinList(Model model, @RequestParam(value="page", required=false, defaultValue="1") String page, Search search) {
		System.out.println(search.toString());
		
		if(search.getContent() == null)
			search.setContent("");
		
		search.setCheckProperties(true);
		search.setCheckTiers(true);
		if(search.getProperties() == null) { 
			search.setCheckProperties(false);
		}
		if(search.getTiers() == null) {
			search.setCheckTiers(false);
		}
		System.out.println(search.toString());
		
		search.setPage((Integer.parseInt(page)-1)*10);
		List<Skin> list = skinservice.getSkinList(search);
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(Integer.parseInt(page), skinservice.getSkinCount(search));
		model.addAttribute("pagination", pg);
						
		model.addAttribute("search", search);
		return "/skin_list";
	}
	
	@RequestMapping("/skin_write")
	public String skinWrite() {
		return "/skin_write";
	}
	
	@RequestMapping("/skin_write_result")
	public String SkinWriteResult(Skin skin, HttpServletRequest request) {
		System.out.println(skin.toString());
		
		if(!skin.getS_image().getOriginalFilename().equals("")) {
			String path = request.getSession().getServletContext().getRealPath("/") + "resources\\img\\skin\\";
			
			MultipartFile file = skin.getS_image();
			String uuidName = UUID.randomUUID().toString() + file.getOriginalFilename();
			String oPath = path + uuidName; // 원본 경로
						
			try {
				file.transferTo(new File(oPath));
			} catch(IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			File oFile = new File(oPath);

			int index = oPath.lastIndexOf(".");
			String ext = oPath.substring(index + 1); // 파일 확장자

			String tPath = oFile.getParent() + File.separator + "t-" + oFile.getName(); // 썸네일저장 경로
			File tFile = new File(tPath);
			
			double ratio = 2; // 이미지 축소 비율

			try {
				BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
				int tWidth = (int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
				int tHeight = (int) (oImage.getHeight() / ratio); // 생성할 썸네일이미지의 높이
				
				BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
				Graphics2D graphic = tImage.createGraphics();
				Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
				graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
				graphic.dispose(); // 리소스를 모두 해제

				ImageIO.write(tImage, ext, tFile);
			} catch (IOException e) {
				e.printStackTrace();
			}		
			
			skin.setS_full("resources\\img\\skin\\" + uuidName);
			skin.setS_thumb("resources\\img\\skin\\t-" + uuidName);
		}		
				
		skinservice.writeSkin(skin);
		
		return "redirect:/skin_list";
	}
	
	@RequestMapping("/player_duplicate")
	public String PlayerDuplicate(HttpServletRequest request) {
		System.out.println(request.getParameter("name"));
		String name = request.getParameter("name");
		System.out.println(name);
		
		Player player = playerservice.findPlayer(name);
		
		if(player != null)
			return "/dup_ok";
		else
			return "/dup_no";
	}

	@RequestMapping("/skin_detail")
	public String skinDetail(Model model, @RequestParam("s_num") int s_num) {
		Skin skin = skinservice.findSkin(s_num);
		model.addAttribute("player", playerservice.findPlayer(skin.getP_name()));
		model.addAttribute("skin", skin);
				
		Search search = new Search();
		search.setPage(0);
		search.setS_num(s_num);
				
		List<Reply> list = replyservice.getReply(search);		
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(1, replyservice.getReplyCount(search));
		model.addAttribute("pagination", pg);
		
		return "/skin_detail";
	}
	
	@RequestMapping("/skin_edit")
	public String skinEdit(Model model, @RequestParam("s_num") int s_num) {
		Skin skin = skinservice.findSkin(s_num);
		
		model.addAttribute("skin", skin);
		return "/skin_edit";		
	}
	
	@RequestMapping("/skin_edit_result")
	public String skinEditResult(Skin skin, HttpServletRequest request) {
		Skin temp = skinservice.findSkin(skin.getS_num());
		skin.setS_full(temp.getS_full());
		skin.setS_thumb(temp.getS_thumb());
		
		if(!skin.getS_image().getOriginalFilename().equals("")) {
			String path = request.getSession().getServletContext().getRealPath("/") + "resources\\img\\skin\\";
			
			MultipartFile file = skin.getS_image();
			String uuidName = UUID.randomUUID().toString() + file.getOriginalFilename();
			String oPath = path + uuidName; // 원본 경로
						
			try {
				file.transferTo(new File(oPath));
			} catch(IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			File oFile = new File(oPath);

			int index = oPath.lastIndexOf(".");
			String ext = oPath.substring(index + 1); // 파일 확장자

			String tPath = oFile.getParent() + File.separator + "t-" + oFile.getName(); // 썸네일저장 경로
			File tFile = new File(tPath);
			
			double ratio = 2; // 이미지 축소 비율

			try {
				BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
				int tWidth = (int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
				int tHeight = (int) (oImage.getHeight() / ratio); // 생성할 썸네일이미지의 높이
				
				BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
				Graphics2D graphic = tImage.createGraphics();
				Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
				graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
				graphic.dispose(); // 리소스를 모두 해제

				ImageIO.write(tImage, ext, tFile);
			} catch (IOException e) {
				e.printStackTrace();
			}		
			
			skin.setS_full("resources\\img\\skin\\" + uuidName);
			skin.setS_thumb("resources\\img\\skin\\t-" + uuidName);
		}
		
		skinservice.editSkin(skin);
		
		return "redirect:/player_list";
	}
	
	@RequestMapping("/deck")
	public String deckMain() {
		return "/deck";
	}
}
