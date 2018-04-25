package de.teama.bl;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import de.teama.bl.data.Song;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.atomic.AtomicLong;

@SpringBootApplication
@RestController
public class Application {

    private final ObjectMapper mapper;

    Application() {
        mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
    }

    @RequestMapping(value = "/song", method = RequestMethod.POST)
    public String insertNewSong(
            @RequestParam(value = "name") String name,
            @RequestParam(value = "length") String length,
            @RequestParam(value = "releaseDate") String releaseDate,
            @RequestParam(value = "publisher") String publisher,
            @RequestParam(value = "album") String album
    ) {
        Song song = new Song("",
                name,
                length,
                releaseDate,
                publisher,
                album
        );

        String json = "";
        try {
            json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(song);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        // Send to DB

        return "";
    }

    @RequestMapping(value = "/song", method = RequestMethod.GET)
    public String insertNewSong(
            @RequestParam(value = "id") String id
    ) {
        /*
        Retrieve Song from DB by id
        Song song = new Song("",
                name,
                length,
                releaseDate,
                publisher,
                album
        );
        */

        String json = "";
//
//        try {
//            json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(song);
//        } catch (JsonProcessingException e) {
//            e.printStackTrace();
//        }

        return json;
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}
