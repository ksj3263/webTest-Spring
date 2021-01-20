package com.webTest2.example.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.webTest2.example.domain.Board;
import com.webTest2.example.domain.PaginationBoard;
import com.webTest2.example.domain.Reply;
import com.webTest2.example.domain.User;
import com.webTest2.example.service.BoardService;
import com.webTest2.example.service.ReplyService;
import com.webTest2.example.service.UserService;

@org.springframework.stereotype.Controller
public class Controller {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired BoardService boardservice;
	@Autowired UserService userservice;
	@Autowired ReplyService replyservice;
	
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
		user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER"));
		
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
		
		PaginationBoard pgb = new PaginationBoard(Integer.parseInt(page), boardservice.getBoardCount());
		model.addAttribute("pagination", pgb);
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
		
		List<Board> list = boardservice.selectBoardList(1);
		model.addAttribute("list", list);
		
		PaginationBoard pgb = new PaginationBoard(1, boardservice.getBoardCount());
		model.addAttribute("pagination", pgb);
		return "/board_list";
	}
	
	@RequestMapping("/board_delete")
	public String boardDelete(Model model, @RequestParam("bId") int id) {
		boardservice.deleteBoard(id);
		
		List<Board> list = boardservice.selectBoardList(1);
		model.addAttribute("list", list);
		
		PaginationBoard pgb = new PaginationBoard(1, boardservice.getBoardCount());
		model.addAttribute("pagination", pgb);
		
		return "/board_list";
	}
	
	@RequestMapping("/board_edit")
	public String boardEdit(Model model, @RequestParam("bId") int id) {
		Board board = boardservice.findBoard(id);
		
		model.addAttribute("board", board);
		
		return "/board_edit";
	}
	
	@RequestMapping("/board_edit_result")
	public String boardEditResult(Model model, Board board) {
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		board.setbDateTime(format.format(today));
		
		boardservice.editBoard(board);
		
		List<Board> list = boardservice.selectBoardList(1);
		model.addAttribute("list", list);
		
		PaginationBoard pgb = new PaginationBoard(1, boardservice.getBoardCount());
		model.addAttribute("pagination", pgb);
		
		return "/board_list";
	}
	
	@RequestMapping(value="/board_reply", method=RequestMethod.POST)
	public String boardReply(Model model, HttpServletRequest request) {
		int bId = Integer.parseInt(request.getParameter("b_id"));
		
		Reply reply = new Reply();
		reply.setbId(bId);
		reply.setrContent(request.getParameter("content"));
		reply.setrWriter(request.getParameter("rWriter"));
		reply.setuId(request.getParameter("rWriter"));
		replyservice.writeReply(reply);
		
		List<Reply> list = replyservice.getReply(bId);
		model.addAttribute("list", list);
		// ?
		return "/reply_list";
	}
}
