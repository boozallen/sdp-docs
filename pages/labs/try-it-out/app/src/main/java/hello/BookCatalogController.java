package hello;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;

@RestController
public class BookCatalogController{

    @Autowired
    private BookCatalog catalog;


    @RequestMapping("/catalog")
    public ArrayList<Book> getCatalog() {
        return catalog.getBookList();

    }

    @RequestMapping(method= RequestMethod.POST, value="/catalog")
    public void addBook(@RequestBody Book book){
        catalog.addBook(book);
    }

}