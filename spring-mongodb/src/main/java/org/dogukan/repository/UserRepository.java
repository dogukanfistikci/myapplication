package org.dogukan.repository;

import org.dogukan.domain.User;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserRepository extends MongoRepository<User, String>
{
	
	User findByPhoneNumber(String phoneNumber);
}
