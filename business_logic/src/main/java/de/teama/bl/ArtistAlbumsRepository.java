package de.teama.bl;


import de.teama.bl.data.Artistalbums;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ArtistAlbumsRepository extends MongoRepository<Artistalbums, String> {
    List<Artistalbums> findByArtist(@Param("artist") String artist);
    List<Artistalbums> findByAlbum(@Param("album") String album);
}
