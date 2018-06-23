package de.teama.bl;

import de.teama.bl.data.ArtistSongs;
import de.teama.bl.data.Artists;
import de.teama.bl.data.Songs;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArtistSongRepository extends MongoRepository<ArtistSongs, String> {
    List<Artists> findBySong(@Param("song") String song);
    List<Songs> findByArtist(@Param("artist") String Artist);
}
