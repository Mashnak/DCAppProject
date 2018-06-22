package de.teama.bl;

import com.fasterxml.jackson.databind.ObjectWriter;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientOptions;
import de.teama.bl.data.Album;
import de.teama.bl.data.Artist;
import de.teama.bl.data.Song;
import de.teama.bl.data.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.text.SimpleDateFormat;
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

    @Autowired
    private UserRepository registeredUsers;

    @Autowired
    private MongoClient mongoClient;

    private final Logger logger;
    private final ObjectMapper mapper;
    private final RestTemplate restTemplate;
    // private MongoTemplate mongoTemplate;
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
        urlDB = String.format("%s:%s", args.getOptionValues("DB.ip").get(0), args.getOptionValues("DB.port").get(0));
        logger.info("Sending db requests to {}", urlDB);
        // mongoClient = new MongoClient(urlDB);
        logger.info("Using databases: {}", mongoClient.getUsedDatabases());
        logger.info("");
    }

    /**
     * Returns a string and HTPP 200 if the service is alive.
     *
     * @return A Response Entity with a String in the body and HTTP Status 200
     */
    @RequestMapping(value = "/status", method = RequestMethod.GET)
    public ResponseEntity<String> getAlive() {
        return new ResponseEntity<>("No. 5 alive", HttpStatus.OK);
    }

    @RequestMapping(value = "/song", method = RequestMethod.POST)
    public ResponseEntity<Song> insertNewSong(@RequestParam(value = "name") String name,
            @RequestParam(value = "length") String length, @RequestParam(value = "releaseDate") String releaseDate,
            @RequestParam(value = "lyrics") String lyrics, @RequestParam(value = "link") String link,
            @RequestParam(value = "genre") String genre, @RequestParam(value = "tag") String tag,
            @RequestParam(value = "img") String img, @RequestParam(value = "album") String album) {

        LinkedList<String> links = new LinkedList<>();
        links.add(link);

        Song data = new Song(name, length, releaseDate, lyrics, links, genre, tag, img, album);
        logger.info("Saving Song dataset: {}, {}, {}, {}, {}, {}, {}, {}, {}", name, length, releaseDate, lyrics, link,
                genre, tag, img, album);
        logger.info("");
        songRepository.insert(data);
        return new ResponseEntity<>(data, HttpStatus.CREATED);
    }

    /**
     * Returns a Response Entity for monitoring purposes, containing the current app
     * status and the number of users currently logged in, as well as IDs and a URL
     * required by Team D: Monitoring.
     *
     * @param app a template object to be filled out
     * @return the filled out template
     * @see AliveStatus of Team D: Monitoring
     */
    @RequestMapping(value = "/msAliveSignal", method = RequestMethod.POST)
    public ResponseEntity<AliveStatus> addApp(@RequestBody AliveStatus app) {
        currentStatus = app;

        currentStatus.setStatus(AliveStatus.STATUS_ONLINE);
        currentStatus.setNoOfUser((int) sessions.count());

        logger.info("Received AliveSignal");
        logger.info("Event URL has been set to {}", currentStatus.getEventUrl());
        logger.info("");
        // mongoTemplate = new MongoTemplate(mongoClient, currentStatus.getAppID());
        return new ResponseEntity<>(currentStatus, HttpStatus.OK);
    }

    /**
     * Registers a User and enters it into the database. If the Username already
     * exists the database returns 500 Bad request
     *
     * @param name     the desired unique Username
     * @param password the password of the User
     * @param admin    whether the User is an admin or not
     * @return the created User
     */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ResponseEntity<User> registerUser(@RequestParam(value = "name") String name,
            @RequestParam(value = "password") String password, @RequestParam(value = "isAdmin") String admin) {
        // TODO Message Body or Parameters???
        logger.info("Registering user with name {}", name);
        logger.info("");
        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        boolean isAdmin = Boolean.valueOf(admin);
        User newUser = new User(name, password, date, isAdmin);
        return new ResponseEntity<>(newUser, HttpStatus.OK);
    }

    // end of POST interfaces

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public ResponseEntity<Set<Song>> search(@RequestParam(value = "term") String term) {

        logger.info("Searching for songs containing {}", term);

        Set<Song> result = new HashSet<>();

        result.addAll(songRepository.findByNameLike(term));
        result.addAll(songRepository.findByLengthLike(term));
        result.addAll(songRepository.findByReleaseDateLike(term));
        result.addAll(songRepository.findByLyricsLike(term));
        result.addAll(songRepository.findByGenreLike(term));
        result.addAll(songRepository.findByTagLike(term));
        result.addAll(songRepository.findByAlbumLike(term));

        logger.info("Found {} different results", result.size());
        logger.info("");

        // TODO Add every property of every entity
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @RequestMapping(value = "/song", method = RequestMethod.GET)
    public ResponseEntity<Object> getSong(@RequestParam(value = "name", required = false) String name) {
        logger.info("Searching for Song with name {}", name);
        logger.info("");
        Song result = songRepository.findByName(name);
        if (result == null) {
            return new ResponseEntity<>("No song with this name in database", HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @RequestMapping(value = "/album", method = RequestMethod.GET)
    public ResponseEntity<Album> getAlbum(@RequestParam(value = "name") String name) {
        logger.info("Searching for album with name {}", name);
        logger.info("");
        return new ResponseEntity<>(albumRepository.findByName(name), HttpStatus.OK);
    }

    @RequestMapping(value = "/artist", method = RequestMethod.GET)
    public ResponseEntity<Artist> getArtist(@RequestParam(value = "name") String name) {
        logger.info("Searching for artist with name {}", name);
        logger.info("");
        return new ResponseEntity<>(artistRepository.findByName(name), HttpStatus.OK);
    }

    @RequestMapping(value = "/random", method = RequestMethod.GET)
    public ResponseEntity<Set<Song>> getRandomSong(@RequestParam(value = "count") String count) {
        int cnt = 0;
        Set<Song> result = new HashSet<>(cnt);
        try {
            cnt = Integer.parseInt(count);
        } catch (NumberFormatException e) {
            return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
        }
        logger.info("Generating list of {} random Songs");

        result.addAll(songRepository.findAll());

        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    // end of GET interfaces

    @RequestMapping(value = "/clear", method = RequestMethod.DELETE)
    public ResponseEntity<String> clearRepositories() {
        songRepository.deleteAll();
        artistRepository.deleteAll();
        artistRepository.deleteAll();
        sessions.deleteAll();
        return new ResponseEntity<>("Cleared Repositories", HttpStatus.OK);
    }

    // end of REST interfaces

    public void login(String username) {
        logger.info("Current User with name {}: {}", username, sessions.findByName(username));
        if (sessions.findByName(username) == null) {
            logger.info("Logging in {}", username);
            logger.info("");
            sessions.save(new User(username));
        } else {
            logger.info("User with name {} is already logged in.", username);
            logger.info("");
        }
    }

    public void logout(String username) {
        if (sessions.findByName(username) != null) {
            logger.info("Logging out {}", username);
            logger.info("");
            sessions.deleteByName(username);
        } else {
            logger.info("User {} is not logged in.", username);
            logger.info("");
        }
    }

    public Set<Song> composeAlbum(String name) {
        Set<Song> result = new HashSet<>();
        result.addAll(songRepository.findByAlbum(name));
        return result;
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}
