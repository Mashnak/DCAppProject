package de.teama.bl;

import com.mongodb.MongoClient;
import de.teama.bl.data.*;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.util.ErrorHandler;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.text.SimpleDateFormat;
import java.util.*;

/*
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
    private ArtistSongsRepository artistSongsRepository;

    @Autowired
    private ArtistAlbumsRepository artistAlbumsRepository;

    @Autowired
    private ActiveSessionRepository sessions;

    @Autowired
    private UserRepository registeredUsers;

    @Autowired
    private MongoClient mongoClient;

    private final Logger logger;
    private final ObjectMapper mapper;
    private final RestTemplate restTemplate;
    private String urlDB;
    private AliveStatus currentStatus;

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
        logger.info("Using databases: {}", mongoClient.getUsedDatabases());
        logger.info("");
    }

    /**
     * Returns a string and HTTP 200 if the service is alive.
     *
     * @return A Response Entity with a String in the body and HTTP Status 200
     */
    @RequestMapping(value = "/status", method = RequestMethod.GET)
    public ResponseEntity<String> getAlive() {
        return new ResponseEntity<>("No. 5 alive", HttpStatus.OK);
    }

    @RequestMapping(value = "/song", method = RequestMethod.POST)
    public ResponseEntity<Songs> insertNewSong(@RequestParam(value = "name") String name,
            @RequestParam(value = "length") String length, @RequestParam(value = "releaseDate") String releaseDate,
            @RequestParam(value = "lyrics") String lyrics, @RequestParam(value = "link") String link,
            @RequestParam(value = "genre") String genre, @RequestParam(value = "tag") String tag,
            @RequestParam(value = "img") String img, @RequestParam(value = "album") String album) {

        List<Link> links = new LinkedList<>();
        // JSONObject tmp = new JSONObject();
        // tmp.put("name", "TESTNAME");
        // tmp.put("url", link);
        // links.add(tmp);

        LinkedList<String> genres = new LinkedList<>(), tags = new LinkedList<>();
        genres.add(genre);
        tags.add(tag);

        Songs data = new Songs(name, length, releaseDate, lyrics, links, genres, tags, img, album);
        data.addLink("TESTNAME", link);
        logger.info("Saving Songs dataset: {}, {}, {}, {}, {}, {}, {}, {}, {}", name, length, releaseDate, lyrics, link,
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
        return new ResponseEntity<>(currentStatus, HttpStatus.OK);
    }

    /**
     * Registers a Users and enters it into the database. If the Username already
     * exists the database this returns 400 Bad request
     *
     * @param name     the desired unique Username
     * @param password the password of the User
     * @param admin    whether the Users is an admin or not
     * @return the created User
     */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ResponseEntity<Object> registerUser(@RequestParam(value = "name") String name,
            @RequestParam(value = "password") String password, @RequestParam(value = "isAdmin") String admin) {
        logger.info("Registering user with name {}", name);
        logger.info("");
        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        boolean isAdmin = Boolean.valueOf(admin);
        Users newUser = new Users(name, password, date, isAdmin);
        if (registeredUsers.findByName(name)!=null){
            logger.info("User {} already exists", name);
            logger.info("");
            try{
                heartbeat("BL_Register", "User " + name + " already exists", true);
            }catch (Exception e){
                logger.info("Heartbeat failed");
            }
            return new ResponseEntity<>("User already exists",HttpStatus.BAD_REQUEST);
        }
        registeredUsers.save(newUser);
        logger.info("User {} successfully registered", name);
        logger.info("");
        try{
            heartbeat("BL_Register", "User " + name + " successfully registered", false);
        }catch (Exception e){
            logger.info("Heartbeat failed");
        }
        return new ResponseEntity<>(newUser, HttpStatus.OK);
    }

    //tags

    /**
     * Adds a tag string to a specified song.
     *
     * @param name name of the song to be tagged
     * @param tag the tag string to be appended to the song
     * @return response entity with the updated song object as JSON
     */
    @RequestMapping(value = "/tag/song", method = RequestMethod.POST)
    public ResponseEntity<Songs> addTagToSong(@RequestParam(value = "name") String name,
            @RequestParam(value = "tag") String tag) {
        Songs result = songRepository.findByName(name);
        songRepository.delete(result);
        result.addTag(tag);
        songRepository.save(result);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * Adds a tag string to a specified album.
     *
     * @param name name of the album to be tagged
     * @param tag the tag string to be appended to the album
     * @return response entity with the updated album object as JSON
     */
    @RequestMapping(value = "/tag/album", method = RequestMethod.POST)
    public ResponseEntity<Albums> addTagToAlbum(@RequestParam(value = "name") String name,
            @RequestParam(value = "tag") String tag) {
        Albums result = albumRepository.findByName(name);
        albumRepository.delete(result);
        result.addTag(tag);
        albumRepository.save(result);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * Adds a tag string to a specified artist.
     *
     * @param name name of the artist to be tagged
     * @param tag the tag string to be appended to the artist
     * @return response entity with the updated artist object as JSON
     */
    @RequestMapping(value = "/tag/artist", method = RequestMethod.POST)
    public ResponseEntity<Artists> addTagToArtist(@RequestParam(value = "name") String name,
            @RequestParam(value = "tag") String tag) {
        Artists result = artistRepository.findByName(name);
        artistRepository.delete(result);
        result.addTag(tag);
        artistRepository.save(result);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    //favorites and friends

    /**
     * Adds a song to the favorites of a specified user. The specified user has to be logged in.
     *
     * If the user is not logged in ths returns 401 unauthorized
     * If no song is found under the specified name this returns 404 not found
     * @param name  the username of the user adding a favorite
     * @param song  the name of the song to be added
     * @return      The user with the updated playlist
     */
    @RequestMapping(value = "/favorite", method = RequestMethod.POST)
    public ResponseEntity<Object> addFavorite(@RequestParam(value = "user")String name,
                                              @RequestParam(value = "song")String song){
        if (sessions.findByName(name)!=null){
            logger.info("Found session for user {}", sessions.findByName(name).getName());
            logger.info("");
            if (songRepository.findByName(song)!=null) {
                logger.info("found song with name {}", song);
                logger.info("");
                Users user = registeredUsers.findByName(sessions.findByName(name).getName());
                user.addFavorite(song);
                registeredUsers.deleteByName(user.getName());
                registeredUsers.save(user);
                logger.info("saving {} as favorite for user {}", song, name);
                logger.info("");
                return new ResponseEntity<>(user, HttpStatus.OK);
            } else {
                return new ResponseEntity<>("No such song in database", HttpStatus.NOT_FOUND);
            }
        }else {
            return new ResponseEntity<>("User is not logged in", HttpStatus.UNAUTHORIZED);
        }
    }

    /**
     * Adds a user to the friends of a specified user. The adding user has to be logged in.
     * The added user has to be registered.
     *
     * If the user is not logged in ths returns 401 unauthorized
     * If no user is found under the specified name this returns 404 not found
     * @param name  the username of the user adding a favorite
     * @param friend  the name of the song to be added
     * @return      The user with the updated playlist
     */
    @RequestMapping(value = "/friend", method = RequestMethod.POST)
    public ResponseEntity<Object> addFriend(@RequestParam(value = "user")String name,
                                              @RequestParam(value = "friend")String friend){
        if (sessions.findByName(name)!=null){
            logger.info("Found session for user {}", sessions.findByName(name).getName());
            logger.info("");
            if (registeredUsers.findByName(friend)!=null) {
                logger.info("found user with name {}", friend);
                logger.info("");
                Users user = registeredUsers.findByName(registeredUsers.findByName(name).getName());
                user.addFriend(friend);
                registeredUsers.deleteByName(user.getName());
                registeredUsers.save(user);
                logger.info("saving {} as favorite for user {}", friend, name);
                logger.info("");
                return new ResponseEntity<>(user, HttpStatus.OK);
            } else {
                return new ResponseEntity<>("No such user registered in database", HttpStatus.NOT_FOUND);
            }
        }else {
            return new ResponseEntity<>("User is not logged in", HttpStatus.UNAUTHORIZED);
        }
    }

    // end of POST interfaces

    /**
     * Returns a list of Objects containing the given term in any of the relevant
     * text bast properties: name, length, release date, lyrics, genre, tag and
     * album.
     *
     * If nothing is found the result is an empty set.
     *
     * @param term the term to search for
     * @return a stringified Set of JSON Objects containing the search results
     */
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public ResponseEntity<String> search(@RequestParam(value = "term") String term) {

        logger.info("Searching for songs containing {}", term);
        // term = term.replace(" ","_");

        Set<Songs> songResults = new HashSet<>();
        songResults.addAll(songRepository.findByNameLike(term));
        // songResults.addAll(songRepository.findByLengthLike(term));
        // songResults.addAll(songRepository.findByReleaseDateLike(term));
        // songResults.addAll(songRepository.findByLyricsLike(term));
        // songResults.addAll(songRepository.findByGenreLike(term));
        songResults.addAll(songRepository.findByTagLike(term));
        // songResults.addAll(songRepository.findByAlbumLike(term));

        Set<Albums> albumResults = new HashSet<>();
        albumResults.addAll(albumRepository.findByNameLike(term));
        // albumResults.addAll(albumRepository.findByPublisherLike(term));
        // albumResults.addAll(albumRepository.findByGenreLike(term));
        albumResults.addAll(albumRepository.findByTagLike(term));

        Set<Artists> artistResults = new HashSet<>();
        artistResults.addAll(artistRepository.findByNameLike(term));
        artistResults.addAll(artistRepository.findByTagLike(term));

        int size = 0;
        size += songResults.size();
        size += albumResults.size();
        size += artistResults.size();

        String result = "[";

        result += "{\"songs\": [";

        if (songResults.size() > 0) {
            Songs[] songs = new Songs[songResults.size()];
            songs = songResults.toArray(songs);
            JSONObject artistSong = new JSONObject(songs[0]);
            JSONArray artists = new JSONArray();
            for (Artistsongs artist : artistSongsRepository.findBySong(songs[0].getName())) {
                artists.put(artist.getArtist());
            }
            artistSong.put("artists", artists);
            result += artistSong;
            for (int i = 1; i < songs.length; i++) {
                result += ",";
                artistSong = new JSONObject(songs[i]);
                artists = new JSONArray();
                for (Artistsongs artist : artistSongsRepository.findBySong(songs[0].getName())) {
                    artists.put(artist.getArtist());
                }
                artistSong.put("artists", artists);
                result += artistSong;
            }
        }

        result += "]}, {\"albums\": [";

        if (albumResults.size() > 0) {
            Albums[] albums = new Albums[albumResults.size()];
            albums = albumResults.toArray(albums);
            JSONObject artistAlbum = new JSONObject(albums[0]);
            JSONArray artists = new JSONArray();
            for (Artistalbums artist : artistAlbumsRepository.findByAlbum(albums[0].getName())) {
                artists.put(artist.getArtist());
            }
            artistAlbum.put("artists", artists);
            result += artistAlbum;
            for (int i = 1; i < albums.length; i++) {
                result += ",";
                artistAlbum = new JSONObject(albums[i]);
                artists = new JSONArray();
                for (Artistalbums artist : artistAlbumsRepository.findByAlbum(albums[i].getName())) {
                    artists.put(artist.getArtist());
                }
                artistAlbum.put("artists", artists);
                result += artistAlbum;
            }
        }

        result += "]}, {\"artists\": [";

        if (artistResults.size() > 0) {
            Artists[] artists = new Artists[artistResults.size()];
            artists = artistResults.toArray(artists);
            JSONObject artistAlbumSong = new JSONObject(artists[0]);
            JSONArray albums = new JSONArray();
            for (Artistalbums album : artistAlbumsRepository.findByArtist(artists[0].getName())) {
                albums.put(album.getAlbum());
            }
            artistAlbumSong.put("albums", albums);
            artistAlbumSong = new JSONObject(artists[0]);
            JSONArray songs = new JSONArray();
            for (Artistsongs song : artistSongsRepository.findByArtist(artists[0].getName())) {
                songs.put(song.getSong());
            }
            artistAlbumSong.put("songs", songs);

            result += artists[0].toString();
            for (int i = 1; i < artists.length; i++) {
                result += ",";
                artistAlbumSong = new JSONObject(artists[i]);
                albums = new JSONArray();
                for (Artistalbums album : artistAlbumsRepository.findByArtist(artists[i].getName())) {
                    albums.put(album.getAlbum());
                }
                artistAlbumSong.put("albums", albums);
                artistAlbumSong = new JSONObject(artists[i]);
                songs = new JSONArray();
                for (Artistsongs song : artistSongsRepository.findByArtist(artists[i].getName())) {
                    songs.put(song.getSong());
                }
                artistAlbumSong.put("songs", songs);
                result += artistAlbumSong;
            }
        }
        result += "]}]";
        logger.info("Found {} different results", size);
        logger.info("");
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * Returns a list of Song containing the given term in any of the relevant
     * text bast properties: name and tag.
     *
     * If nothing is found the result is an empty set.
     *
     * @param term the term to search for
     * @return a stringified Set of JSON Objects containing the search results
     */
    @RequestMapping(value = "/webSearch", method = RequestMethod.GET)
    public ResponseEntity<String> webSearch(@RequestParam(value = "term") String term) {

        logger.info("Searching for songs containing {}", term);
        // term = term.replace(" ","_");

        Set<Songs> songResults = new HashSet<>();
        songResults.addAll(songRepository.findByNameLike(term));
        // songResults.addAll(songRepository.findByLengthLike(term));
        // songResults.addAll(songRepository.findByReleaseDateLike(term));
        // songResults.addAll(songRepository.findByLyricsLike(term));
        // songResults.addAll(songRepository.findByGenreLike(term));
        songResults.addAll(songRepository.findByTagLike(term));
        // songResults.addAll(songRepository.findByAlbumLike(term));

        int size = 0;
        size += songResults.size();

        String result = "[";

        if (songResults.size() > 0) {
            Songs[] songs = new Songs[songResults.size()];
            songs = songResults.toArray(songs);
            JSONObject artistSong = new JSONObject(songs[0]);
            JSONArray artists = new JSONArray();
            for (Artistsongs artist : artistSongsRepository.findBySong(songs[0].getName())) {
                artists.put(artist.getArtist());
            }
            artistSong.put("artists", artists);
            result += artistSong;
            for (int i = 1; i < songs.length; i++) {
                result += ",";
                artistSong = new JSONObject(songs[i]);
                artists = new JSONArray();
                for (Artistsongs artist : artistSongsRepository.findBySong(songs[0].getName())) {
                    artists.put(artist.getArtist());
                }
                artistSong.put("artists", artists);
                result += artistSong;
            }
        }

        result += "]";
        logger.info("Found {} different results", size);
        logger.info("");
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /**
     * Validates the credentials, a username and a password, of a user. If these
     * credentials are correct, the user is logged in and will be saved as an active
     * session.
     *
     * If the user is not registered this returns 404 not found. If the password is
     * incorrect this returns 401 unauthorized.
     *
     * @param name     the username of the user logging in
     * @param password the password of the user
     * @return the user object that has been logged in
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ResponseEntity<Object> loginUser(@RequestParam(value = "name") String name,
            @RequestParam(value = "password") String password) {
        Users user = registeredUsers.findByName(name);
        try {
            if (user.getPassword().equals(password)) {
                login(name);
                return new ResponseEntity<>(user, HttpStatus.OK);
            } else {
                try{
                    heartbeat("BL_Login", "Invalid password",true);
                }catch (Exception e){
                    logger.info("Heartbeat failed");
                }
                return new ResponseEntity<>("Invalid password", HttpStatus.UNAUTHORIZED);
            }
        } catch (NullPointerException e) {
            try{
                heartbeat("BL_Login", "Invalid username",true);
            }catch (Exception ex){
                logger.info("Heartbeat failed");
            }
            return new ResponseEntity<>("Invalid username", HttpStatus.NOT_FOUND);
        }
    }

    /**
     * Logs out the user with the given name and ends its session
     *
     * @param name the username of the user logging out
     * @return the user object that has been logged out
     */
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public ResponseEntity<Object> logoutUser(@RequestParam(value = "name") String name) {
        Users user = registeredUsers.findByName(name);
        logout(name);
        return new ResponseEntity<>(user.toString(), HttpStatus.OK);
    }

    /**
     * retrieves a song from the database, adds the artists and returns it to the
     * requester.
     *
     * if no song is found this returns 404 not found
     *
     * @param name the unique name of the song to find
     * @return a JSON Object with the requested song
     */
    @RequestMapping(value = "/song", method = RequestMethod.GET)
    public ResponseEntity<String> getSong(@RequestParam(value = "name", required = false) String name) {
        logger.info("Searching for Song with name {}", name);
        logger.info("");
        try{
            heartbeat("BL_Get_Request", "Searching for Song with name " + name,false);
        }catch (Exception e){
            logger.info("Heartbeat failed");
        }
        // name = name.replace(" ", "_");
        Songs result = songRepository.findByName(name);
        JSONObject artistSong = new JSONObject(result);

        JSONArray artists = new JSONArray();
        for (Artistsongs artist : artistSongsRepository.findBySong(result.getName())) {
            artists.put(artist.getArtist());
        }
        artistSong.put("artists", artists);

        if (result == null) {
            try{
                heartbeat("BL_Get_Request", "No song with name " + name + " in database",true);
            }catch (Exception e){
                logger.info("Heartbeat failed");
            }
            return new ResponseEntity<>("No song with this name in database", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(artistSong.toString(), HttpStatus.OK);
    }


    @RequestMapping(value = "/user", method = RequestMethod.GET)
    public ResponseEntity<String> getUser(@RequestParam(value = "name") String name) {
        logger.info("Searching for User with name {}", name);
        logger.info("");
        Users result = registeredUsers.findByName(name);

        if (result == null) {
            try{
                heartbeat("BL_Get_Request", "No user with name " + name + " in database",true);
            }catch (Exception e){
                logger.info("Heartbeat failed");
            }
            return new ResponseEntity<>("No user with this name in database", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(result.toString(), HttpStatus.OK);
    }

    @RequestMapping(value = "/album", method = RequestMethod.GET)
    public ResponseEntity<String> getAlbum(@RequestParam(value = "name") String name) {
        logger.info("Searching for album with name {}", name);
        logger.info("");
        // name = name.replace(" ","_");
        Albums result = albumRepository.findByName(name);
        JSONObject artistAlbum = new JSONObject(result);

        JSONArray artists = new JSONArray();
        for (Artistalbums artist : artistAlbumsRepository.findByAlbum(result.getName())) {
            artists.put(artist.getArtist());
        }
        artistAlbum.put("artists", artists);

        JSONArray songs = new JSONArray();
        for (Songs song : composeAlbum(name)) {
            songs.put(song.getName());
        }
        artistAlbum.put("songs", songs);

        return new ResponseEntity<>(artistAlbum.toString(), HttpStatus.OK);
    }

    @RequestMapping(value = "/artist", method = RequestMethod.GET)
    public ResponseEntity<String> getArtist(@RequestParam(value = "name") String name) {
        logger.info("Searching for artist with name {}", name);
        logger.info("");
        // name = name.replace(" ","_");
        Artists result = artistRepository.findByName(name);
        JSONObject artistAlbumSong = new JSONObject(result);

        JSONArray albums = new JSONArray();
        for (String album : composeAlbumsOfArtist(name)) {
            albums.put(album);
        }
        artistAlbumSong.put("albums", albums);

        return new ResponseEntity<>(artistAlbumSong.toString(), HttpStatus.OK);
    }


    @RequestMapping(value = "/random", method = RequestMethod.GET)
    public ResponseEntity<Object> getRandomSong(@RequestParam(value = "count") String count) {
        int cnt;
        Set<Songs> songResult;
        try {
            cnt = Integer.parseInt(count);
            songResult = new HashSet<>(cnt);
        } catch (NumberFormatException e) {
            return new ResponseEntity<>("Received invalid integer", HttpStatus.BAD_REQUEST);
        }
        logger.info("Generating list of {} random Songs", cnt);

        songResult.addAll(songRepository.findAll());
        // for (Songs song : songRepository.findAll()){
        // if (cnt <= 0){
        // break;
        // }
        // JSONObject artistSong = new JSONObject(song);
        // JSONArray artists = new JSONArray();
        // for (Artists artist : artistSongsRepository.findBySong(song.getName())){
        // artists.put(artist);
        // }
        // artistSong.put("artists", artists);
        // result.add(artistSong);
        // cnt--;
        // }

        String result = "[";
        Songs[] songs = new Songs[cnt];
        songs = songResult.toArray(songs);
        JSONObject artistSong = new JSONObject(songs[0]);
        JSONArray artists = new JSONArray();
        for (Artistsongs artist : artistSongsRepository.findBySong(songs[0].getName())) {
            artists.put(artist.getArtist());
        }
        artistSong.put("artists", artists);
        result += artistSong;
        for (int i = 1; i < songs.length; i++) {
            result += ",";
            artistSong = new JSONObject(songs[i]);
            artists = new JSONArray();
            for (Artistsongs artist : artistSongsRepository.findBySong(songs[0].getName())) {
                artists.put(artist.getArtist());
            }
            artistSong.put("artists", artists);
            result += artistSong;
        }
        result += "]";

        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    // end of GET interfaces

    @RequestMapping(value = "/clear", method = RequestMethod.DELETE)
    public ResponseEntity<String> clearRepositories() {
        songRepository.deleteAll();
        artistRepository.deleteAll();
        albumRepository.deleteAll();
        sessions.deleteAll();
        registeredUsers.deleteAll();
        return new ResponseEntity<>("Cleared Repositories", HttpStatus.OK);
    }

    @RequestMapping(value = "/artistAlbum", method = RequestMethod.GET)
    public ResponseEntity<List<Artistalbums>> getArtistAlbums() {
        return new ResponseEntity<>(artistAlbumsRepository.findAll(), HttpStatus.OK);
    }

    @RequestMapping(value = "/addArtistAlbum", method = RequestMethod.POST)
    public ResponseEntity<Artistalbums> addArtistAlbum(@RequestParam(value = "artist") String artist,
            @RequestParam(value = "album") String album) {
        Artistalbums result = new Artistalbums(artist, album);
        artistAlbumsRepository.save(result);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    // end of REST interfaces

    public void login(String username) {
        logger.info("Current Users with name {}: {}", username, sessions.findByName(username));
        if (sessions.findByName(username) == null) {
            logger.info("Logging in {}", username);
            logger.info("");
            try{
                heartbeat("BL_Login", "Logging in " + username,false);
            }catch (Exception e){
                logger.info("Heartbeat failed");
            }
            Sessions user = registeredUsers.findByName(username).createSession();
            sessions.save(user);
        } else {
            logger.info("Users with name {} is already logged in.", username);
            logger.info("");
        }
    }

    public void logout(String username) {
        if (sessions.findByName(username) != null) {
            logger.info("Logging out {}", username);
            logger.info("");
            try{
                heartbeat("BL_Login", "Logging out " + username,false);
            }catch (Exception e){
                logger.info("Heartbeat failed");
            }
            sessions.deleteByName(username);
        } else {
            logger.info("Users {} is not logged in.", username);
            logger.info("");
        }
    }

    public Set<Songs> composeAlbum(String name) {
        Set<Songs> result = new HashSet<>();
        result.addAll(songRepository.findByAlbum(name));
        return result;
    }

    public Set<String> composeAlbumsOfArtist(String name) {
        Set<String> result = new HashSet<>();
        for (Artistalbums album : artistAlbumsRepository.findByArtist(name)) {
            result.add(album.getAlbum());
        }
        return result;
    }

    public Set<String> composeSongsOfArtist(String name) {
        Set<String> result = new HashSet<>();
        for (Artistsongs song : artistSongsRepository.findByArtist(name)) {
            result.add(song.getSong());
        }
        return result;
    }

    public void heartbeat(String name, String desc, Boolean error){
        restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
        restTemplate.getMessageConverters().add(new StringHttpMessageConverter());

        HeartbeatObject beat = new HeartbeatObject(name, desc, error,
                currentStatus.getMsID(), currentStatus.getAppID(), "");

        Map<String,String> vars = new HashMap<>();
        vars.put("eventName", name);
        vars.put("description", desc);
        vars.put("errorTag", error.toString());
        vars.put("microserviceID", currentStatus.getMsID());
        vars.put("appID", currentStatus.getAppID());
        vars.put("timestamp", "");


        try {
            restTemplate.postForObject(currentStatus.getEventUrl(),beat,HeartbeatObject.class, vars);
        }catch (HttpClientErrorException e){
            logger.error("Error: " + e.getResponseBodyAsString());
            logger.info("");
        }catch (Exception e){
            logger.error("Error: " + e.getMessage());
            logger.info("");
        }
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}
