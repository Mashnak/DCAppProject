package de.teama.bl.data;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.concurrent.atomic.AtomicLong;

@SpringBootApplication
@RestController
public class Application {

  private final AtomicLong ID = new AtomicLong();

  @RequestMapping("/")
  public String home() {
    return "Hello Docker World";
  }

  @RequestMapping("/song")
  public Song song(
          @RequestParam(value = "name", defaultValue = "Default") String name,
          @RequestParam(value = "length", defaultValue = "12:34") String length,
          @RequestParam(value = "releaseDate", defaultValue = "01.01.2000") String releaseDate,
          @RequestParam(value = "publisher", defaultValue = "Another one") String publisher,
          @RequestParam(value = "album", defaultValue = "Some Album") String album
          ){
    return new Song (String.format("%s", ID.incrementAndGet()),
            String.format(name),
            String.format(length),
            String.format(releaseDate),
            publisher,
            album
    );
  }

  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }

}
