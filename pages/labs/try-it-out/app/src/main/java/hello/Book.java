package hello;

public class Book{

    private String name;

    private String author;


    private long isbn;

    private Double price;

    private int numAvail;

    public Book(String name, String author, long isbn, Double price, int numAvail) {
        this.name = name;
        this.isbn = isbn;
        this.author = author;
        this.price = price;
        this.numAvail = numAvail;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getIsbn() {
        return isbn;
    }

    public void setIsbn(long isbn) {
        this.isbn = isbn;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public int getNumAvail() {
        return numAvail;
    }

    public int incrementNumAvail(){
        this.numAvail = this.numAvail + 1;
        return this.numAvail;
    }

    public int decrementNumAvail(){
        this.numAvail = this.numAvail - 1;
        return this.numAvail;
    }

    public void setNumAvail(int numAvail) {
        this.numAvail = numAvail;
    }
}