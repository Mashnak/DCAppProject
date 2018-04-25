package de.teama.bl.data;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.atomic.AtomicLong;

@SpringBootApplication
@RestController
public class Application {

  private final AtomicLong ID = new AtomicLong();

  @RequestMapping("/")
  public String home() {
    return "Hello Docker World";
  }

  @RequestMapping(value = "/song", method = RequestMethod.GET)
  public String song(
          @RequestParam(value = "name", defaultValue = "Default") String name,
          @RequestParam(value = "length", defaultValue = "12:34") String length,
          @RequestParam(value = "releaseDate", defaultValue = "01.01.2000") String releaseDate,
          @RequestParam(value = "publisher", defaultValue = "Another one") String publisher,
          @RequestParam(value = "album", defaultValue = "Some Album") String album
          ){
    Song song = new Song (String.format("%s", ID.incrementAndGet()),
            String.format(name),
            String.format(length),
            String.format(releaseDate),
            publisher,
            album
    );
    ObjectMapper mapper = new ObjectMapper();
    mapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
    String json = "Empty";
    try{
    json = mapper.writeValueAsString(song);
    }
    catch (JsonProcessingException e){
      e.printStackTrace();
    }
    return json;
    /*
    return new Song (String.format("%s", ID.incrementAndGet()),
            String.format(name),
            String.format(length),
            String.format(releaseDate),
            publisher,
            album
    );*/
  }

  // @RequestMapping(value = "/user", method = RequestMethod.POST)

  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }

}
