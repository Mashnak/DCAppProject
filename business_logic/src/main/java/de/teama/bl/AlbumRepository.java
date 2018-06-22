package de.teama.bl;

import de.teama.bl.data.Album;
import org.json.JSONObject;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AlbumRepository extends MongoRepository<Album, String> {
    Album findByName(@Param("name") String name);
    List<JSONObject> findByNameLike(@Param("name") String name);

    List<JSONObject> findByPublisherLike(@Param("publisher") String publisher);
    List<JSONObject> findByGenreLike(@Param("genre") String genre);
    List<JSONObject> findByTagLike(@Param("tag") String tag);
}
