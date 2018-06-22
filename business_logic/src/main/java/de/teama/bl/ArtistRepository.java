package de.teama.bl;

import de.teama.bl.data.Artist;
import org.json.JSONObject;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArtistRepository extends MongoRepository<Artist, String> {
    Artist findByName(@Param("name") String name);
    List<JSONObject> findByNameLike(@Param("name") String name);

    List<JSONObject> findByGenreLike(@Param("genre") String genre);

    List<JSONObject> findByTagLike(@Param("tag") String tag);
}
