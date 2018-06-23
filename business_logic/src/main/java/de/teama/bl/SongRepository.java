package de.teama.bl;

import de.teama.bl.data.Songs;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SongRepository extends MongoRepository<Songs, String> {

    Songs findByName(@Param("name") String name);
    List<Songs> findByNameLike(@Param("name") String name);
    List<Songs> findByNameLikeOrderByNameAsc(@Param("name") String name);

    List<Songs> findByLength(@Param("length") String length);
    List<Songs> findByLengthLike(@Param("length") String length);
    List<Songs> findByLengthLikeOrderByNameAsc(@Param("length") String length);

    List<Songs> findByReleaseDate(@Param("releaseDate") String releaseDate);
    List<Songs> findByReleaseDateLike(@Param("releaseDate") String releaseDate);
    List<Songs> findByReleaseDateLikeOrderByNameAsc(@Param("releaseDate") String releaseDate);

    List<Songs> findByLyrics(@Param("lyrics") String lyrics);
    List<Songs> findByLyricsLike(@Param("lyrics") String lyrics);
    List<Songs> findByLyricsLikeOrderByNameAsc(@Param("lyrics") String lyrics);

    List<Songs> findByGenre(@Param("genre") String genre);
    List<Songs> findByGenreLike(@Param("genre") String genre);
    List<Songs> findByGenreLikeOrderByNameAsc(@Param("genre") String genre);

    List<Songs> findByTag(@Param("tag") String tag);
    List<Songs> findByTagLike(@Param("tag") String tag);
    List<Songs> findByTagLikeOrderByNameAsc(@Param("tag") String tag);

    List<Songs> findByAlbum(@Param("album") String album);
    List<Songs> findByAlbumLike(@Param("album") String album);
    List<Songs> findByAlbumLikeOrderByNameAsc(@Param("album") String album);
    List<Songs> findAll();
}
