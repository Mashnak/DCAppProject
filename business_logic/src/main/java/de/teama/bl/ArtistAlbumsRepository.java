package de.teama.bl;

import de.teama.bl.data.ArtistAlbums;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArtistAlbumsRepository extends MongoRepository<ArtistAlbums, String> {
    List<ArtistAlbums> findByArtist(@Param("artist") String artist);
    List<ArtistAlbums> findByAlbum(@Param("album") String album);
}
