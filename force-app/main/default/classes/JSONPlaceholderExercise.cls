public class JSONPlaceholderExercise {
    private static final String BASE_URL = 'https://jsonplaceholder.typicode.com';

    /**
     * Exercise 1: Implement a GET request to fetch a post by ID
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to fetch
     * @return String - The JSON response from the API
     */
    public static PostResponse getPostById(Integer postId) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(BASE_URL + '/posts/' + postId);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HttpResponse response = http.send(request);
        PostResponse body = (PostResponse) JSON.deserialize(response.getBody(), PostResponse.class);

        return body;
    }

    /**
     * Exercise 2: Implement a POST request to create a new post
     * Endpoint: /posts
     * @param title - The title of the post
     * @param body - The body content of the post
     * @param userId - The user ID creating the post
     * @return String - The JSON response from the API
     */
    public static PostResponse createPost(String title, String body, Integer userId) {
        String postData = JSON.serialize(new Map<String, Object>{
            'title' => title,
            'body' => body,
            'userId' => userId
        });

        HttpRequest request = new HttpRequest();
        request.setEndpoint(BASE_URL + '/posts');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(postData);


        Http http = new Http();
        HttpResponse response = http.send(request);
        PostResponse responseBody = (PostResponse) JSON.deserialize(response.getBody(), PostResponse.class);
        return responseBody;
    }

    /**
     * Exercise 3: Implement a PUT request to update a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to update
     * @param title - The new title
     * @param body - The new body content
     * @param userId - The user ID
     * @return String - The JSON response from the API
     */
    public static PostResponse updatePost(Integer postId, String title, String body, Integer userId) {
        String updatedPostData = JSON.serialize(new Map<String, Object>{
            'postId' => postId,
            'title' => title,
            'body' => body,
            'userId' => userId
        });
        HttpRequest request = new HttpRequest();
        request.setEndpoint(BASE_URL + '/posts/' + postId);
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(updatedPostData);

        Http http = new Http();
        HttpResponse response = http.send(request);
        PostResponse responseBody = (PostResponse) JSON.deserialize(response.getBody(), PostResponse.class);
        return responseBody;
    }

    /**
     * Exercise 4: Implement a PATCH request to partially update a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to patch
     * @param title - The new title (can be null)
     * @return String - The JSON response from the API
     */
    public static PostResponse patchPostTitle(Integer postId, String title) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(BASE_URL + '/posts/' + postId);
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSON.serialize(new Map<String, Object>{'title' => title}));

        Http http = new Http();
        HttpResponse response = http.send(request);
        PostResponse responseBody = (PostResponse) JSON.deserialize(response.getBody(), PostResponse.class);
        return responseBody;
    }

    /**
     * Exercise 5: Implement a DELETE request to remove a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to delete
     * @return Integer - The HTTP status code from the response
     */
    public static Integer deletePost(Integer postId) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(BASE_URL + '/posts/' + postId);
        request.setMethod('DELETE');
        request.setHeader('Content-Type', 'application/json');

        HttpResponse response = new Http().send(request);
        Integer responseStatusCode = response.getStatusCode();
        return responseStatusCode;
    }

    public class PostResponse {
        public Integer id;
        public String title;
        public String body;
        public Integer userId;
    }
}
