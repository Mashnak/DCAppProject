package de.teama.bl;

import de.teama.bl.data.Artistsongs;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArtistSongsRepository extends MongoRepository<Artistsongs, String> {
    List<Artistsongs> findBySong(@Param("song") String song);
    List<Artistsongs> findByArtist(@Param("artist") String Artist);
}
