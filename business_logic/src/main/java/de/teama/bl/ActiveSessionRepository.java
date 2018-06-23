package de.teama.bl;

import de.teama.bl.data.Users;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ActiveSessionRepository extends MongoRepository<Users, String> {
    String findByName(String username);
    void deleteByName(String username);
}
