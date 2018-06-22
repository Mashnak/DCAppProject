package de.teama.bl;

import de.teama.bl.data.Song;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SongRepository extends MongoRepository<Song, String> {

    Song findByName(@Param("name") String name);
    List<Song> findByNameLike(@Param("name") String name);
    List<Song> findByNameLikeOrderByNameAsc(@Param("name") String name);

    List<Song> findByLength(@Param("length") String length);
    List<Song> findByLengthLike(@Param("length") String length);
    List<Song> findByLengthLikeOrderByNameAsc(@Param("length") String length);

    List<Song> findByReleaseDate(@Param("releaseDate") String releaseDate);
    List<Song> findByReleaseDateLike(@Param("releaseDate") String releaseDate);
    List<Song> findByReleaseDateLikeOrderByNameAsc(@Param("releaseDate") String releaseDate);

    List<Song> findByLyrics(@Param("lyrics") String lyrics);
    List<Song> findByLyricsLike(@Param("lyrics") String lyrics);
    List<Song> findByLyricsLikeOrderByNameAsc(@Param("lyrics") String lyrics);

    List<Song> findByGenre(@Param("genre") String genre);
    List<Song> findByGenreLike(@Param("genre") String genre);
    List<Song> findByGenreLikeOrderByNameAsc(@Param("genre") String genre);

    List<Song> findByTag(@Param("tag") String tag);
    List<Song> findByTagLike(@Param("tag") String tag);
    List<Song> findByTagLikeOrderByNameAsc(@Param("tag") String tag);

    List<Song> findByAlbum(@Param("album") String album);
    List<Song> findByAlbumLike(@Param("album") String album);
    List<Song> findByAlbumLikeOrderByNameAsc(@Param("album") String album);
    List<Song> findAll();
}
