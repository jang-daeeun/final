package com.kh.maison.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.maison.admin.model.service.AdminService;

@Controller
public class AdminController {

	@Autowired
	private AdminService service;
	
	@RequestMapping("/admin/dashBoard.do")
	public String adminMain() {
		return "admin/dashBoard";
	}
}
