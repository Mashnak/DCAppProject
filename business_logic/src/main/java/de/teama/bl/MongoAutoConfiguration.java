package de.teama.bl;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.mongo.MongoProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import javax.annotation.PreDestroy;
import java.net.UnknownHostException;

@Configuration
@ConditionalOnClass(MongoClient.class)
@EnableConfigurationProperties(MongoProperties.class)
@ConditionalOnMissingBean(type = "org.springframework.data.mongodb.MongoDbFactory")
public class MongoAutoConfiguration {
    @Autowired
    private MongoProperties properties;

    @Autowired(required = false)
    private MongoClientOptions options;

    @Autowired
    private Environment environment;

    private MongoClient mongo;

    @PreDestroy
    public void close() {
        if (this.mongo != null) {
            this.mongo.close();
        }
    }

    @Bean
    @ConditionalOnMissingBean
    public MongoClient mongo() throws UnknownHostException {
        MongoClientOptions.Builder options_builder = new MongoClientOptions.Builder();
        options_builder.maxConnectionIdleTime(1000 * 60 * 4);
        MongoClientOptions options = options_builder.build();
        MongoClient mongo_db = new MongoClient ("192.168.99.100:27017", options);

      //  this.mongo = this.properties.createMongoClient(this.options, this.environment);
        return mongo_db;
    }
}