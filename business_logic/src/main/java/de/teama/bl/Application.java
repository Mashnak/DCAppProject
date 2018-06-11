package de.teama.bl;

import com.fasterxml.jackson.databind.ObjectWriter;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientOptions;
import de.teama.bl.data.Song;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@SpringBootApplication
@RestController
@CrossOrigin(origins = "*")
public class Application implements ApplicationRunner {

    @Autowired
    private SongRepository repository;

    private MongoClient mongoClient;
    private final Logger logger;
    private final ObjectMapper mapper;
    private final RestTemplate template;
    private String urlDB;
    private ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();

    Application() {
        logger = LoggerFactory.getLogger(Application.class);

        mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);

        template = new RestTemplate();
    }

    @Override
    public void run(ApplicationArguments args) {
        urlDB = String.format("http://%s:%s", args.getOptionValues("DB.ip").get(0),
                args.getOptionValues("DB.port").get(0));
        logger.info("Sending db requests to {}", urlDB);
        mongoClient = new MongoClient(String.format("%s", args.getOptionValues("DB.ip").get(0)));
        logger.info("{}",mongoClient.getUsedDatabases());

    }

    @RequestMapping(value = "/alive", method = RequestMethod.GET)
    public String getAlive() {
        return "Alive";
    }

    @RequestMapping(value = "/song", method = RequestMethod.POST)
    public String insertNewSong(@RequestParam(value = "name") String name,
            @RequestParam(value = "length") String length, @RequestParam(value = "releaseDate") String releaseDate,
            @RequestParam(value = "publisher") String publisher, @RequestParam(value = "album") String album) {

        Map<String, String> params = new HashMap<>();
        params.put("name", name);
        // etc

        String json;
        Song data = new Song( name, length, releaseDate, publisher, album);
        logger.info("Sending dataset: {}, {}, {}, {}, {}, {}", "1", name, length, releaseDate, publisher, album);
        repository.save(data);
        // postForObject?
        //json = template.getForObject(urlDB + "/song" + "/{name}", String.class, params);

        // return errorcode
        try{
            return ow.writeValueAsString(data);
        } catch (JsonProcessingException e){
            logger.info(e.getMessage());
            return "Search failed! See server log for detail";
        }
    }

    @RequestMapping(value = "/song", method = RequestMethod.GET)
    public String getSong(@RequestParam(value = "name", required = false) String name,
                          @RequestParam(value = "publisher", required = false) String publisher) {

        Map<String, String> params = new HashMap<>();
        params.put("name", name);
        params.put("publisher", publisher);
        logger.info("Searching for Song with name {}", name);
        String json;
        try{
            json = ow.writeValueAsString(repository.findByName(name));
        } catch (JsonProcessingException e){
            json = "Search failed! See server log for detail";
            logger.info(e.getMessage());
        }

        return json;

    }
    public String getSong(@RequestParam(value = "publisher") String publisher){

        Map<String, String> params = new HashMap<>();
        params.put("publisher", publisher);
        logger.info("Searching for publisher with name {}", publisher);
        String json;
        try{
            json = ow.writeValueAsString(repository.findByPublisher(publisher));
        } catch (JsonProcessingException e){
            json = "Search failed! See server log for detail";
            logger.info(e.getMessage());
        }

        return json;
    }

    @RequestMapping(value = "/album", method = RequestMethod.GET)
    public String getAlbum(@RequestParam(value = "id", defaultValue = "507f191e810c19729de860ea") String id) {
        // Genius level code
        return "{\"id\": \"132sdafasdfas123as97ahjg\",\"name\": \"Run The Jewels 3\",\"totalLength\": \"51:27\",\"releaseDate\": \"2016-12-24\",\"genres\": [{\"id\": \"ldjflkejieij343l4l3jldjl\",\"name\": \"Hip hop/Rap\"}],\"tags\": [{\"id\": \"lflwlejelwkjkwejrkj4330\",\"name\": \"Fussballhymne\"},{\"id\": \"dkskjdldjlwdjljwldl7wd2\",\"name\": \"BVB\"}],\"songs\": [{\"id\": \"507f191e810c19729de860ea\",\"name\": \"Legends Has It\"}],\"artists\": [{\"id\": \"116fn30gttdbor64nd63hgkw\",\"name\": \"Run The Jewels\"}],\"publisher\": {\"id\": \"18b9t6dnr04zfdp37tnvopur\",\"name\": \"Run The Jewels, Inc.\"}}";
    }

    @RequestMapping(value = "/artist", method = RequestMethod.GET)
    public String getArtist(@RequestParam(value = "artist") String artist) {

//        Map<String, String> params = new HashMap<>();
//        params.put("artist", artist);
//        logger.info("Searching for artist with name {}", artist);
//        String json;
//        try{
//            json = ow.writeValueAsString(repository.findByArtist(artist));
//        } catch (JsonProcessingException e){
//            json = "Search failed! See server log for detail";
//            logger.info(e.getMessage());
//        }
//
//        return json;
        return "not implemented";
    }

    @RequestMapping(value = "/publisher", method = RequestMethod.GET)
    public String getPublisher(@RequestParam(value = "publisher") String publisher) {
        return  "not implemented";
    }

    @RequestMapping(value = "/clear", method = RequestMethod.DELETE)
    public String clearRepository(){
        repository.deleteAll();
        return "Cleared Repository";
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}