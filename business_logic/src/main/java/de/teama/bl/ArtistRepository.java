package de.teama.bl;

import de.teama.bl.data.Artist;
import org.springframework.data.domain.Example;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArtistRepository extends MongoRepository<Artist, String> {
    List<Artist> findByName(@Param("name") String name);

    List<Artist> findByGenre(@Param("genre") String genre);
}
