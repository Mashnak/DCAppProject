package de.teama.bl;

import de.teama.bl.data.Albums;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AlbumRepository extends MongoRepository<Albums, String> {
    Albums findByName(@Param("name") String name);
    List<Albums> findByNameLike(@Param("name") String name);

    List<Albums> findByPublisherLike(@Param("publisher") String publisher);
    List<Albums> findByGenreLike(@Param("genre") String genre);
    List<Albums> findByTagLike(@Param("tag") String tag);
}
