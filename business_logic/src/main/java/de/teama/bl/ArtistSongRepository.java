package de.teama.bl;

import de.teama.bl.data.ArtistSongs;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArtistSongRepository extends MongoRepository<ArtistSongs, String> {
    List<ArtistSongs> findBySong(@Param("song") String song);
    List<ArtistSongs> findByArtist(@Param("artist") String Artist);
}
