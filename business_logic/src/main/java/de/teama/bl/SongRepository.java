package de.teama.bl;

import de.teama.bl.data.Song;
import org.json.JSONObject;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SongRepository extends MongoRepository<Song, String> {

    Song findByName(@Param("name") String name);
    List<JSONObject> findByNameLike(@Param("name") String name);
    List<JSONObject> findByNameLikeOrderByNameAsc(@Param("name") String name);

    List<JSONObject> findByLength(@Param("length") String length);
    List<JSONObject> findByLengthLike(@Param("length") String length);
    List<JSONObject> findByLengthLikeOrderByNameAsc(@Param("length") String length);

    List<JSONObject> findByReleaseDate(@Param("releaseDate") String releaseDate);
    List<JSONObject> findByReleaseDateLike(@Param("releaseDate") String releaseDate);
    List<JSONObject> findByReleaseDateLikeOrderByNameAsc(@Param("releaseDate") String releaseDate);

    List<JSONObject> findByLyrics(@Param("lyrics") String lyrics);
    List<JSONObject> findByLyricsLike(@Param("lyrics") String lyrics);
    List<JSONObject> findByLyricsLikeOrderByNameAsc(@Param("lyrics") String lyrics);

    List<JSONObject> findByGenre(@Param("genre") String genre);
    List<JSONObject> findByGenreLike(@Param("genre") String genre);
    List<JSONObject> findByGenreLikeOrderByNameAsc(@Param("genre") String genre);

    List<JSONObject> findByTag(@Param("tag") String tag);
    List<JSONObject> findByTagLike(@Param("tag") String tag);
    List<JSONObject> findByTagLikeOrderByNameAsc(@Param("tag") String tag);

    List<JSONObject> findByAlbum(@Param("album") String album);
    List<JSONObject> findByAlbumLike(@Param("album") String album);
    List<JSONObject> findByAlbumLikeOrderByNameAsc(@Param("album") String album);
    List<Song> findAll();
}
