package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/gorilla/mux"
	"github.com/moficodes/bookdata-api/datastore"
	newrelic "github.com/newrelic/go-agent"
)

var (
	books datastore.BookStore
	app   newrelic.Application
	err   error
)

func timeTrack(start time.Time, name string) {
	elapsed := time.Since(start)
	log.Printf("%s took %s", name, elapsed)
}

func init() {
	config := newrelic.NewConfig("apitester", "eu01xx419da656e48684fccb15fef6f07880a63a")
	app, err = newrelic.NewApplication(config)
	defer timeTrack(time.Now(), "file load")
	books = &datastore.Books{}
	books.Initialize()
}

func main() {
	r := mux.NewRouter()
	log.Println("bookdata api")
	api := r.PathPrefix("/api/v1").Subrouter()
	api.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "api v1")
	})
	api.HandleFunc("/books/authors/{author}", searchByAuthor).Methods(http.MethodGet)
	//api.HandleFunc(newrelic.WrapHandleFunc(app, "/books/authors/{author}", searchByAuthor)) // newrelic code, defunct
	api.HandleFunc("/books/book-name/{bookName}", searchByBookName).Methods(http.MethodGet)
	//api.HandleFunc(newrelic.WrapHandleFunc(app, "/books/book-name/{bookName}", searchByBookName)) // newrelic code, defunct
	api.HandleFunc("/book/isbn/{isbn}", searchByISBN).Methods(http.MethodGet)
	//api.HandleFunc(newrelic.WrapHandleFunc(app, "/book/isbn/{isbn}", searchByISBN)) // newrelic code, defunct
	api.HandleFunc("/book/isbn/{isbn}", deleteByISBN).Methods(http.MethodDelete)
	//api.HandleFunc(newrelic.WrapHandleFunc(app, "/book/isbn/{isbn}", deleteByISBN)) // newrelic code, defunct
	api.HandleFunc("/book", createBook).Methods(http.MethodPost)
	//api.HandleFunc(newrelic.WrapHandleFunc(app, "/book", createBook)) // newrelic code, defunct
	log.Fatalln(http.ListenAndServe(":8080", r))
}
