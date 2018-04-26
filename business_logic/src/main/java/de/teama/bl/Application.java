package de.teama.bl;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import de.teama.bl.data.Song;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@SpringBootApplication
@RestController
public class Application {

    private final ObjectMapper mapper;
    private String urlDB = "http://localhost:3000";
    private String urlGUI = "http://localhost:8080";

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
    )
    {
        RestTemplate template = new RestTemplate();

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
    public String getSong(
            @RequestParam(value = "id") String id)
    {
        RestTemplate template = new RestTemplate();
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

        String json;
        Map<String ,String > params = new HashMap<>();
        params.put("id", id);
        json = template.getForObject(
                urlDB +
                "/song" +
                "/{id}",
                String.class, params);

        return json;
    }

//    private static void createSong()
//    {
//      final String uri = "http://localhost:8080/song/";
//      Song newSong = new Song("", "Highway", "4:56", "01-01-2000", "AMW Music", "ACDC");
//
//      RestTemplate restTemplate = new RestTemplate();
//      Song result = restTemplate.postForObject( uri, newSong, Song.class);
//
//      System.out.println(result);
//    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}
