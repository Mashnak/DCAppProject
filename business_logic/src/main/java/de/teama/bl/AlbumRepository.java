package de.teama.bl;

import de.teama.bl.data.Album;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AlbumRepository extends MongoRepository<Album, String> {
    Album findByName(@Param("name") String name);
    List<Album> findByNameLike(@Param("name") String name);

    List<Album> findByPublisherLike(@Param("publisher") String publisher);
    List<Album> findByGenreLike(@Param("genre") String genre);
    List<Album> findByTagLike(@Param("tag") String tag);
}
