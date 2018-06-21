package de.teama.bl;

import de.teama.bl.data.Song;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SongRepository extends MongoRepository<Song, String> {

    Song findByName(@Param("name") String name);
    List<Song> findByNameLike(@Param("name") String name);

    Song findByLength(@Param("length") String length);
    List<Song> findByLengthLike(@Param("name") String name);

    Song findByReleaseDate(@Param("releaseData") String releaseDate);
    List<Song> findByReleaseDateLike(@Param("name") String name);

    Song findByAlbum(@Param("album") String album);
    List<Song> findByAlbumLike(@Param("name") String name);
    //List<Song> findAll();
}
