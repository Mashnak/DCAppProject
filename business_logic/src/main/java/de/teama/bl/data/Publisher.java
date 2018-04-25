package de.teama.bl.data;

public class Publisher {
  private String id;

  private String name;

  public Publisher(String name){
    this.name = name;
  }

  @Override
  public String toString() {
    return name;
  }
}
