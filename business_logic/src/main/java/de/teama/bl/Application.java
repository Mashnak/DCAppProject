package de.teama.bl;

import com.fasterxml.jackson.databind.ObjectWriter;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientOptions;
import de.teama.bl.data.Publisher;
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

import java.util.*;

@SpringBootApplication
@RestController
@CrossOrigin(origins = "*")
public class Application implements ApplicationRunner {

    @Autowired
    private SongRepository songRepository;

    @Autowired
    private ArtistRepository artistRepository;

    @Autowired
    private PublisherRepository publisherRepository;

    @Autowired
    private AlbumRepository albumRepository;

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
        logger.info("{}", mongoClient.getUsedDatabases());

    }

    @RequestMapping(value = "/status", method = RequestMethod.GET)
    public String getAlive() {
        return "No. 5 Alive";
    }

    @RequestMapping(value = "/song", method = RequestMethod.POST)
    public String insertNewSong(@RequestParam(value = "name") String name,
                                @RequestParam(value = "length") String length,
                                @RequestParam(value = "releaseDate") String releaseDate,
                                @RequestParam(value = "publisher") String publisher,
                                @RequestParam(value = "album") String album) {

        Map<String, String> params = new HashMap<>();
        params.put("name", name);
        // etc

        String json;
        Song data = new Song(name, length, releaseDate, publisher, album);
        logger.info("Sending Song dataset: {}, {}, {}, {}, {}", name, length, releaseDate, publisher, album);
        songRepository.insert(data);
        // postForObject?
        //json = template.getForObject(urlDB + "/song" + "/{name}", String.class, params);

        // return errorcode
        try {
            return ow.writeValueAsString(data);
        } catch (JsonProcessingException e) {
            logger.info(e.getMessage());
            return "Transaction failed! See server log for detail";
        }
    }

    @RequestMapping(value = "/publisher", method = RequestMethod.POST)
    public String insertNewPublisher(@RequestParam(value = "name") String name) {

        Map<String, String> params = new HashMap<>();
        params.put("name", name);
        // etc

        String json;
        Publisher data = new Publisher(name);
        logger.info("Sending Publisher dataset: {}", name);
        publisherRepository.insert(data);

        try {
            return ow.writeValueAsString(data);
        } catch (JsonProcessingException e) {
            logger.info(e.getMessage());
            return "Transaction failed! See server log for detail";
        }
    }

    @RequestMapping(value = "/song", method = RequestMethod.GET)
    public String getSong(@RequestParam(value = "name", required = false) String name,
                          @RequestParam(value = "length", required = false) String length,
                          @RequestParam(value = "releaseDate", required = false) String releaseDate,
                          @RequestParam(value = "publisher", required = false) String publisher,
                          @RequestParam(value = "album", required = false) String album) {

        Map<String, String> params = new HashMap<>();
        params.put("name", name);
        params.put("publisher", publisher);
        logger.info("Searching for Songs with name {}, length {}, releaseDate{}, publisher {}, album {}", name, length, releaseDate, publisher, album);
        String json;
        Set<Song> data;
        try {

            data = new HashSet<>(songRepository.findByName(name));
            data.addAll(songRepository.findByLength(length));
            data.addAll(songRepository.findByReleaseDate(releaseDate));
            data.addAll(songRepository.findByPublisher(publisher));
            data.addAll(songRepository.findByAlbum(album));

            json = ow.writeValueAsString(data);
        } catch (JsonProcessingException e) {
            json = "Search failed! See server log for detail";
            logger.info(e.getMessage());
        }
        logger.info("");

        return json;

    }

    @RequestMapping(value = "/album", method = RequestMethod.GET)
    public String getAlbum(@RequestParam(value = "name") String name) {

        Map<String, String> params = new HashMap<>();
        params.put("name", name);
        logger.info("Searching for album with name {}", name);
        String json;
        try {
            json = ow.writeValueAsString(albumRepository.findByName(name));
        } catch (JsonProcessingException e) {
            json = "Search failed! See server log for detail";
            logger.info(e.getMessage());
        }

        return json;

        //return "{\"id\": \"132sdafasdfas123as97ahjg\",\"name\": \"Run The Jewels 3\",\"totalLength\": \"51:27\",\"releaseDate\": \"2016-12-24\",\"genres\": [{\"id\": \"ldjflkejieij343l4l3jldjl\",\"name\": \"Hip hop/Rap\"}],\"tags\": [{\"id\": \"lflwlejelwkjkwejrkj4330\",\"name\": \"Fussballhymne\"},{\"id\": \"dkskjdldjlwdjljwldl7wd2\",\"name\": \"BVB\"}],\"songs\": [{\"id\": \"507f191e810c19729de860ea\",\"name\": \"Legends Has It\"}],\"artists\": [{\"id\": \"116fn30gttdbor64nd63hgkw\",\"name\": \"Run The Jewels\"}],\"publisher\": {\"id\": \"18b9t6dnr04zfdp37tnvopur\",\"name\": \"Run The Jewels, Inc.\"}}";
    }

    @RequestMapping(value = "/artist", method = RequestMethod.GET)
    public String getArtist(@RequestParam(value = "name") String name) {

        Map<String, String> params = new HashMap<>();
        params.put("name", name);
        logger.info("Searching for artist with name {}", name);
        String json;
        try {
            json = ow.writeValueAsString(artistRepository.findByName(name));
        } catch (JsonProcessingException e) {
            json = "Search failed! See server log for detail";
            logger.info(e.getMessage());
        }

        return json;

    }

    @RequestMapping(value = "/publisher", method = RequestMethod.GET)
    public String getPublisher(@RequestParam(value = "name") String name) {

        Map<String, String> params = new HashMap<>();
        params.put("name", name);
        logger.info("Searching for publisher with name {}", name);
        String json;
        try {
            json = ow.writeValueAsString(publisherRepository.findByName(name));
        } catch (JsonProcessingException e) {
            json = "Search failed! See server log for detail";
            logger.info(e.getMessage());
        }

        return json;
    }

    @RequestMapping(value = "/clear", method = RequestMethod.DELETE)
    public String clearRepository() {
        songRepository.deleteAll();
        artistRepository.deleteAll();
        publisherRepository.deleteAll();
        artistRepository.deleteAll();
        return "Cleared Repositories";
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}