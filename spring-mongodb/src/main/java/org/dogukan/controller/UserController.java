package org.dogukan.controller;

import org.dogukan.domain.Role;
import org.dogukan.domain.User;
import org.dogukan.dto.UserListDto;
import org.dogukan.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/users")
public class UserController {

	@Autowired
	private UserService service;
	
	@RequestMapping
	public String getUsersPage() {
		return "users";
	}
	
	@RequestMapping(value="/records")
	public @ResponseBody UserListDto getUsers() {
		
		UserListDto userListDto = new UserListDto();
		userListDto.setUsers(service.readAll());
		return userListDto;
	}
	
	@RequestMapping(value="/get")
	public @ResponseBody User get(@RequestBody User user) {
		return service.read(user);
	}

	@RequestMapping(value="/create", method=RequestMethod.POST)
	public @ResponseBody User create(
			@RequestParam String phoneNumber,
			@RequestParam String password,
			@RequestParam String firstName,
			@RequestParam String lastName,
			@RequestParam Integer role) {

		Role newRole = new Role();
		newRole.setRole(role);
		
		User newUser = new User();
		newUser.setPhoneNumber(phoneNumber);
		newUser.setPassword(password);
		newUser.setFirstName(firstName);
		newUser.setLastName(lastName);
		newUser.setRole(newRole);
		
		return service.create(newUser);
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public @ResponseBody User update(
			@RequestParam String phoneNumber,
			@RequestParam String firstName,
			@RequestParam String lastName,
			@RequestParam Integer role) {

		Role existingRole = new Role();
		existingRole.setRole(role);
		
		User existingUser = new User();
		existingUser.setPhoneNumber(phoneNumber);
		existingUser.setFirstName(firstName);
		existingUser.setLastName(lastName);
		existingUser.setRole(existingRole);
		
		return service.update(existingUser);
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public @ResponseBody Boolean delete(
			@RequestParam String phoneNumber) {

		User existingUser = new User();
		existingUser.setPhoneNumber(phoneNumber);
		
		return service.delete(existingUser);
	}
}
