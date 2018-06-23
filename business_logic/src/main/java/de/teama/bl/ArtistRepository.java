package de.teama.bl;

import de.teama.bl.data.Artists;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArtistRepository extends MongoRepository<Artists, String> {
    Artists findByName(@Param("name") String name);
    List<Artists> findByNameLike(@Param("name") String name);

    List<Artists> findByGenreLike(@Param("genre") String genre);

    List<Artists> findByTagLike(@Param("tag") String tag);
}
