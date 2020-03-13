# bookdata-api

This is my take on repurposing this for light load tests and pod-to-pod testing in OpenShift/Kubernetes.  This is a demo application showing how to build rest api using golang.

## Documentation
- `GET api/v1/books/authors/{author}` searchByAuthor
- `GET api/v1/books/book-name/{bookName}` searchByBookName
- `GET api/v1/book/isbn/{isbn}` searchByISBN
- `DELETE api/v1/book/isbn/{isbn}` deleteByISBN
- `POST api/v1/book` createBook


### Building and Deploying

I had to modify the go.mod and many paths in the code pointing at github.com/.../bookdata/api to bookdata-api as the Repo currently is.

I also had to run 
`oc adm policy add-scc-to-user anyuid -z default` on OpenShift to get the container to run correctly

I also coud not get an imagestream working correctly, but did with:
`oc import-image --confirm norcinmo/api-tester:latest`


`docker build --tag norcinmo/api-tester:1.0.11 api-tester`
`docker push norcinmo/api-tester:1.0.11`


