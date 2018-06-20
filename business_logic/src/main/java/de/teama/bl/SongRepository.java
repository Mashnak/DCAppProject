package de.teama.bl;

import de.teama.bl.data.Song;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SongRepository extends MongoRepository<Song, String> {

    List<Song> findByName(@Param("name") String name);

    List<Song> findByLength(@Param("length") String length);

    List<Song> findByReleaseDate(@Param("releaseData") String releaseDate);

    List<Song> findByAlbum(@Param("album") String album);
    //List<Song> findAll();
}
