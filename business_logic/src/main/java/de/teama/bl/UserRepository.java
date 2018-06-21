package de.teama.bl;

import de.teama.bl.data.User;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface UserRepository extends MongoRepository<User, String> {
    User findByName(String name);
    List<User> findByNameLike(String name);
}
