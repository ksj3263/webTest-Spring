package com.webTest2.example.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.webTest2.example.domain.Board;
import com.webTest2.example.domain.PaginationBoard;
import com.webTest2.example.domain.User;
import com.webTest2.example.service.BoardService;
import com.webTest2.example.service.UserService;

@org.springframework.stereotype.Controller
public class Controller {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired BoardService boardservice;
	@Autowired UserService userservice;
	
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
		boardservice.writeBoard(board);
		boardservice.updateBase();
		
		List<Board> list = boardservice.selectBoardList(1);
		model.addAttribute("list", list);
		
		PaginationBoard pgb = new PaginationBoard(1, boardservice.getBoardCount());
		model.addAttribute("pagination", pgb);
		return "/board_list";
	}
	//ddd
	@RequestMapping("/board_detail")
	public String boardDetail(Model model, @RequestParam("bId") int id) {
		Board board = boardservice.findBoard(id);
		model.addAttribute("board", board);
		return "/board_detail";
	}
}
