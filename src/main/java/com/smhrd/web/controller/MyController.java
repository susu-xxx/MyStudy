package com.smhrd.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.smhrd.web.entity.DataMember;
import com.smhrd.web.repo.DataMemberRepository;

@Controller
public class MyController {
	//DB연결과 관련된 기능을 mapping 사용 
	@Autowired
	DataMemberRepository repository;
	
	@PostMapping("login-process")
	public String main(DataMember member) {
		DataMember loginMember = repository.findByIdAndPw(member.getId(), member.getPw());
	
	
	return "redirect:/main";
	}
	
	@PostMapping("/join-process")
	public String joinProcess(DataMember member) {
		repository.save(member);
		return "redirect:/";
	}

}
