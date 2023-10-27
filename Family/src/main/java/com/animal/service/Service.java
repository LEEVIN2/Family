package com.animal.service;

import javax.inject.Inject;

import com.animal.dao.DAO;
import com.animal.domain.DTO;

@org.springframework.stereotype.Service
public class Service {
	
	@Inject
	private DAO DAO;

	public void insert(DTO DTO) {
		DAO.insert(DTO);
	}

}
