package de.proto.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Controller
@EnableAutoConfiguration
public class DemoApplication {
	RestTemplate restTemplate = new RestTemplate();
	private static final Logger log = LoggerFactory.getLogger(DemoApplication.class);

	@RequestMapping("/")
	@ResponseBody
	String home() {
		return "Hello World!";
	}

	// adr:8080/user?name=user
	@RequestMapping("/user")
	@ResponseBody
	String get_user(@RequestParam(value="name", defaultValue="World") String name) {
		ResponseEntity<String> user
				= restTemplate.getForEntity("http://localhost:3000/user?name=" + name, String.class);
		return user.getBody();
	}

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}
}
