package de.teama.bl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import de.teama.bl.data.Song;
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
public class Application implements ApplicationRunner {

    private final Logger logger;
    private final ObjectMapper mapper;
    private final RestTemplate template;
    private String urlDB = "http://";

    Application() {
        logger = LoggerFactory.getLogger(Application.class);

        mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);

        template = new RestTemplate();
    }

    @Override
    public void run(ApplicationArguments args) {
        urlDB = String.format("http://%s:%s", args.getOptionValues("DB.ip").get(0), args.getOptionValues("DB.port").get(0));
        logger.info("Sending db requests to {}", urlDB);
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

        Map<String ,String > params = new HashMap<>();
        params.put("name", name);
        //etc

        String json;
        // postForObject?
        json = template.getForObject(
                urlDB +
                "/song" +
                "/{name}",
                String.class, params);

        // return errorcode
        return "";
    }

    @RequestMapping(value = "/song", method = RequestMethod.GET)
    public String getSong(
            @RequestParam(value = "id") String id)
    {
        return template.getForObject(urlDB + "/song/" + id, String.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}
