package de.proto.demo;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.test.context.junit4.SpringRunner;

import static org.assertj.core.api.Assertions.assertThat;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = DemoApplication.class, webEnvironment= SpringBootTest.WebEnvironment.RANDOM_PORT)
public class DemoApplicationTests {
	@Autowired
	private TestRestTemplate restTemplate;

	@Test
	public void exampleTest() {
		String body = restTemplate.getForObject("/", String.class);
		assertThat(body).isEqualTo("Hello World!");
	}

    @Test
    public void userKhaledTest() {
        String body = restTemplate.getForObject("/user?name=Khaled", String.class);
        assertThat(body).isEqualTo("{ \"nickname\": \"BrudeMussLos\", \"firstName\": \"Khaled\", \"familyName\": \"Ahmed\", \"age\": \"23\" }");
    }

    @Test
    public void userTimurTest() {
        String body = restTemplate.getForObject("/user?name=Timur", String.class);
        assertThat(body).isEqualTo("{ \"nickname\": \"MelonHead\", \"firstName\": \"Timur\", \"familyName\": \"Bahadir\", \"age\": \"22\" }");
    }

    @Test
    public void userMarkusTest() {
        String body = restTemplate.getForObject("/user?name=Markus", String.class);
        assertThat(body).isEqualTo("{ \"nickname\": \"KeineAhnung\", \"firstName\": \"Markus\", \"familyName\": \"Schmidgall\", \"age\": \"30\" }");
    }

    @Test
    public void userSimonTest() {
        String body = restTemplate.getForObject("/user?name=Simon", String.class);
        assertThat(body).isEqualTo("{ \"nickname\": \"BicMag\", \"firstName\": \"Simon\", \"familyName\": \"Winterhalter\", \"age\": \"23\" }");
    }
}
