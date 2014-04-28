package org.dogukan.service;

import java.util.UUID;

import org.dogukan.domain.Role;
import org.dogukan.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;

/**
 * Service for initializing MongoDB with sample data using {@link MongoTemplate}
 */
public class InitMongoService {
	
	@Autowired
	private MongoTemplate mongoTemplate;

	public void init() {
		// Drop existing collections
		mongoTemplate.dropCollection("role");
		mongoTemplate.dropCollection("user");

		// Create new records
		Role adminRole = new Role();
		adminRole.setId(UUID.randomUUID().toString());
		adminRole.setRole(1);
		
		Role userRole = new Role();
		userRole.setId(UUID.randomUUID().toString());
		userRole.setRole(2);
		
		User dogu = new User();
		dogu.setId(UUID.randomUUID().toString());
		dogu.setFirstName("Doðukan");
		dogu.setLastName("Fýstýkçý");
		dogu.setPassword("21232f297a57a5a743894a0e4a801fc3");
		dogu.setRole(adminRole);
		dogu.setPhoneNumber("05366475556");
		
		User alp = new User();
		alp.setId(UUID.randomUUID().toString());
		alp.setFirstName("Alp");
		alp.setLastName("Sadýç");
		alp.setPassword("21232f297a57a5a743894a0e4a801fc3");
		alp.setRole(userRole);
		alp.setPhoneNumber("05547756469");
		
		User oguz = new User();
		oguz.setId(UUID.randomUUID().toString());
		oguz.setFirstName("Oðuz");
		oguz.setLastName("Erbil");
		oguz.setPassword("ee11cbb19052e40b07aac0ca060c23ee");
		oguz.setRole(userRole);
		oguz.setPhoneNumber("05415481313");
		
		// Insert to db
		mongoTemplate.insert(dogu, "user");
		mongoTemplate.insert(oguz, "user");
		mongoTemplate.insert(alp, "user");
		mongoTemplate.insert(adminRole, "role");
		mongoTemplate.insert(userRole, "role");
	}
}
