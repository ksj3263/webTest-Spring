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
import com.webTest2.example.domain.User;
import com.webTest2.example.service.BoardService;
import com.webTest2.example.service.PlayerService;
import com.webTest2.example.service.ReplyService;
import com.webTest2.example.service.UserService;

@org.springframework.stereotype.Controller
public class Controller {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired BoardService boardservice;
	@Autowired UserService userservice;
	@Autowired ReplyService replyservice;
	@Autowired PlayerService playerservice;
	
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
	public String boardList(Model model, @RequestParam(value="page", required=false, defaultValue="1") String page) {				
		List<Board> list = boardservice.selectBoardList(Integer.parseInt(page));
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(Integer.parseInt(page), boardservice.getBoardCount());
		model.addAttribute("pagination", pg);
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
		board.setuId(board.getbWriter());
		boardservice.writeBoard(board);
		boardservice.updateBase();		
		
		return "redirect:/board_detail?bId=" + boardservice.lastBoard();
	}
	
	@RequestMapping("/board_detail")
	public String boardDetail(Model model, @RequestParam("bId") int id) {
		Board board = boardservice.findBoard(id);
		model.addAttribute("board", board);
		
		List<Reply> list = replyservice.getReply(id);
		model.addAttribute("list", list);
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
		board.setuId(board.getbWriter());
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
	
	@RequestMapping(value="/board_reply", method=RequestMethod.POST)
	public String boardReply(Model model, HttpServletRequest request) {
		int bId = Integer.parseInt(request.getParameter("b_id"));
		
		Reply reply = new Reply();
		reply.setbId(bId);
		reply.setrContent(request.getParameter("content"));
		reply.setrWriter(request.getParameter("rWriter"));
		reply.setuId(request.getParameter("u_id"));
		replyservice.writeReply(reply);
		
		List<Reply> list = replyservice.getReply(bId);
		model.addAttribute("list", list);
		
		return "/reply_list";
	}
	
	@RequestMapping(value="/board_reply_delete", method=RequestMethod.POST)
	public String boardReplyDelete(Model model, HttpServletRequest request, @AuthenticationPrincipal User user) {
		int rId = Integer.parseInt(request.getParameter("r_id"));
		
		Reply reply = replyservice.findReply(rId);
		String uId = user.getUsername();

		if(!uId.equals(reply.getuId()))
			return "/reply_denied";		
		
		replyservice.deleteReply(rId);
		
		List<Reply> list = replyservice.getReply(reply.getbId());
		model.addAttribute("list", list);
		
		return "/reply_list";
	}
	
	@RequestMapping(value="/board_reply_edit", method=RequestMethod.POST)
	public String boardReplyEdit(Model model, HttpServletRequest request, @AuthenticationPrincipal User user) {
		int rId = Integer.parseInt(request.getParameter("r_id"));
		
		Reply reply = replyservice.findReply(rId);
		String uId = user.getUsername();

		if(!uId.equals(reply.getuId()))
			return "/reply_denied";
		
		model.addAttribute("reply", reply);
		
		return "/reply_edit";
	}
	
	@RequestMapping(value="/board_reply_edit_result", method=RequestMethod.POST)
	public String boardReplyEditResult(Model model, HttpServletRequest request) {
		int rId = Integer.parseInt(request.getParameter("r_id"));
		String content = request.getParameter("edit_content");
		
		Reply reply = replyservice.findReply(rId);
		
		reply.setrContent(content);
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		reply.setrDateTime(format.format(today));
		
		replyservice.editReply(reply);
		List<Reply> list = replyservice.getReply(reply.getbId());
		model.addAttribute("list", list);
		
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
		System.out.println(page);
		System.out.println(search.toString());
		
		if(search.getContent() == null)
			search.setContent("");
		System.out.println(search.getContent());
		
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
		
		search.setPage((Integer.parseInt(page)-1)*10);
		List<Player> list = playerservice.searchPlayer(search);
		model.addAttribute("list", list);
		
		Pagination pg = new Pagination(Integer.parseInt(page), playerservice.getPlayerCount(search));
		model.addAttribute("pagination", pg);
						
		model.addAttribute("search", search);
		return "/player_list";
	}
	
	@RequestMapping("/player_detail")
	public String playerDetail(Model model, @RequestParam("p_num") int p_num) {
		Player player = playerservice.findPlayer(p_num);
		model.addAttribute("player", player);
		
		return "/player_detail";
	}
	
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
}
