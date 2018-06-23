package de.teama.bl;

import de.teama.bl.data.Sessions;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ActiveSessionRepository extends MongoRepository<Sessions, String> {
    String findByName(String username);
    void deleteByName(String username);
}
