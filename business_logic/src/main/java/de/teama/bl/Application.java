package de.teama.bl;

import com.fasterxml.jackson.databind.ObjectWriter;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientOptions;
import de.teama.bl.data.Song;
import de.teama.bl.data.User;
import org.json.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.TextCriteria;
import org.springframework.data.mongodb.core.query.TextQuery;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.*;

/*
TODO Authentication
TODO Comments
TODO Monitoring: Send Status
TODO Documentation
 */

@SpringBootApplication
@RestController
@CrossOrigin(origins = "*")
public class Application implements ApplicationRunner {

    @Autowired
    private SongRepository songRepository;

    @Autowired
    private ArtistRepository artistRepository;

    @Autowired
    private AlbumRepository albumRepository;

    @Autowired
    private ActiveSessionRepository sessions;

    private MongoClient mongoClient;
    private final Logger logger;
    private final ObjectMapper mapper;
    private final RestTemplate restTemplate;
    private MongoTemplate mongoTemplate;
    private String urlDB;
    private AliveStatus currentStatus;
    private ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();

    Application() {
        logger = LoggerFactory.getLogger(Application.class);

        mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);

        restTemplate = new RestTemplate();
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
                                @RequestParam(value = "album") String album) {

        Song data = new Song();
        logger.info("Sending Song dataset: {}, {}, {}, {}", name, length, releaseDate, album);
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

    @RequestMapping(value = "/msAliveSignal", method = RequestMethod.POST)
    public ResponseEntity<AliveStatus> addApp(@RequestBody AliveStatus app) {
        currentStatus = app;

        currentStatus.setStatus(AliveStatus.STATUS_ONLINE);
        currentStatus.setNoOfUser((int)sessions.count());

        logger.info("Received AliveSignal");
        logger.info("Event URL has been set to {}", currentStatus.getEventUrl());

        return new ResponseEntity<AliveStatus>(currentStatus, HttpStatus.OK);
    }

    @RequestMapping(value = "/song", method = RequestMethod.GET)
    public String getSong(@RequestParam(value = "name", required = false) String name,
                          @RequestParam(value = "length", required = false) String length,
                          @RequestParam(value = "releaseDate", required = false) String releaseDate,
                          @RequestParam(value = "publisher", required = false) String publisher,
                          @RequestParam(value = "album", required = false) String album) {

        logger.info("Searching for Songs with name {}, length {}, releaseDate{}, publisher {}, album {}", name, length, releaseDate, publisher, album);
        String json;
        Set<Song> data;
        try {

            data = new HashSet<>(songRepository.findByName(name));
            data.addAll(songRepository.findByLength(length));
            data.addAll(songRepository.findByReleaseDate(releaseDate));
            data.addAll(songRepository.findByAlbum(album));

            json = ow.writeValueAsString(data);
        } catch (JsonProcessingException e) {
            json = "Search failed! See server log for detail";
            logger.info(e.getMessage());
        }
        return json;

    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String search(@RequestParam(value = "term") String term) {

        logger.info("Searching database for term {}", term);
        logger.info("");
        JSONObject jsonObject;

        TextCriteria criteria = TextCriteria.forDefaultLanguage()
                .matchingAny(term);

        logger.info("Parsed Criteria {}", criteria.toString());
        logger.info("");

        Query query = TextQuery.queryText(criteria)
                .sortByScore()
                .with(new PageRequest(0, 5));

        logger.info("Created query {}, {}", query.toString(), Song.class.toString());
        logger.info("");

        List<Song> result = mongoTemplate.find(query, Song.class);

        logger.info("Retrieved result list {}", result.toString());
        logger.info("");
        jsonObject = new JSONObject(result);

        logger.info("done");
        logger.info("");

        //TODO Fulltext search https://spring.io/blog/2014/07/17/text-search-your-documents-with-spring-data-mongodb
        return jsonObject.toString();
    }

    @RequestMapping(value = "/album", method = RequestMethod.GET)
    public String getAlbum(@RequestParam(value = "name") String name) {

        logger.info("Searching for album with name {}", name);
        String json;
        try {
            json = ow.writeValueAsString(albumRepository.findByName(name));
        } catch (JsonProcessingException e) {
            json = "Search failed! See server log for detail";
            logger.info(e.getMessage());
        }
        return json;
    }

    @RequestMapping(value = "/artist", method = RequestMethod.GET)
    public String getArtist(@RequestParam(value = "name") String name) {

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

    @RequestMapping(value = "/clear", method = RequestMethod.DELETE)
    public String clearRepository() {
        songRepository.deleteAll();
        artistRepository.deleteAll();
        artistRepository.deleteAll();
        sessions.deleteAll();
        return "Cleared Repositories";
    }

    public void login(String username){
        logger.info("Current User with name {}: {}", username, sessions.findByName(username));
        if (sessions.findByName(username) == null){
            logger.info("Logging in {}", username);
            sessions.save(new User(username));
        }else{
            logger.info("User with name {} is already logged in.", username);
        }
    }

    public void logout(String username){
        if (sessions.findByName(username) != null){
            logger.info("Logging out {}", username);
            sessions.deleteByName(username);
        }else{
            logger.info("User {} is not logged in.", username);
        }
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}