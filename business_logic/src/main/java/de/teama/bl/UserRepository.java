package de.teama.bl;

import de.teama.bl.data.Users;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface UserRepository extends MongoRepository<Users, String> {
    Users findByName(String name);
    List<Users> findByNameLike(String name);
    void deleteByName(String name);
}
