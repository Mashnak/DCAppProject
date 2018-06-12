package de.teama.bl;

import de.teama.bl.data.Publisher;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PublisherRepository extends MongoRepository<Publisher, String> {

    List<Publisher> findByName(@Param("name") String name);
    //  List<Publisher> findAll();
}
