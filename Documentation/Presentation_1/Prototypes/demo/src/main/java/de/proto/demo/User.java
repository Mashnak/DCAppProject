package de.proto.demo;

public class User {
    private static final String template = "{\"nickname\":\"%s\", \"firstName\":\"%s\", \"familyName\":\"%s\", \"age\":\"%s\"}";

    private String name;
    private String firstName;
    private String familyName;
    private int age;

    public User(String name, String firstName, String familyName, int age) {
        this.name = name;
        this.firstName = firstName;
        this.familyName = familyName;
        this.age = age;
    }

    public String toJSON() {
        return String.format(template, name, firstName, familyName, age);
    }
}
