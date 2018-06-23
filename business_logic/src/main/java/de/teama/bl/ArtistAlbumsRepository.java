package de.teama.bl;

import de.teama.bl.data.Albums;
import de.teama.bl.data.ArtistAlbums;
import de.teama.bl.data.Artists;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArtistAlbumsRepository extends MongoRepository<ArtistAlbums, String> {
    List<Albums> findByArtist(@Param("artist") String artist);
    List<Artists> findByAlbum(@Param("album") String album);
}
