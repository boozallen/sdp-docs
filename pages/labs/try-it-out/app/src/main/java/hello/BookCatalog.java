package hello;

import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class BookCatalog{

    private ArrayList<Book> bookList = new ArrayList<Book>();

    public ArrayList<Book> getBookList() {
        return bookList;
    }

    public void addBook(Book book){
        for (int i = 0; i < this.bookList.size() ; i++) {
            //Book already in bookList
            if (book.getIsbn() == (this.bookList.get(i).getIsbn())){
                this.bookList.get(i).incrementNumAvail();
                return;
            }
        }
        //Book not in book list
        bookList.add(book);
    }

    public void removeBook(Book book){

        for (int i = 0; i < this.bookList.size() ; i++) {
            //Book already in bookList
            if (book.getIsbn() == (this.bookList.get(i).getIsbn())){
                int numberBooks = this.bookList.get(i).decrementNumAvail();
                    if (numberBooks < 0){
                        this.bookList.remove(i);
                    }
                return;
            }
        }

    }

}