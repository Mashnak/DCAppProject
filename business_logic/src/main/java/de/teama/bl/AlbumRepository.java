package de.teama.bl;

import de.teama.bl.data.Album;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AlbumRepository extends MongoRepository<Album, String> {

    List<Album> findByName(@Param("name") String name);

}
