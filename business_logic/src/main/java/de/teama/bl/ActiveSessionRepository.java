package de.teama.bl;

import de.teama.bl.data.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ActiveSessionRepository extends MongoRepository<User, String> {
    String findByName(String username);
    void deleteByName(String username);
}
