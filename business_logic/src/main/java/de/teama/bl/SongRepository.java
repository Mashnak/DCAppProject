package de.teama.bl;

import de.teama.bl.data.Song;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface SongRepository extends MongoRepository<Song, String> {

    public Song findByName(String title);
    //public List<Song> findByArtist(String artist);
}
